from flask import Flask, request, jsonify 
app = Flask(__name__)

@app.route('/stockquery')
def func():
    #So to test this on local host: "127.0.0.1:5000/stockquery?stockticker=stockTickerNameHere" and then you'll send 
    stockTicker = request.args.get('stockticker') 
    return jsonify({'ticker' : stockTicker})

@app.route('/response')
def func2():
    #SHASHANK, this is gonna be where I need your code, to get the array and the graph passed
    #as whatever var its gonna be passed as
    return {'stockPrices' : [], 'graph' :  11}
    

if __name__ == '__main__':
    app.run(port = 5000, debug=True)
