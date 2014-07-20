import os
import re
import sys

class LDIFStruct:
   def load( self, dic, ldiffile ):
        # Reading file in a list and join LDIF multi-lines
        file = open( ldiffile )
        data = []
        try:
            for line in file:
                match = re.match( '^ (.*\n)', line )
                # Check if line begins with a space, join with last line
                if match:
                    # Pop last line and remove line return
                    lastline = re.sub( '(.*)\n', '\\1', data.pop() )
                    # Join result with current line without space
                    newline = lastline + match.group(1)
                    data.append( newline )
                # Normal line
                else:
                    data.append( line )
        finally:
#  file.close()
 # Loop through lines and analyse content
        currentdn = ""
        for line in data:
            # Test if we have a typical LDIF line "xxx: yyy"
            match = re.match( '^(.*?): (.*)\n', line )
            if match:
                # Check if line contains a DN
                if match.group(1) == "dn":
                    currentdn = match.group(2)
                    if not dic.has_key( currentdn ):
                        dic[ currentdn  ] = {}
                # Check if line contains an attribute
                elif not re.match( 'version|changetype|add|replace|delete', match.group(1) ):
                    if not dic[ currentdn ].has_key( match.group(1) ):
                        dic[ currentdn ][ match.group(1) ] = [ match.group(2) ]
                    else:
                        if not match.group(2) in dic[ currentdn ][ match.group(1) ]:
                            dic[ currentdn ][ match.group(1) ] += [ match.group(2) ]

 
