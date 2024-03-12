from fastapi import FastAPI, Path, Query
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import os, subprocess, json, random, string, hashlib, time

app = FastAPI()


origins = [
    "http://localhost",
    "http://localhost:8080",
    "http://192.168.12.1:8080"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class Test(BaseModel):
    Exam_Id: str
    Std_Id: str
    Q_Num: int
    Code: str

class Exam(BaseModel):
    professor: str
    course: str
    date: str
    marks: int
    time: int
    startTime: int
    note: str
    triesAllowed: int
    questionsNotesMarks: str
    studentsIds: str

class ExamAns(BaseModel):
    Exam_Id: str
    Std_Id: str
    Sub_time: int
    Code_Ans: str


def match_token():
    pass

def hash_pass(pswd):
    hs = hashlib.new("SHA256")
    hs.update(pswd.encode())
    return hs.hexdigest()


@app.get("/api/Proflogin")
def home(Prof_Id: str , Pswd: str):
    Database_Dir = os.path.abspath('..')+"/database/Prof_Data.json"
    token = hash_pass(str(time.time()))
    with open(Database_Dir, "r") as pd:
        Prof_Data = json.loads(pd.read())
    pswd_hash = hash_pass(Pswd)

    if Prof_Data["Pswd_hash"] == pswd_hash and Prof_Data["ID"] == Prof_Id:
        return {"Response":"Access granted" , "AccessToken" : token}
    else:
        return {"Response": "Invalid  Credentials" , "hash":pswd_hash}

@app.put("/api/Stdlogin")
def home(Std_Id: str , Exam_Id: str):
    Exam_Dir = os.path.abspath('..')+"/database/Exams_Data/"+Exam_Id
    if(os.path.exists(Exam_Dir)):
        with open(Exam_Dir+"/Students.json","r") as sd:
            Std_Data = json.loads(sd.read())
        if Std_Id in Std_Data:
            if Std_Data[Std_Id]["Attended"] == True:
                return {"Response": "Already Logged in"}
            token = hash_pass(str(time.time()))
            Std_Data[Std_Id]["Access_Token"] = token
            Std_Data[Std_Id]["Attended"] = True
            Std_Data[Std_Id]["Status"] = "Logged In"
            Std_Data[Std_Id]["Start_Time"] = str(time.ctime())
            with open(Exam_Dir + "/Students.json", "w") as  xd:
                json.dump(Std_Data, xd)
            return {"Response":"Access granted" , "accessToken" : token}
        else:
            return {"Response": "Invalid Student ID"}
    else:
        return {"Response": "Invalid Exam ID"}


@app.get("/api/getExam")
def exam(Exam_Id: str):
    Exam_Dir = os.path.abspath('..')+"/database/Exams_Data/"+Exam_Id
    if(os.path.exists(Exam_Dir)):
        with open(Exam_Dir+"/Exam.json","r") as xd:
            Exam_Data = json.loads(xd.read())
        time_left = (Exam_Data["time"] * 60) - (time.time() - Exam_Data["startTime"])
        time_left = round(time_left,0)
        return {"Response": "Exam fetched successfully", "examData": Exam_Data , "timeLeft":time_left}
    else:
        return {"Response": "Invalid Exam ID"}


@app.post("/api/makeExam")
def makeExam(Crnt_Exam : Exam):
    s = string.ascii_lowercase+string.digits
    ExamId = "".join(random.sample(s,5))
    Exam_Dir = os.path.abspath('..')+"/database/Exams_Data/"+ExamId
    while(os.path.exists(Exam_Dir)):
        ExamId = "".join(random.sample(s,5))
        Exam_Dir = os.path.abspath('..')+"/database/Exams_Data/"+ExamId
    os.makedirs(Exam_Dir)

    students_list = Crnt_Exam.studentsIds.replace(" ","")
    students_list = students_list.split('`')
    students_data = {}
    question_list = Crnt_Exam.questionsNotesMarks.split('`')
    question_data = []
    for qz in range(0,len(question_list),3):
        question_data.append({"Q":question_list[qz],"N":question_list[qz+1],"M":int(question_list[qz+2])})

    for std in students_list:
        os.makedirs(Exam_Dir+"/"+std)
        students_data[std] = {"Attended" : False , "Marks": 0 , "Questions_Attempted": 0, "Status": "Not attempted", "Start_Time": "", "Time_Taken":0, "End_Time": "", "Access_Token" : "", "Additional_time_awarded" : 0}

    Crnt_Exam.studentsIds = students_list
    Crnt_Exam.questionsNotesMarks = question_data
    Crnt_Exam = dict(Crnt_Exam)

    with open(Exam_Dir + "/Students.json", "w") as  xd:
        json.dump(students_data, xd)

    with open(Exam_Dir + "/Exam.json", "w") as  xd:
        json.dump(Crnt_Exam, xd)

    return {"Response": "Exam made successfully", "ExamID" : ExamId}

@app.put("/api/startExam")
def startExam(Exam_Id : str):
    Exam_Dir = os.path.abspath('..')+"/database/Exams_Data/"+Exam_Id
    if(os.path.exists(Exam_Dir)):
        with open(Exam_Dir+"/Exam.json","r") as xd:
            Exam_Data = json.loads(xd.read())
        Exam_Data["startTime"] = time.time()
        with open(Exam_Dir + "/Exam.json", "w") as  xd:
            json.dump(Exam_Data, xd)
        return {"Response": "Exam Started"}
    else:
        return {"Response": "Invalid Exam ID"}




@app.post("/api/compileTest")
def compileTest(Crnt_Test : Test):
    Code_dir = os.path.abspath('..')+"/database/Exams_Data/"+Crnt_Test.Exam_Id+"/"+Crnt_Test.Std_Id
    if not os.path.exists(Code_dir):
        os.makedirs(Code_dir)
    Crnt_Src = Code_dir+"/Q"+str(Crnt_Test.Q_Num)+".cpp"

    with open(Crnt_Src,"w") as fl:
        fl.write(Crnt_Test.Code)

    cmd = "g++ '" + Crnt_Src + "'"

    output = subprocess.run(cmd,shell=True,capture_output=True)
    if (output.stderr):
        return {"Response": output.stderr}
    else:
        return {"Response": "Successful Compile", "Code_Dir":Code_dir}

@app.post("/api/submitExam")
def submitExam(Crnt_Ans: ExamAns):
    Exam_Dir = os.path.abspath('..')+"/database/Exams_Data/"+Crnt_Ans.Exam_Id
    with open(Exam_Dir+"/Students.json","r") as xd:
            Std_Data = json.loads(xd.read())
    Std_Data[Crnt_Ans.Std_Id]["Time_Taken"] = round(Crnt_Ans.Sub_time,0)
    Std_Data[Crnt_Ans.Std_Id]["Status"] = "Submitted Answers"
    Std_Data[Crnt_Ans.Std_Id]["End_Time"] = str(time.ctime())
    Crnt_Ans.Code_Ans = Crnt_Ans.Code_Ans.split('`')

    for code , i in zip(Crnt_Ans.Code_Ans, range(1,len(Crnt_Ans.Code_Ans)+1)):

        if len(code) > 0 :
            Std_Data[Crnt_Ans.Std_Id]["Questions_Attempted"] += 1

        Crnt_Src = Exam_Dir+"/"+Crnt_Ans.Std_Id+"/Q"+str(i)+".cpp"
        with open(Crnt_Src,"w") as fl:
            fl.write(code)

    with open(Exam_Dir + "/Students.json", "w") as  xd:
        json.dump(Std_Data, xd)
    return {"response": "Successfully Submitted"}