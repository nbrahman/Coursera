#Retrieving GEOData
#
#Download the code from http://www.pythonlearn.com/code/geodata.zip - then unzip the file and edit where.data to add an address nearby where you live - don't reveal your actual location. Then run the geoload.py to lookup all of the entries in where.data (including the new one) and produce the geodata.sqlite. Then run geodump.py to read the database and produce where.js. Then open where.html to visualize the map. Take screen shots as described below.
#
#This is a relatively simple assignment. Don't take off points for little mistakes. If they seem to have done the assignment give them full credit. Feel free to make suggestions if there are small mistakes. Please keep your comments positive and useful. If you do not take grading seriously, the instructors may delete your response and you will lose points.
import urllib.parse
import urllib.request
import sqlite3
import json
import time
import ssl
import sys

if sys.version_info > (3,):
     buffer = memoryview

# If you are in China use this URL:
# serviceurl = "http://maps.google.cn/maps/api/geocode/json?"
serviceurl = "http://maps.googleapis.com/maps/api/geocode/json?"

# Deal with SSL certificate anomalies Python > 2.7
scontext = ssl.SSLContext(ssl.PROTOCOL_TLSv1)
#scontext = None

conn = sqlite3.connect('geodata.sqlite')
cur = conn.cursor()

cur.execute('''
CREATE TABLE IF NOT EXISTS Locations (address TEXT, geodata TEXT)''')

fh = open("where.data",encoding='utf-8')
count = 0
for line in fh:
    if count > 200 : break
    address = line.strip()
    address2=address
    print ('')
    cur.execute("SELECT geodata FROM Locations WHERE address= ?", (buffer(address2.encode('utf-8')), ))

    try:
        data = cur.fetchone()[0]
        print ("Found in database ",str(address))
        continue
    except:
        pass

    print ('Resolving', str(address.encode('utf-8')))
    url = serviceurl + urllib.parse.urlencode({"sensor":"false", "address": str(address)})
    print ('Retrieving', url)
    uh = urllib.request.urlopen(url, context=scontext)
    data = uh.read()
    data2 = data
    print ('Retrieved',len(data),'characters',str(data2[:20]).replace('\n',' '))
    count = count + 1
    try:
        js = json.loads(data.decode('utf-8'))
        # print (js)  # We print in case unicode causes an error
    except:
        continue

    if 'status' not in js or (js['status'] != 'OK' and js['status'] != 'ZERO_RESULTS') :
        print ('==== Failure To Retrieve ====')
        print (data)
        break
    cur.execute('''INSERT INTO Locations (address, geodata)
            VALUES ( ?, ? )''', ( str(address),buffer(data) ) )
    conn.commit()
    time.sleep(1)

print ("Run geodump.py to read the data from the database so you can visualize it on a map.")