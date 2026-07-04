import csv
import json
import chardet
import gzip

arquivo = 'C:/Users/Kleber/Documents/agropecuaria.csv'

# Detect the encoding of the CSV file
with open(arquivo, 'rb') as f:
    result = chardet.detect(f.read())
    encoding = result['encoding']

# Read the CSV file with the detected encoding
with open(arquivo, mode='r', encoding=encoding) as csv_file:
    csv_reader = csv.DictReader(csv_file)
    data = [row for row in csv_reader]

# Write the data to a JSON file
# with open('C:/Users/Kleber/Documents/inpc_completo2.json', mode='w', encoding='utf-8') as json_file:
#    json.dump(data, json_file, indent=4, ensure_ascii=False)

# Write the data to a JSON file
with gzip.open('C:/Users/Kleber/Documents/agropecuaria.json.gz', mode='wt', encoding='utf-8') as gzip_file:
    json.dump(data, gzip_file, indent=4, ensure_ascii=False)

print("Compressed JSON file created successfully!")
