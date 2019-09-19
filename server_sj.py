import os
import platform
import pymysql
import socket
import uuid
import time

myname = socket.gethostname()
myaddr = socket.gethostbyname(myname)
name = "MAC: "+str(myname)+" IP: "+str(myaddr)+" OS: "+str(platform.system())
print(name)

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
    fr = str(fr)
    
    try:
        db = pymysql.connect("192.168.10.113", "root", "Wdmm123", "test1")
        cursor = db.cursor()
        string1 = cursor.mogrify("INSERT INTO `server_cmd`(`name`,`data`) VALUES(%s, %s);", (name, fr))
        cursor.execute(string1)
        cursor.connection.commit()
        cursor.close()
    except:
        print("linux mysql insert error")

def UseWin():
    os.system("check_server_windows.vbs")
    time.sleep(25)
    
    f = open("ip_gdsxxaqcpzx_window.xml", "r")
    fr = f.read()
    fr = str(fr)
    
    try:
        db = pymysql.connect("192.168.10.113", "root", "Wdmm123", "test1")
        cursor = db.cursor()
        string1 = cursor.mogrify("INSERT INTO `server_cmd`(`name`,`data`) VALUES(%s, %s);", (name, fr))
        cursor.execute(string1)
        cursor.connection.commit()
        db.close()
    except:
        print("window mysql insert error")

if __name__ == "__main__":
    TestOs()
    UseOs()