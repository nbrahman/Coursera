# Exploring the HyperText Transport Protocol
#
#You are to retrieve the following document using the HTTP protocol in a way that you can examine the HTTP Response headers.
#
#    http://www.pythonlearn.com/code/intro-short.txt
#
#There are three ways that you might retrieve this web page and look at the response headers:
#
#    Preferred: Modify the socket1.py program to retrieve the above URL and print out the headers and data.
#    Open the URL in a web browser with a developer console or FireBug and manually examine the headers that are returned.
#    Use the telnet program as shown in lecture to retrieve the headers and content.
#
#Enter the header values in each of the fields below and press "Submit". 
import socket
mysocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
mysocket.connect(('www.py4inf.com', 80))

mysocket.send('GET http://www.pythonlearn.com/code/intro-short.txt HTTP/1.0\n\n')

while True:
    data = mysocket.recv(512)
    if ( len(data) < 1 ) :
        break
    print data
mysocket.close()