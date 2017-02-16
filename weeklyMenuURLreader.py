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



for line in readToFile:
	#search in any line with a href
	if 'href=' in line:
		#determine if its absolute or relative
		if "WeeklyMenu" in line:
			print "WEEKLY MENU LINK:"
			urlLink = re.findall(r'"/(.*?)"', line)
			print urlLink
		else:
			#do nothing

weeklyMenuURL = bergDiningHost + "/" + urlLink[0]


print "WEEKLY MENU URL: " + weeklyMenuURL



## Aliyas Code
##
#######
#######




       	
