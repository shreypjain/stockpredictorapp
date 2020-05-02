from flask import Flask, request, jsonify 
app = Flask(__name__)

@app.route('/stockquery')
def func():
    stockTicker = request.args.get('stockticker') 
    return jsonify({'ticker' : stockTicker})
    

if __name__ == '__main__':
    app.run(port = 5000, debug=True)
