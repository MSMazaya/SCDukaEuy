from flask_restful import reqparse
import werkzeug


photo_put_args = reqparse.RequestParser()
photo_put_args.add_argument("nama", type=str, help="Name of the video is required", required=True)
photo_put_args.add_argument("keluhan", type=str, help="Views of the video", required=True)
photo_put_args.add_argument("contact", type=str, help="Likes on the video", required=True)
# photo_put_args.add_argument("photo", type=werkzeug.datastructures.FileStorage, help="Likes on the video", required=True)