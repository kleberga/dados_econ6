import gzip

# Path to the existing JSON file
json_file_path = 'C:/Users/Kleber/Documents/indice_precos.json'

# Read the JSON file
with open(json_file_path, 'rb') as json_file:
    json_data = json_file.read()

# Compress and write the data to a Gzip file
with gzip.open('C:/Users/Kleber/Documents/indice_precos.json.gz', 'wb') as gzip_file:
    gzip_file.write(json_data)

print("JSON file compressed successfully!")
