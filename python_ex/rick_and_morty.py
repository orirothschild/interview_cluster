import requests
import json
from pathlib import Path
import csv
import os
import pandas as pd

if __name__ == "__main__":
      
      #querrying with graphQL
      
   query = """query {
    characters (filter: { species: "Human", status: "Alive" }){
    results {
    name
    origin {name}
    location {name}
    image
    } 
  }
}"""

url = 'https://rickandmortyapi.com/graphql/'
r = requests.post(url, json={'query': query})
input_dict = json.loads(r.text)
#loading the response into JSON

results_dict = [x for x in input_dict['data']['characters']['results']]
#filtering the data for elements that came from earth as origin
output_dict = [x for x in results_dict if "Earth" in x['origin']['name']]

#removing the urequested element origin
for element in output_dict:
      element.pop('origin',None)      
#creating a JSON file
with open("rick_and_morty.json","w") as f:
    json.dump(output_dict,f)
#creating a CSV file
with open("rick_and_morty.csv", "w") as f:
  df = pd.read_json ("rick_and_morty.json")
  df.to_csv(r'rick_and_morty.csv', index = None)

