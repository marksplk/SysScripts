import datetime

file_name = "test.log"
FH = open(file_name, 'a')

a = datetime.datetime(2000,1,1,0,0,0)
b = datetime.datetime(2011,12,31,0,0,0)

count = 1

while a <> b:
    a = a + datetime.timedelta(hours=1)
    temp = str(a) + " event number = " + str(count) + "\n"
    count = count + 1
    FH.write(temp)

FH.close()
