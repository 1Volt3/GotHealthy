# EXTERNAL LIBRARIES 
import re 
import pprint
import urllib2

# create dictionary with food items 
foodItems = {}

# open url using python library
url = 'https://dining.muhlenberg.edu/Images/WeeklyMenu_tcm1703-139270.htm'
html = urllib2.urlopen(url)

# go throw all the lines in html 
for line in html:
	# reset variables
	servingSize = 0 
	calories = 0 
	# get all aData 
	for item in re.findall('aData\[...+\);', line): 
		# temp array to store descriptions 
		temp = []
		# get data in the parenthesis 		
		for food in re.findall('\(..+\)', item): 
			# split at commas
			for i in food.split("','"):
				# where calories and serving size stored 
				if i.startswith('('):
					a = re.findall('[A-Za-z0-9/\.\-+ ]+', i )
					servingSize = a[0]
					calories = a[1]
				# get food and description, add to array 
				elif re.findall('[A-Z][A-Za-z\s]+', i ) and i.startswith('(') == False:
					temp.append(i)
			# store info in dictionaries
			if len(temp) == 2 and temp[0] not in foodItems:
				foodItems[temp[0]] = {}
				foodItems[temp[0]]["Description"] = temp[1]
				foodItems[temp[0]]["servingSize"] = servingSize
				foodItems[temp[0]]["calories"] = calories
			elif len(temp) == 3  and temp[0] not in foodItems: 
				foodItems[temp[0]] = {}
				foodItems[temp[0]]["Description"] = temp[1]
				foodItems[temp[0]]["Special"] = temp[2]
				foodItems[temp[0]]["servingSize"] = servingSize
				foodItems[temp[0]]["calories"] = calories

pprint.pprint(foodItems)
