import pyrebase

config = {
    "apiKey": "AIzaSyB8v03bSjMpazlVfph_o5jzWaEE1Q2KBT0",
    "authDomain": "scdukaeuy.firebaseapp.com",
    "databaseURL": "https://scdukaeuy-default-rtdb.firebaseio.com",
    "projectId": "scdukaeuy",
    "storageBucket": "scdukaeuy.appspot.com",
    "messagingSenderId": "1019993864975",
    "appId": "1:1019993864975:web:b486d1001b19bc8b995c7a",
    "measurementId": "G-1S1T1JC3B1"
}

firebase = pyrebase.initialize_app(config)

auth = firebase.auth()
db = firebase.database()
storage = firebase.storage()
user = auth.sign_in_with_email_and_password('dummy@mail.com', 'something')
user["displayName"] = "something"

# Pass the user's idToken to the push method
# results = db.child("users").push(data, user['idToken'])

    