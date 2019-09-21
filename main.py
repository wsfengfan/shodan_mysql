import sys
import os
import pymysql
import time


ip = ""
ip = sys.argv[1]
string1 = "nohup python mass.py -h "+ip+" -m 200 -t 6 >ips.txt 2>&1 &"
s = os.system(string1)
