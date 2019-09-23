import os
import platform
import pymysql
import socket
import uuid
import time
import re

myname = socket.gethostname()
myaddr = socket.gethostbyname(myname)
nameID = "MAC: "+str(myname)+" IP: "+str(myaddr)+" OS: "+str(platform.system())
print(nameID)

def TestOs():
    print("------------Operation System----------------")
    print(platform.architecture())
    print(platform.platform())
    print("--------------------------------------------")


def UseOs():
    sys = platform.system()
    if(sys == "Windows"):
        UseWin()
    elif(sys == "Linux"):
        UseLin()
    else:
        print("Other System tasker")

def UseLin():
    os.system("nohup sh check_server_linux.sh 127.0.0.1 >output 2>&1 &")
    time.sleep(25)
    
    f = open("/tmp/ip_gdsxxaqcpzx_linux.xml", "r")
    fr = f.read()
    ftring = re.findall("<script>.*?</script>", fr, re.S)

    Hostname = ""
    Network = ""
    Port = ""
    User = ""
    Process = ""
    Passwd = ""
    Shadow = ""
    Kernel_version = ""
    Lsb_release = ""
    Login_info = ""
    DNS = ""
    Service_Process = ""
    Firewall = ""
    


    for string3 in ftring:

        # --------- id -------------------
        string1 = re.findall("<id>.*?</id>", string3, re.S)
        string1 = str(string1)
        string1 = string1.replace("<id>", "")
        string1 = string1.replace("</id>", "")
        string1 = string1.replace("['", "")
        string1 = string1.replace("']", "")

        # --------- values -----------------
        string2 = re.findall("<value>.*?</value>", string3, re.S)
        string2 = str(string2)
        string2 = string2.replace("<value>", " ")
        string2 = string2.replace("</value>", " ")
        string2 = string2.replace("['", "")
        string2 = string2.replace("']", "")
        string2 = string2.replace("<![CDATA[", "")
        string2 = string2.replace("]]>", "")
    
        if string1 == "3":
            Hostname = string2
        elif string1 == "4":
            Network = string2
        elif string1 == "9":
            Port = string2
        elif string1 == "12":
            User = string2
        elif string1 == "10":
            Process = string2
        elif string1 == "5":
            Passwd = string2
        elif string1 == "7":
            Shadow = string2
        elif string1 == "11":
            Kernel_version = string2
        elif string1 == "1":
            Lsb_release = string2
        elif string1 == "13":
            Login_info = string2
        elif string1 == "16":
            DNS = string2
        elif string1 == "20":
            Service_Process = string2
        elif string1 == "18":
            Firewall = string2
            
    print(Hostname,Network,Port,User,Process,Passwd,Shadow,Kernel_version,Lsb_release,Login_info,DNS,Service_Process,Firewall)
    
    try:
        db = pymysql.connect("192.168.10.113", "root", "Wdmm123", "test1")
        cursor = db.cursor()
        string4 = cursor.mogrify("INSERT INTO `server_test`(`Hostname`,`Network`,`Port`,`User`,`Process`,`Passwd`,`Shadow`,`Kernel_version`,`Lsb_release`,`Login_info`,`DNS`,`Service_Process`,`Firewall`,`nameID`) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);", (Hostname,Network,Port,User,Process,Passwd,Shadow,Kernel_version,Lsb_release,Login_info,DNS,Service_Process,Firewall,nameID))
        cursor.execute(string4)
        cursor.connection.commit()
        db.close()
    except:
        print("linux mysql insert error")

def UseWin():
    os.system("check_server_windows.vbs")
    time.sleep(90)
    
    f = open("ip_gdsxxaqcpzx_window.xml", "r")
    fr = f.read()
    ftring = re.findall("<script>.*?</script>", fr, re.S)

    User = ""
    Process = ""
    Firewall = ""
    Port = ""
    Install_Procduce = ""
    Computer_list = ""
    Patch = ""
    Disk = ""
    Route = ""
    Network = ""
    Sys_info = ""


    for string3 in ftring:

        # --------- id -------------------
        string1 = re.findall("<id>.*?</id>", string3, re.S)
        string1 = str(string1)
        string1 = string1.replace("<id>", "")
        string1 = string1.replace("</id>", "")
        string1 = string1.replace("['", "")
        string1 = string1.replace("']", "")

        # --------- values -----------------
        string2 = re.findall("<value>.*?</value>", string3, re.S)
        string2 = str(string2)
        string2 = string2.replace("<value>", " ")
        string2 = string2.replace("</value>", " ")
        string2 = string2.replace("['", "")
        string2 = string2.replace("']", "")
        string2 = string2.replace("<![CDATA[", "")
        string2 = string2.replace("]]>", "")
    
        if string1 == "213":
            User = string2
        elif string1 == "229":
            Process = string2
        elif string1 == "223":
            Firewall = string2
        elif string1 == "-11":
            Port = string2
        elif string1 == "260":
            Install_Procduce = string2
        elif string1 == "259":
            Computer_list = string2
        elif string1 == "220":
            Patch = string2
        elif string1 == "999":
            Disk = string2
        elif string1 == "998":
            Route = string2
        elif string1 == "997":
            Network = string2
        elif string1 == "996":
            Sys_info = string2
            
    print(User,Process,Firewall,Port,Install_Procduce,Computer_list,Patch,Disk,Route,Network,Sys_info)
    
    
    db = pymysql.connect("192.168.10.113", "root", "Wdmm123", "test1")
    cursor = db.cursor()
    string4 = cursor.mogrify("INSERT INTO `server_test`(`User`,`Process`,`Firewall`,`Port`,`Install_Procduce`,`Computer_list`,`Patch`,`Disk`,`Route`,`Network`,`Sys_info`,`nameID`) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);", (User,Process,Firewall,Port,Install_Procduce,Computer_list,Patch,Disk,Route,Network,Sys_info,nameID))
    cursor.execute(string4)
    cursor.connection.commit()
    db.close()
    

if __name__ == "__main__":
    TestOs()
    UseOs()