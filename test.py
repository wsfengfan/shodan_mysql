import os
import platform
import pymysql

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
    os.system("nohup sh check_server_Linux.sh 127.0.0.1 >output 2>&1 &")
    
    f = open("ip_gdsxxaqcpzx_linux.xml", "r")
    fr = f.read()
    fr = str(fr)
    
    db = pymysql.connect("192.168.10.113", "root", "Wdmm123", "test1")
    cursor = db.cursor()
    string1 = cursor.mogrify("INSERT INTO `server_linux`(`data`) VALUES(%s);", fr)
    cursor.execute(string1)
    cursor.connection.commit()
    cursor.close()

def UseWin():
    os.system("check_server_windows.vbs")
    
    f = open("ip_gdsxxaqcpzx_window.xml", "r")
    fr = f.read()
    fr = str(fr)
    print(fr)
    
    db = pymysql.connect("192.168.10.113", "root", "Wdmm123", "test1")
    cursor = db.cursor()
    string1 = cursor.mogrify("INSERT INTO `server_window`(`data`) VALUES(%s);", fr)
    cursor.execute(string1)
    cursor.connection.commit()
    db.close()

if __name__ == "__main__":
    TestOs()
    UseOs()