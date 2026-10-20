#Interface for the Airman Readiness System
#Simple Tkinter front-end for the PSQL database on the backend
#The SQL scripts create and populate the database, while UI connects to existing db and displays results
import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import psycopg2


# Default connection values.
# The user can accept these values or type different ones when the program starts.
#Port 5432 is the default PSQL port.
DEFAULT_HOST = "cs.sierracollege.edu"
DEFAULT_DATABASE = "mmarks3"
DEFAULT_USER = "mmarks3"
DEFAULT_PORT = "5432"

#Main app class
class AirmanReadinessApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Airman Readiness System")
        self.root.geometry("1150x650")

        self.getLoginInfo()
        self.createLayout()

    #Login and connection info
    def getLoginInfo(self):
        self.dbHost = simpledialog.askstring(
            "Database Host",
            "Enter database host:",
            initialvalue=DEFAULT_HOST
        )

        self.dbName = simpledialog.askstring(
            "Database Name",
            "Enter database name:",
            initialvalue=DEFAULT_DATABASE
        )

        self.dbUser = simpledialog.askstring(
            "Database Username",
            "Enter database username:",
            initialvalue=DEFAULT_USER
        )

        self.dbPort = simpledialog.askstring(
            "Database Port",
            "Enter database port:",
            initialvalue=DEFAULT_PORT
        )

        self.dbPassword = simpledialog.askstring(
            "Database Password",
            "Enter database password:",
            show="*"
        )

    #Method for the Database Connection
    def getConnection(self):
        return psycopg2.connect(
            host=self.dbHost,
            database=self.dbName,
            user=self.dbUser,
            password=self.dbPassword,
            port=self.dbPort
        )

    #Run SQL Query
    def runQuery(self, query):
        try:
            connection = self.getConnection()
            cursor = connection.cursor()
            cursor.execute(query)

            columns = [description[0] for description in cursor.description]
            rows = cursor.fetchall()

            cursor.close()
            connection.close()

            self.displayResults(columns, rows)

        except Exception as error:
            messagebox.showerror("Database Error", str(error))

    #Display Query Results
    def displayResults(self, columns, rows):
        for item in self.resultsTable.get_children():
            self.resultsTable.delete(item)

        self.resultsTable["columns"] = columns
        self.resultsTable["show"] = "headings"

        for column in columns:
            self.resultsTable.heading(column, text=column)
            self.resultsTable.column(column, width=160, anchor="w")

        for row in rows:
            self.resultsTable.insert("", "end", values=row)

    #User Interface Layout
    def createLayout(self):
        titleLabel = tk.Label(
            self.root,
            text="Airman Readiness System",
            font=("Arial", 18, "bold")
        )
        titleLabel.pack(pady=10)

        subtitleLabel = tk.Label(
            self.root,
            text="Python Tkinter front-end connected to PostgreSQL backend",
            font=("Arial", 11)
        )
        subtitleLabel.pack(pady=5)

        buttonFrame = tk.Frame(self.root)
        buttonFrame.pack(pady=10)

        tk.Button(
            buttonFrame,
            text="Airman Readiness Overview",
            width=28,
            command=self.showReadinessOverview
        ).grid(row=0, column=0, padx=5, pady=5)

        tk.Button(
            buttonFrame,
            text="Missing Required Training",
            width=28,
            command=self.showMissingTraining
        ).grid(row=0, column=1, padx=5, pady=5)

        tk.Button(
            buttonFrame,
            text="Training Records",
            width=28,
            command=self.showTrainingRecords
        ).grid(row=0, column=2, padx=5, pady=5)

        tk.Button(
            buttonFrame,
            text="Certification Records",
            width=28,
            command=self.showCertificationRecords
        ).grid(row=1, column=0, padx=5, pady=5)

        tk.Button(
            buttonFrame,
            text="Deployment Records",
            width=28,
            command=self.showDeploymentRecords
        ).grid(row=1, column=1, padx=5, pady=5)

        tk.Button(
            buttonFrame,
            text="Exit",
            width=28,
            command=self.root.destroy
        ).grid(row=1, column=2, padx=5, pady=5)

        tableFrame = tk.Frame(self.root)
        tableFrame.pack(fill="both", expand=True, padx=10, pady=10)

        self.resultsTable = ttk.Treeview(tableFrame)

        verticalScroll = ttk.Scrollbar(
            tableFrame,
            orient="vertical",
            command=self.resultsTable.yview
        )

        horizontalScroll = ttk.Scrollbar(
            tableFrame,
            orient="horizontal",
            command=self.resultsTable.xview
        )

        self.resultsTable.configure(
            yscrollcommand=verticalScroll.set,
            xscrollcommand=horizontalScroll.set
        )

        self.resultsTable.grid(row=0, column=0, sticky="nsew")
        verticalScroll.grid(row=0, column=1, sticky="ns")
        horizontalScroll.grid(row=1, column=0, sticky="ew")

        tableFrame.grid_rowconfigure(0, weight=1)
        tableFrame.grid_columnconfigure(0, weight=1)

    #Airman Readiness Overview
    def showReadinessOverview(self):
        query = """
        SELECT *
        FROM vw_airman_readiness
        ORDER BY airmanName;
        """
        self.runQuery(query)

    #Missing Training 
    def showMissingTraining(self):
        query = """
        SELECT
            a.airmanId AS "Airman ID",
            a.rank AS "Rank",
            a.firstName || ' ' || a.lastName AS "Airman Name",
            p.positionTitle AS "Position",
            tc.courseName AS "Missing Required Course"
        FROM Airman a
        INNER JOIN Position p
            ON a.positionId = p.positionId
        INNER JOIN ReadinessRequirement rr
            ON p.positionId = rr.positionId
        INNER JOIN TrainingCourse tc
            ON rr.courseId = tc.courseId
        WHERE rr.isRequired = TRUE
        AND rr.courseId NOT IN (
            SELECT ts.courseId
            FROM AirmanTraining at
            INNER JOIN TrainingSession ts
                ON at.sessionId = ts.sessionId
            WHERE at.airmanId = a.airmanId
            AND at.trainingStatus = 'Completed'
        )
        ORDER BY a.lastName, tc.courseName;
        """
        self.runQuery(query)

    #Training Records
    def showTrainingRecords(self):
        query = """
        SELECT
            a.rank AS "Rank",
            a.firstName || ' ' || a.lastName AS "Airman Name",
            tc.courseName AS "Course",
            ts.sessionDate AS "Session Date",
            at.trainingStatus AS "Status",
            at.completionDate AS "Completion Date"
        FROM AirmanTraining at
        INNER JOIN Airman a
            ON at.airmanId = a.airmanId
        INNER JOIN TrainingSession ts
            ON at.sessionId = ts.sessionId
        INNER JOIN TrainingCourse tc
            ON ts.courseId = tc.courseId
        ORDER BY ts.sessionDate DESC;
        """
        self.runQuery(query)

    #Certification Records
    def showCertificationRecords(self):
        query = """
        SELECT
            a.rank AS "Rank",
            a.firstName || ' ' || a.lastName AS "Airman Name",
            c.certificationName AS "Certification",
            ac.issueDate AS "Issue Date",
            ac.expirationDate AS "Expiration Date"
        FROM AirmanCertification ac
        INNER JOIN Airman a
            ON ac.airmanId = a.airmanId
        INNER JOIN Certification c
            ON ac.certificationId = c.certificationId
        ORDER BY ac.expirationDate;
        """
        self.runQuery(query)

    #Deployment Records
    def showDeploymentRecords(self):
        query = """
        SELECT
            a.rank AS "Rank",
            a.firstName || ' ' || a.lastName AS "Airman Name",
            d.deploymentLocation AS "Deployment Location",
            d.startDate AS "Start Date",
            d.endDate AS "End Date"
        FROM DeploymentRecord d
        INNER JOIN Airman a
            ON d.airmanId = a.airmanId
        ORDER BY d.startDate DESC;
        """
        self.runQuery(query)

#Program start
#creates the Tkinter window and starts UI event loop
if __name__ == "__main__":
    root = tk.Tk()
    app = AirmanReadinessApp(root)
    root.mainloop()