import json
import os

def document_generator(json_folder_path, collection_file_name, embedded_file_names, primary_key):
    # Absolute path to the file using the JSON file that creates a collection
    collection_file_path = os.path.join(json_folder_path, f"{collection_file_name}.json")

    # Read the collection JSON file
    with open(collection_file_path, 'r', encoding='utf-8') as file:
        collection_data = json.load(file)

    # Extract data entries from embedded JSON files 
    embedded_data = {}
    for file_name in embedded_file_names:
        embedded_file_path = os.path.join(json_folder_path, f"{file_name}.json")
        with open(embedded_file_path, 'r', encoding='utf-8') as file:
            embedded_data[file_name] = json.load(file)['results'][0]['items']

    # Combine collections columns value with data from embedded files
    documents = []
    # Copy the collection data entries to the document
    for item in collection_data['results'][0]['items']:
        document = dict(item)
        
        # Merge data from each embedded file into the nested structure
        for embedded_column, embed_values in embedded_data.items():
            embedded_data_list = []
            for embed_value in embed_values:
                # Find the data entries that is associated with the primary key of the collection
                if embed_value[primary_key] == item[primary_key]:
                    # Add the embedded item to the nested list
                    filter_embed_value = {}
                    for key, value in embed_value.items():
                         # Add only embedded value that doesn't have the primary key (remove redundency)
                         if key != primary_key:
                            filter_embed_value[key] = value
                    embedded_data_list.append(filter_embed_value)
            # Only add to document if embedded data is not empty
            if embedded_data_list:
                document[embedded_column] = embedded_data_list
        # Add each document to documents that will be outputted
        documents.append(document)

    return documents

# Prompt user for the path to the JSON folder
json_folder_path = input("Path to the JSON folder: ")

# Prompt user for the main JSON file name
collection_file_name = input("Collection JSON file name: ")

# Prompt user for embedded file names
embedded_files_input = input("Embedded JSON file names (comma-separated): ")
embedded_file_names = [file.strip() for file in embedded_files_input.split(',')]

# Prompt user for primary key
primary_key = input("Enter the primary key: ")

# Generate the document
documents = document_generator(json_folder_path, collection_file_name, embedded_file_names, primary_key)

# Output the documents into a file
output_file = os.path.join(json_folder_path, f"{collection_file_name}_document.json")
with open(output_file, 'w', encoding='utf-8') as file:
    json.dump(documents, file, ensure_ascii=False, indent=2)
