# EXTERNAL LIBRARIES 
import re 
import pprint
import urllib2

# open url using python library
url = 'https://dining.muhlenberg.edu/Images/WeeklyMenu_tcm1703-139270.htm'
html = urllib2.urlopen(url)

#find possible words
regex = '[A-Z][a-z]+'

# all possible days of week
daysOfWeek = ['mondayBreakfast','mondayLunch', 'mondayDinner', 'tuesdayBreakfast', 'tuesdayLunch', 'tuesdayDinner', 
'wednesdayBreakfast','wednesdayLunch', 'wednesdayDinner', 'thursdayBreakfast','thursdayLunch', 'thursdayDinner', 
'fridayBreakfast','fridayLunch', 'fridayDinner', 'saturdayLunch', 'saturdayDinner',  'sundayLunch', 'sundayDinner',] 

# dictionary to store data 
allFoodItems = {}

# array to store meal options 
tempFoodArray = []

# used to make sure Monday Breakfast does not fill as empty
tempArrayFilled = False

# dictionaries to store different types of food
allVegetarianItems = {}
allVeganItems = {}
allMindfulItems = {}
 
# arrays to temp store different types of food
VegetarianItems = []
VeganItems = [] 
MindfulItems = []

# used to increment through days of week
i = 0

# for every line in html code
for line in html:
	# used to store Food Item string
	emptyString = "" 
	# food name located in this line
	if '<span class="ul" onmouseover="ws(this);" onclick="nf' in line: 
			# put food item on String
			for foodItem in re.findall(regex, line): 
	 			# if Vegetarian, Vegan, Mindul 
	 			if "Vegetarian" == foodItem and len(emptyString) != 0:
	 				VegetarianItems.append(emptyString.strip())
	 			elif "Vegan" == foodItem and len(emptyString) != 0:
	 				VeganItems.append(emptyString.strip())
	 			elif "Mindful" == foodItem and len(emptyString) != 0: 
	 				print emptyString
	 				MindfulItems.append(emptyString.strip())
	 			elif "Item" == foodItem: 
	 				foodItem = ""
				else: 
					emptyString += foodItem + " "			
			# add to Temp array
			tempFoodArray.append(emptyString.strip())
			tempArrayFilled = True
	# distinguishes between time of day 
	elif ('<tr class="brk"><td colspan="3" class="mealname">BREAKFAST</td></tr><tr class="brk"><td class="station">' in line or \
	'<tr class="lun"><td colspan="3" class="mealname">LUNCH</td></tr>' in line or \
	'<tr class="din"><td colspan="3" class="mealname">DINNER</td></tr>' in line) \
	and tempArrayFilled == True: 
		# reset because new day
 		allFoodItems[daysOfWeek[i]] = tempFoodArray
 		allVegetarianItems[daysOfWeek[i]] = VegetarianItems
 		allVeganItems[daysOfWeek[i]] = VeganItems
 		allMindfulItems[daysOfWeek[i]] = MindfulItems
 		i +=1
 		tempFoodArray = []
 		VegetarianItems = []
		VeganItems = [] 
		MindfulItems = []

html.close()	