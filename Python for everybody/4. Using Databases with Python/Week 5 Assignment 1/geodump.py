#Retrieving GEOData
#
#Download the code from http://www.pythonlearn.com/code/geodata.zip - then unzip the file and edit where.data to add an address nearby where you live - don't reveal your actual location. Then run the geoload.py to lookup all of the entries in where.data (including the new one) and produce the geodata.sqlite. Then run geodump.py to read the database and produce where.js. Then open where.html to visualize the map. Take screen shots as described below.
#
#This is a relatively simple assignment. Don't take off points for little mistakes. If they seem to have done the assignment give them full credit. Feel free to make suggestions if there are small mistakes. Please keep your comments positive and useful. If you do not take grading seriously, the instructors may delete your response and you will lose points. 
import sqlite3
import json
import codecs

conn = sqlite3.connect('geodata.sqlite')
cur = conn.cursor()

cur.execute('SELECT * FROM Locations')
print('rowcount=', cur.rowcount)
fhand = codecs.open('where.js','w', "utf-8")
fhand.write("myData = [\n")
count = 0
for row in cur :
    data = str(row[1].decode('utf-8'))
    try: js = json.loads(str(data))
    except: continue

    if not('status' in js and js['status'] == 'OK') : continue

    lat = js["results"][0]["geometry"]["location"]["lat"]
    lng = js["results"][0]["geometry"]["location"]["lng"]
    if lat == 0 or lng == 0 : continue
    where = js['results'][0]['formatted_address']
    where = where.replace("'","")
    try :
        print (where, lat, lng)

        count = count + 1
        if count > 1 : fhand.write(",\n")
        output = "["+str(lat)+","+str(lng)+", '"+where+"']"
        fhand.write(output)
    except:
        continue

fhand.write("\n];\n")
cur.close()
fhand.close()
print (count, "records written to where.js")
print ("Open where.html to view the data in a browser")

