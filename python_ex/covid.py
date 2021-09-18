import requests
import json
from itertools import islice

URL = "https://covid-api.mmediagroup.fr/v1/"

def avarage_confirmed_per_sqm():
    api = 'cases'
    request = requests.get(f'{URL}/{api}')
    input_dict = json.loads(request.text)
    avarage_per_country = {}
    result_array = {}
    result_array['Countries'] = []
    for country,v in input_dict.items():
        size = 0
        avg_cases = 0
        total_cases = input_dict[country]['All']['confirmed']
        total_deaths = input_dict[country]['All']['deaths']
        total_recovered = input_dict[country]['All']['recovered']
        active_cases = total_cases - total_recovered - total_deaths
        #for some reason some countries have no area at all
        if 'sq_km_area' in input_dict[country]['All']:
          size = input_dict[country]['All']['sq_km_area']/100
          # return the avarage cases per country
          avg_cases = active_cases//size
          #only first decimal
          avg_cases = round(avg_cases,1)
          country_array = {}
          country_array['country'] = country
          country_array['avg_cases'] = avg_cases
        #return rge entire array
        result_array["Countries"].append(country_array)
    return result_array
  
def top_ten():
    api = 'history'
    parameters = {'status':'Confirmed'}
    request = requests.get(f'{URL}/{api}', params=parameters)
    result_array = {}
    result_array['Countries'] = []
    input_dict = json.loads(request.text)
    for country,v in input_dict.items():
        confirmed =  0
        dates = input_dict[country]['All']['dates']
        last_week = dict(islice(dates.items(), 7))
        val = list(last_week.values())
        confirmed = val[0] - val[6]
        country_array = {}
        country_array['country'] = country
        country_array['cases'] = confirmed
        result_array["Countries"].append(country_array)
    result_array["Countries"] = sorted(result_array['Countries'], key=lambda x: x['cases'], reverse=True)[1:11]
    # country_array = sorted(result_array.items(), key=lambda x: x[1], reverse=True)
    return result_array

def greatest_cases_increment():
    api = 'history'
    parameters = {'status':'Confirmed'}
    request = requests.get(f'{URL}/{api}', params=parameters)
    result_array = {}
    result_array['Countries'] = []
    input_dict = json.loads(request.text)
    for country,v in input_dict.items():
        confirmed =  0
        dates = input_dict[country]['All']['dates']
        #last 10 days of confirmed cases in a country
        last_ten_days = dict(islice(dates.items(), 10))
        val = list(last_ten_days.values())
        confirmed = val[0] - val[9]
        country_array = {}
        country_array['country'] = country
        country_array['confirmed'] = confirmed 
        result_array["Countries"].append(country_array)
        # #add country to dict
    #sort by value
    result_array["Countries"] = sorted(result_array['Countries'], key=lambda x: x['confirmed'], reverse=True)[1:6]

    #Return first 5 countries not including global cases#
    return result_array


if __name__ == "__main__":
  infected = greatest_cases_increment()
  avarage_cases_per_country = avarage_confirmed_per_sqm()
  countries = top_ten()
  print(countries)

