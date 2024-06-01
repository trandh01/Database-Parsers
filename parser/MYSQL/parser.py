import json
import os

def sql_script(json_file_path, table_name, column_names):
    # Read the JSON file and load the data into a variable
    with open(json_file_path, 'r', encoding='utf-8') as file:
        data = json.load(file)
    
    # Extract data entries
    data_entrys = data['results'][0]['items']
    
    # INSERT format
    INSERT = f"INSERT INTO `{table_name}` ({', '.join(column_names)}) VALUES \n"
    
    tuple_list = []
    for data_entry in data_entrys:
    # Extract the values for the specified columns
        values = []
        for col in column_names:
            value = data_entry[col]
            if isinstance(value, str):
                # Check to see if the value of the column exist
                if value == "":
                    values.append(f"NULL")
                else:
                    values.append(f'"{value}"')
            else:
                values.append(str(value))
        # Reformat the values list
        tuple_str = ", ".join(values)
        # Add tuples into a list with correct formatting
        tuple_list.append(f"({tuple_str})")
    
    # Combine all values into one INSERT statement
    INSERT += ",\n".join(tuple_list) + ";"
    
    return INSERT

# Prompt the user for the JSON file path 
json_file_path = input("Path to JSON file: ") 
# Prompt the user for the table name 
table_name = input("Table name: ") 
# Prompt the user for the column names as a comma-separated string
column_names_input = input("Column names (comma-separated): ") 
# Remove any white spaces from input and add to a list
column_names = [columns.strip() for columns in column_names_input.split(',')]  

# Generate the insert statements
sql_scripts = sql_script(json_file_path, table_name, column_names)

# Determine the directory of the JSON file
json_file_directory = os.path.dirname(json_file_path)
# Create the output file path
output_file_path = os.path.join(json_file_directory, f"{table_name}.sql")

# Write the SQL script to the output file
with open(output_file_path, 'w', encoding='utf-8') as file:
    file.write(sql_scripts)
