# Jeff Remley
# Natural Language Processes
# weeklyMenuURLREADER.py


import urllib2
import re
import inspect

# creates file and asks user to input the URL
bergDiningHost = "https://dining.muhlenberg.edu"
file = "bergDiningHTML.txt"
url = "https://dining.muhlenberg.edu/dining-choices/index.html"
response = urllib2.urlopen(url)

# writes HTML contents to the muhlenbergHTML file
writeToFile = open(file, "w")
writeToFile.write(response.read())
writeToFile.close()

#reads the file
readToFile = open(file, "r")


weeklymenu = 0
nonweekly = 0
linenumber = 0

for line in readToFile:
	linenumber = linenumber + 1
	#search in any line with a href
	if 'href=' in line:
		#determine if its absolute or relative
		if "WeeklyMenu" in line:
			weeklymenu = weeklymenu + 1
			print "WEEKLY MENU LINK:"
			urlLink = re.findall(r'"/(.*?)"', line)
			print urlLink
		else:
			nonweekly = nonweekly + 1

weeklyMenuURL = bergDiningHost + "/" + urlLink[0]
#Final calculations printed
print "The number of weekly menu links is:",
print weeklymenu
print "The number of non weekly menu links is:",
print nonweekly

print "WEEKLY MENU URL: " + weeklyMenuURL

readToFile.close()



newResponse = urllib2.urlopen(weeklyMenuURL)

writeDiningToFile = open(file, "w")
writeDiningToFile.write(newResponse.read())
writeDiningToFile.close()

readDiningToFile = open(file, "r")

print readDiningToFile



## Aliyas Code
##
#######
#######




       	
