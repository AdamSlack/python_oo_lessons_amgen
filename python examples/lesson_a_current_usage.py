
# this is how you might currently write code
# not using any classes, maybe not using any functions

id = []
results = []
outcomes = []

# initialse some arrays
for i in range(0, 10):
    id.append(i)
    results.append(i % 2)

# evaluate the results.
for i in range(0, len(results)):
    if results[i] == 0:
        outcomes.append('SUCCESS')
    else:
        outcomes.append('FAILURE')

# display the results
for i in range(0, len(outcomes)):
    print('ID: ' + str(id[i]) + '\tResult: ' + str(results[i]) + '\tOutcome: ' + outcomes[i])

# displaying the results a different way
# print('\n\nID:\t\tResult:\t\tOutcome:')
# for i in range(0, len(outcomes)):
#    print('' + str(id[i]) + '\t\t' + str(results[i]) + '\t\t\t' + outcomes[i])



