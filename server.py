#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat May  2 21:19:39 2020

@author: shreyjain
"""

from flask import Flask, request
import requests

app = Flask(__name__)

@app.route('/', methods=['GET'])
def func():
    ticker = request.args['ticker']
    jsonObj = {'ticker' : ticker}
    r = requests.get(url = 'http://127.0.0.1:8030/?ticker='+str(ticker))
    return r

if __name__ == "__main__":
    app.run(port = 5000, debug=True)
    
