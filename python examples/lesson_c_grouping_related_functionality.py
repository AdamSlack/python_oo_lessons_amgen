import copy


class DataColumn:
    """ A column for holding an array of Data """

    def __init__(self, column_name, column_data):
        """ default constructor """
        self.column_name = column_name
        self.column_data = column_data

    def apply_to_data(self, function):
        """ apply a transformation to the data in the column. """
        for i in range(0, len(self.column_data)):
            self.column_data[i] = function(self.column_data[i])

    def display_column_data(self):
        """ displays the data held in the column object """
        print(self.column_name)
        for data in self.column_data:
            print(str(data))


class DataFrame:
    """ A Frame for holding collections of Data """

    def __init__(self, name='', columns=[]):
        """ Default constructor"""
        self.name = name
        self.columns = {}
        for c in columns:
            self.columns[c.column_name] = c

    def display_data_frame(self):
        """ display entire contents of the data frame"""
        header_text = ''
        col_keys = []
        for key in self.columns:
            header_text += (key + '\t')
            col_keys.append(key)

        print(header_text)
        for i in range(0, len(self.columns[col_keys[0]].column_data)):
            print_string = ''
            for key in self.columns:
                print_string += (str(self.columns[key].column_data[i]) + '\t\t')
            print(print_string)


# using the classes

# creating data for the ID variable column
id_dc = DataColumn('ids', [x for x in range(0, 5)])

# creating Dat for the Results variable column using ID's data
res_dc = copy.deepcopy(id_dc)
res_dc.column_name = 'Results'
res_dc.apply_to_data(lambda x: x % 2)

# creating data for the outcomes variable column using Results Data
out_dc = copy.deepcopy(res_dc)
out_dc.column_name = 'Outcomes'
out_dc.apply_to_data(lambda x: 'Success' if x == 0 else 'Failure')

# Creating a data frame out of each of these crated columns
df = DataFrame([id_dc, res_dc, out_dc])

# display the data
df.display_data_frame()
df.columns['Results'].display_column_data()

# displaying the columns individually.
id_dc.display_column_data()
print('\n')
res_dc.display_column_data()
print('\n')
out_dc.display_column_data()
