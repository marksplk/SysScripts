from xml.dom import minidom
import string

dom1 = minidom.parse( "tl185.xml" )

for testCase in dom1.getElementsByTagName('testcase'):
    originalSteps = testCase.getElementsByTagName('steps')[0]
    stepsTextBlock = originalSteps.childNodes[0].data
    steps = string.split(stepsTextBlock, '\n')
    counter = 1
    replacement = dom1.createElement('steps')
    for step in steps:
        #Declare the elements for the new structure
        newStepElement = dom1.createElement('step')
        stepNumber = dom1.createElement('step_number')
        actions = dom1.createElement('actions')
        expResults = dom1.createElement('expectedresults')
        execType = dom1.createElement('execution_type')
        
        #Add the text values for the nodes
        stepNumber.appendChild(dom1.createTextNode(str(counter)))
        actions.appendChild(dom1.createTextNode(step))
        expResults.appendChild(dom1.createTextNode(''))
        execType.appendChild(dom1.createTextNode('1'))
        
        #Add the nodes into one 'step' element
        newStepElement.appendChild(stepNumber)
        newStepElement.appendChild(actions)
        newStepElement.appendChild(expResults)
        newStepElement.appendChild(execType)

        #Append this step to the element of all steps
        replacement.appendChild(newStepElement)
        counter = counter + 1
        
    #If expectedresults was populated, copy it to the last step
    if len(testCase.getElementsByTagName('expectedresults')[0].childNodes) > 0:
        newStepElement.getElementsByTagName('expectedresults')[0].childNodes[0].data = testCase.getElementsByTagName('expectedresults')[0].childNodes[0].data
    #Removed expectedresults
    #NOTE: Need to removeChild while only one expectedresults child exists
    #If you swap the two lines below, the program will fail with a "Not Found" error
    #seemingly because mutliple 'expectedresults' will exist in the test case
    testCase.removeChild(testCase.getElementsByTagName('expectedresults')[0])    
    testCase.replaceChild(replacement, originalSteps)
    
#Finished altering the DOM, write it to file    
out = open('tl193.xml', 'w')
out.write(dom1.toxml().encode("utf-8"))
out.close()
