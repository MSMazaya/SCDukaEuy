from flask_restful import Resource
from . import parser

class Video(Resource):
	def get(self, video_id):
    		return videos[video_id]
	
	def put(self, video_id):
			args = parser.video_put_args.parse_args()
			videos[video_id] = args
			return videos[video_id], 201