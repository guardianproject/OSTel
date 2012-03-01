#!/usr/local/bin/python
import os
import sys
import time
import random
import commands
import argparse

if not os.geteuid()==1002:
    sys.exit("\nOnly freeswitch can run this script\n")

###########
##Create options and arguments
###########
parser = argparse.ArgumentParser()

parser.add_argument('-sid', action='store', dest='SIPid',
                    default='ranDom', help='SIP ID number (choose between 23000-42000 - if you go outside of this range your number will not be dialable) default is random')

parser.add_argument('-cid', action='store', dest='displayID',
                    default='ANON', help='Set Caller ID Name. Default is ANON')

parser.add_argument('-p', action='store_true', dest='permanent',
                    default=False, help='Make Permanent (the account is deleted after 30 days unless this is set)')

results = parser.parse_args()



#########
##Create ramdom SIP ID and Test to see if SIP account is available 
#########

if results.SIPid == "ranDom":
  ranDomer = random.randrange(23000, 42001)
  ranDstr = str(ranDomer)

  searchRandom = 1
  while searchRandom == 1 :
      if os.path.isfile("/usr/local/etc/freeswitch/conf/directory/rand/" + ranDstr + ".xml"):
          print "random number " + ranDstr + " is taken"
          ranDomer = random.randrange(23000, 42001)
          ranDstr = str(ranDomer)
      else:
          newBee = ranDstr
          searchRandom = 0
elif os.path.isfile("/usr/local/etc/freeswitch/conf/directory/rand/" + results.SIPid + ".xml"):
  sys.exit("\nSIP Address TAKEN - TRY AGAIN\n")
elif os.path.isfile("/usr/local/etc/freeswitch/conf/directory/default/" + results.SIPid + ".xml"):
  sys.exit("\nSIP Address TAKEN - TRY AGAIN\n")
else:
  newBee = results.SIPid
  
########
## If set to permenant  place in default folder, users older then 30days are deleted in the rand folder
########
if results.permanent == True:
  print("Creating Permenant User")
  createLocation = "/usr/local/etc/freeswitch/conf/directory/default/"
else:
  print("Creating Temporary User 30 days")
  createLocation = "/usr/local/etc/freeswitch/conf/directory/rand/"


########
## Create Random password
#######
possLP = commands.getoutput("pwgen -1cn 10")

########
## Create freeswitch configuration file 
#######
text_file = open(createLocation + newBee + ".xml", "w")

text_file.write("<include>\n")
text_file.write("  <user id=\"" + newBee + "\">\n")
text_file.write("    <params>\n")
text_file.write("      <param name=\"password\" value=\"" + possLP + "\"/>\n")
text_file.write("      <param name=\"vm-password\" value=\"" + newBee + "\"/>\n")
text_file.write("    </params>\n")
text_file.write("    <variables>\n")

# Maybe user_context should be defined by anon or perminant user.. this could be implemented later

text_file.write("      <variable name=\"user_context\" value=\"default\"/>\n")
text_file.write("      <variable name=\"effective_caller_id_name\" value=\"" + results.displayID + "\"/>\n")
text_file.write("      <variable name=\"effective_caller_id_number\" value=\"" + newBee + "\"/>\n")
text_file.write("      <variable name=\"callgroup\" value=\"anon\"/>\n")
text_file.write("    </variables>\n")
text_file.write("  </user>\n")
text_file.write("</include>\n")

text_file.close()

#######
## Set permission and ownership of new xml file
#######
os.chmod(createLocation + newBee + ".xml", 0640)
os.chown(createLocation + newBee + ".xml", 1002, 1002)


#######
## Reload freeswitch xml
#######
#print("Reloading freeswitch xml")
os.system("/usr/local/bin/fs_cli -x reloadxml")

######
## Display new info
######
print("," + newBee + "@ostn.net")
print("," + possLP + ",")
