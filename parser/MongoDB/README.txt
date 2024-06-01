This program will generate a document that can be inputted into noSQL database (mongoDB) through given inputs.
These inputs must be valid for the program to function correctly. The primary key value must be the same for
every embedded JSON files to get the correct data for the document. Example, the primary key of country is country_code,
so there must a column in the embedded file that is also country_code. 

Use the dataset that is in this file since it has already been modified for these parser.

Instruction: Execute the python software and the program will prompt to enter inputs.

Note: For this document generator to work properly, all JSON file that is needed in the document 
will need to be in the same folder.

Inputs:
Path to the JSON folder: (absolute path to the JSON folder)
Collection JSON file name: (File that will have the collection data)
Embedded JSON file names (comma-separated): (Files that will be added as embedded data)
Enter the primary key: (primary key is to match the correct entries from each embedded data)

Example: Path to the JSON folder: ~\dataset\city.json
	 Collection JSON file name: city
	 Embedded JSON file names (comma-separated): citylocalname, cityothername, citypopulations, located_on
	 Enter the primary key: city_name

	Result: 
	 city_document.json
	 
	



