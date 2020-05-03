#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat May  2 21:36:37 2020

@author: shreyjain
"""
import warnings
from flask import Flask, request, jsonify
from distancehacks import stock_predictor

app = Flask(__name__)
shrey = {}

@app.route('/', methods=['GET'])
def func():
    ticker = request.args['ticker']
    #stockTicker = ticker
    print(ticker)
    warnings.filterwarnings("ignore")
    shrey=stock_predictor(ticker)
    return shrey

if __name__ == '__main__':
    app.run(port=8030, debug=True)
    
