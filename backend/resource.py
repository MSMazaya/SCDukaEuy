from flask_restful import Resource
from . import controller

class Video(Resource):
	# def get(self, video_id):
    		# return videos[video_id]
	
	def get(self):
    		controller.db.child("users").push("something", controller.user['idToken'])
			# args = parser.video_put_args.parse_args()
			# videos[video_id] = args
			# return videos[video_id], 201