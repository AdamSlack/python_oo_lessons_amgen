# this is the same code as before
# except separated into reusable functions


def generate_ids(number_of_ids):
    """ generates a given number of ids """
    ids = []
    for id in range(0, number_of_ids):
        ids.append(id)
    return ids


def generate_results(ids):
    """ generates results for a collection of ids """
    results = []
    for id in ids:
        results.append(id % 2)
    return results


def calculate_outcomes(results):
    """ based on some results, determine if result was a success of failure"""
    outcomes = []
    for result in results:
        if result == 0:
            outcomes.append('SUCCESS')
        else:
            outcomes.append('FAILURE')
    return outcomes


def display_data_tagged(ids, results, outcomes):
    """ displays the data with the col name aside each data point"""
    for id, result, outcome in zip(ids, results, outcomes):
        print('ID: ' + str(id) + '\tResult: ' + str(result) + '\tOutcome: ' + outcome)


def display_data_headed(ids, results, outcomes):
        """ displays the data with the col name aside each data point"""
        print('IDs:\t\tResults:\t\tOutcomes:')
        for id, result, outcome in zip(ids, results, outcomes):
            print('' + str(id) + '\t\t' + str(result) + '\t\t\t' + outcome)


# displaying the results a different way
# print('\n\nID:\t\tResult:\t\tOutcome:')
# for i in range(0, len(outcomes)):
#    print('' + str(id[i]) + '\t\t' + str(results[i]) + '\t\t\t' + outcomes[i])


a_ids = generate_ids(10)
b_ids = generate_ids(27)

a_res = generate_results(a_ids)
b_res = generate_results(b_ids)

a_out = calculate_outcomes(a_res)
b_out = calculate_outcomes(b_res)

display_data_tagged(a_ids, a_res, a_out)
display_data_headed(b_ids, b_res, b_out)

