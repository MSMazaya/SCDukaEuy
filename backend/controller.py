import pyrebase
from dotenv import load_dotenv
import os

load_dotenv()
config = {
    "apiKey": os.getenv("apiKey"),
    "authDomain": os.getenv("authDomain"),
    "databaseURL": os.getenv("databaseURL"),
    "projectId": os.getenv("projectId"),
    "storageBucket": os.getenv("storageBucket"),
    "messagingSenderId": os.getenv("messagingSenderId"),
    "appId": os.getenv("appId"),
    "measurementId": os.getenv("measurementId"),
}
firebase = pyrebase.initialize_app(config)

auth = firebase.auth()
db = firebase.database()
storage = firebase.storage()
user = auth.sign_in_with_email_and_password('dummy@mail.com', 'something')


# user["displayName"] = "something"

# Pass the user's idToken to the push method
# results = db.child("users").push(data, user['idToken'])

    