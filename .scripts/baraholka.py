#!/usr/bin/python

import requests
import urllib.request
import sys
from bs4 import BeautifulSoup

url = 'https://baraholka.onliner.by/search.php?by=created&topicTitle=1&cat=1'

class item:
    def __init__(self, name, desc, city, href, seller, price, create_time):
        self.name = name
        self.desc = desc
        self.city = city
        self.href = href 
        self.seller = seller
        self.price = price
        self.create_time = create_time


def parse_page(request):
    try:
        response = requests.get(url + '&q=' + request)
    except:
        return None

    soup = BeautifulSoup(response.text, 'html.parser')

    data = []
    table = soup.find('table', attrs={'class':'ba-tbl-list__table'})

    rows1 = table.find_all('td', attrs={'class':'frst ph colspan'})
    rows2 = table.find_all('td', attrs={'class':'cost'})
    rows3 = table.find_all('td', attrs={'class':'lst post-tls'})

    for row in zip(rows1, rows2, rows3):
        raw_data = row[0]
        raw_cost = row[1]
        raw_created = row[2]

        temp = raw_data.find('td', attrs={'style':'padding:0; border-width:0'})
        name = temp.find('a').string

        try:
            descr = temp.find_all('p')[1].string
        except:
            descr = '...'

        city = raw_data.find('strong').string
        seller = raw_data.find('a', attrs={'class':'gray'}).string

        try:
            price = raw_cost.find('div', attrs={'class':'price-primary'}).string
        except:
            price = '?'
        created = '<>'

        href = raw_data.find_all('a')[0].string

        data.append(item(name, descr, city, href, seller, price, created))

    return data


if len(sys.argv) != 2:
    print('Usage:', sys.argv[0], '<request>')
    sys.exit()

items = parse_page(sys.argv[1])

if items is None:
    sys.exit(1)
else:
    for item in items:
        print('#', item.name)
        print(item.desc)
        print('+', item.city)
        print('+', item.seller)
        print('+', item.href)
        print('price:', item.price)
        print()

