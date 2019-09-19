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
    db = pymysql.connect("192.168.10.113", "root", "Wdmm123", "test1")
    cursor = db.cursor()
    cursor.execute("LOAD DATA LOCAL INFILE 'ip_gdsxxaqcpzx_linux.xml' INTO TABLE `server_linux`")
    cursor.connection.commit()
    cursor.close()

def UseWin():
    os.system("check_server_windows.vbs")
    db = pymysql.connect("192.168.10.113", "root", "Wdmm123", "test1")
    cursor = db.cursor
    cursor.execute("LOAD DATA LOCAL INFILE 'ip_gdsxxaqcpzx_window.xml' INTO TABLE `server_window`")
    cursor.connection.commit()
    db.close()

if __name__ == "__main__":
    TestOs()
    UseOs()
