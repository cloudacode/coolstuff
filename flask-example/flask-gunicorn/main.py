from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/')
@app.route('/index')
def hello():
    return 'Hello cloudacode!'

# uncomment below errorhandler if you want to handle 404
# @app.errorhandler(404)
# def not_found(error=None):
# 	message = {
#         'status': 404,
#         'message': 'Not Found: ' + request.url,
#     }
# 	res = jsonify(message)
# 	res.state_code = 404
    
# 	return res
