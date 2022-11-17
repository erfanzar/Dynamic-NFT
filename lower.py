# r = input('string : ')

# print(r.lower())
import json
import os 
for i in range(15):
    with open(f'a-{i}.json','w') as w:
        json.dump({
            'name':f'DNFT at LEVEL : {i}',
            "description": "Your at {i} level",
            'image' : f'https://www.halaholidays.com/nft/{i+1}.png',
        },w)