from flask import Flask, request, jsonify
from flask_cors import CORS  #this section is important when you connect flutter with flask
from flask_pymongo import PyMongo
   

app = Flask(__name__)
CORS(app)
mongodb_client = PyMongo(app, uri='mongodb://localhost:27017/backend')
db = mongodb_client.db

print('fk')
@app.route('/login', methods=['POST'])
def login():
    # Extract username from the incoming request
    username = request.json['username']
    password = request.json['password']  # Assuming you still want to keep this line

    # Print the username to the terminal
    print("Username received:", username)
    print("Password",password) 

    
    # db.user_info.insert_many([{"Username": username, "Password": password}])

    # Optionally, continue to process the login attempt (mock example below)
    if username == "Hari" and password == "hari":  # Example condition
        db.user_info.insert_many([{"Username": username, "Password": password}])
        return jsonify({"status": "success", "message": "Logged in successfully"}), 200
    else:
        return jsonify({"status": "error", "message": "Invalid username or password"}), 401

  
if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0', port=5000)
