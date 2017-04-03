import urllib2
import re
import pprint
import json

#create host name extension
bergDiningHost = "https://dining.muhlenberg.edu"

#write HTML contents to text file
file = "bergDiningHTML.txt"

#start with dining choices URL
url = "https://dining.muhlenberg.edu/dining-choices/index.html"

#open URL
response = urllib2.urlopen(url)

for line in response:
	#search in any line with a href
	if 'href=' in line:
		
        #find link with weeklyMenu in it!
		if "WeeklyMenu" in line:
			urlLink = re.findall(r'"/(.*?)"', line)


weeklyMenuURL = bergDiningHost + "/" + urlLink[0]
#final URL is saved as "weeklyMenuURL"!!!!!

print weeklyMenuURL

html = urllib2.urlopen(weeklyMenuURL)

# all possible days of week
daysOfWeek = ['MondayBreakfast','MondayLunch', 'MondayDinner', 'TuesdayBreakfast', 'TuesdayLunch', 'TuesdayDinner',
'WednesdayBreakfast','WednesdayLunch', 'WednesdayDinner', 'ThursdayBreakfast','ThursdayLunch', 'ThursdayDinner',
'FridayBreakfast','FridayLunch', 'FridayDinner', 'SaturdayLunch', 'SaturdayDinner',  'SundayLunch', 'SundayDinner',] 

count = -1
label = "" 

menu = {}

for line in html: 
    # used to store Food Item string
    emptyString = ""
    Vegan = "No"
    Vegetarian = "No"
    Mindful = "No"
    if '<span class="ul" onmouseover="ws(this);" onclick="nf' in line:
		for foodItem in re.findall('[A-Z][a-z]+', line): 
	 			# if Vegetarian, Vegan, Mindul 
	 			if "Vegetarian" == foodItem and len(emptyString) != 0:
	 				Vegetarian = "Yes"
	 			elif "Vegan" == foodItem and len(emptyString) != 0:
	 				Vegan = "Yes"
	 			elif "Mindful" == foodItem and len(emptyString) != 0: 
	 				Mindful = "Yes"
	 			elif "Item" == foodItem: 
	 				Mindful = "Yes"
				else:
					emptyString += foodItem + " "
		emptyString = emptyString.strip()
		menu[label][emptyString] = {}
		menu[label][emptyString]["Vegetarian"] = Vegetarian
		menu[label][emptyString]["Vegan"] = Vegan
		menu[label][emptyString]["Mindful"] = Mindful
    elif line.startswith('<tr class="brk"><td colspan="3" class="mealname">') or \
    line.startswith('<tr class="lun"><td colspan="3" class="mealname">') \
 	or 	'<tr class="din"><td colspan="3" class="mealname">DINNER</td></tr>' in line:
 		count = count + 1 
 		label =  daysOfWeek[count]
 		menu[label] = {}
print json.dumps( menu, sort_keys=True, indent=4, separators=(',', ': '))

