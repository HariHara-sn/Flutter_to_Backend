from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_pymongo import PyMongo
from bson import ObjectId
   

app = Flask(__name__)
CORS(app)
mongodb_client = PyMongo(app, uri='mongodb://localhost:27017/delete')
db = mongodb_client.db

@app.route('/send_data', methods=['POST'])
def send_data():
    #send data to db

    # Receive data from Flutter app
    print('f')
    datalist = request.json
    
    db.user_info.insert_many([{"Username": datalist['data']}])
    print("Received data from Flutter:", datalist)

         # Receive data from Flutter app

    # Retrieve data from the database
    

    # db.user_info.insert_many([{"Username": 'Hello', "Password": 'vanakam'}])
    mylist = list(db.user_info.find()) #get from db
    # for doc in mylist:
    #     print(doc)
    serialized_data = []
    print("lis",serialized_data)
    # Convert ObjectId to string and remove _id field
    serialized_data = [{k: v for k, v in doc.items() if k != '_id'} for doc in mylist]
    print("ser",serialized_data)

# Create response data without _id field
    response_data = {"data": serialized_data, "message": "Hari, you got the message from Flask :)"}

    # for doc in mylist:
    #     serialized_doc = {**doc, '_id': str(doc.get('_id'))}
    #     serialized_data.append(serialized_doc)
    response_data = {"data": serialized_data, "message": "Hari, you got the message from Flask :)"}

    # response_data = {"message": "Hari you got the message from Flask :)"}
    print(response_data)
    return jsonify(response_data)


@app.route('/receive_data', methods=['POST'])
def receive_data():
    #send data to db

    # Receive data from Flutter app
    print('f')
    # datalist = request.json
    
    # db.user_info.insert_many([{"Username": datalist['data']}])
    # print("Received data from Flutter:", datalist)

         # Receive data from Flutter app

    # Retrieve data from the database
    

    # db.user_info.insert_many([{"Username": 'Hello', "Password": 'vanakam'}])
    mylist = list(db.user_info.find()) #get from db
    print('mylist',mylist)
    # for doc in mylist:
    #     print(doc)
    # serialized_data = []
    # print("lis",serialized_data)
    # Convert ObjectId to string and remove _id field
    for item in mylist:
        item['_id'] = str(item['_id'])
    # serialized_data = [{k: v for k, v in doc.items() if k != '_id'} for doc in mylist]
    # print("ser",serialized_data)
    

# Create response data without _id field
    response_data = {"data": mylist, "message": "Hari, you got the message from Flask :)"}

    # for doc in mylist:
    #     serialized_doc = {**doc, '_id': str(doc.get('_id'))}
    #     serialized_data.append(serialized_doc)
    # response_data = {"data": serialized_data, "message": "Hari, you got the message from Flask :)"}

    # response_data = {"message": "Hari you got the message from Flask :)"}
    print('new',response_data)
    return jsonify(response_data)

from flask import request

@app.route('/update_data', methods=['POST'])
def update_data():
    # Receive updated data from the request payload
    updated_data = request.json
    print('1',updated_data)
    delete_variable = updated_data.get('delete')
    print('del',delete_variable)
    document_id_str = updated_data.get('_id')
    
    document_id = ObjectId(document_id_str)

    new_username = updated_data.get('Username')

    #condition for delete
    if delete_variable == 10:
        print('Hiiiiiiiiiiiiiiiiiiiiiiiiiiiiii...')
        result = db.user_info.delete_one({'_id': document_id})
        if result.deleted_count == 1:
            return jsonify({"status": "success", "message": "Record deleted successfully"}), 200
        else:
            return jsonify({"status": "error", "message": "Failed to delete record"}), 500
        
    #condition for edit the data    
    else:

        # Update the document in the MongoDB collection
        result = db.user_info.update_one({'_id': document_id}, {'$set': {'Username': new_username}})
        print('result',result)
        # Check if the update operation was successful
        if result.modified_count == 1:
            return jsonify({"status": "success", "message": "Username updated successfully"}), 200
        else:
            return jsonify({"status": "error", "message": "Failed to update username"}), 500

    
    

     
    



if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0', port=5000)

