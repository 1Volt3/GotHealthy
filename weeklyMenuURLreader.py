# Jeff Remley
# weeklyMenuURLREADER.py


import urllib2
import re
import inspect

#create host name extension
bergDiningHost = "https://dining.muhlenberg.edu"

#write HTML contents to text file
file = "bergDiningHTML.txt"

#start with dining choices URL
url = "https://dining.muhlenberg.edu/dining-choices/index.html"


#open URL
response = urllib2.urlopen(url)

# writes HTML contents to the bergDiningHTML file
writeToFile = open(file, "w")
writeToFile.write(response.read())
writeToFile.close()

#reads the file
readToFile = open(file, "r")



for line in readToFile:
	#search in any line with a href
	if 'href=' in line:
		
        #find link with weeklyMenu in it!
		if "WeeklyMenu" in line:
			urlLink = re.findall(r'"/(.*?)"', line)


weeklyMenuURL = bergDiningHost + "/" + urlLink[0]
#final URL is saved as "weeklyMenuURL"!!!!!


print "WEEKLY MENU URL: " + weeklyMenuURL


## Aliyas Code
##
#######
#######






       	
