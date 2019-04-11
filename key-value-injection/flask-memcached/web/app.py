#!/bin/python
from flask import Flask, request
import pylibmc
mc=pylibmc.Client(["memcached"],binary=False)
app = Flask(__name__)
@app.route('/')
def hello_world():
    return 'Hello there!'

@app.route('/api/get')
def api():
    print request.args['key']
    return "value for your key is : " + str(mc.get(str(request.args['key'])))
@app.route('/api/set')
def set():
    mc.set(str(request.args['key']),"default")
    return "Done"

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port=8800)
