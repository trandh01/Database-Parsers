This program will output a sql file that insert all the data into the given relation through given inputs.
Note: all column_name inputs must match the columns in the given JSON file.

Use the dataset that is in this file since it has already been modified for these parser!!!

Instruction: Execute the python software and the program will prompt to enter the inputs.

Inputs: 
Path to JSON file: (absolute path to the JSON file)	
Table Name: (preferably the same JSON file name)
column_name: (exact column names in the JSON file)

Example: Path to JSON file: ~\dataset\city.json (must be absolute path)
	Table Name: city
	column_name: name, country, province, population, latitude, longitude, elevation

	Result:
	city.sql