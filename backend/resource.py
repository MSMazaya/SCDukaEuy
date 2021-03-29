from flask_restful import Resource
from flask import request
from PIL import Image
import torch
from torchvision import transforms
from .mode import *
from . import controller
from . import parser
from pathlib import Path
import os

BASE_DIR = Path(__file__).resolve().parent.parent
kategori = ["Melanoma", "NotMelanoma"]
model = MyCustomModule()
model.load(os.path.join(BASE_DIR, "backend\\weights_best.pth"))
crop_size = 224
mean = (0.485, 0.456, 0.406)
std = (0.229, 0.224, 0.225)
loader = transforms.Compose([
transforms.Resize((crop_size,crop_size)),
transforms.ToTensor(),
transforms.Normalize(mean,std)
])

class Video(Resource):
	def post(self):
		args = parser.photo_put_args.parse_args()
		img = request.files['photo']
		controller.storage.child(args['nama']).put(img)
		url = controller.storage.child(args['nama']).get_url(None)
		image = Image.open(img)
		image = loader(image).float()
		image = image.unsqueeze(0)
		with torch.no_grad():
			model.eval()
			output = model(image).exp()
			name_preds = kategori[output.argmax()]
			conf_preds = output.max()*100
		confidence = ''
		for i in [x for x in str(conf_preds) if x in ['1','2','3','4','5','6','7','8','9','0','.']]:
			confidence += i
		confidence += '%'
		controller.db.child("photos").push({**args, 'photo':url, "confidence-rate":confidence, "prediction":name_preds}, controller.user['idToken'])
		return args, 201

class UserVideo(Resource):
	def get(self,username):
		photos=controller.db.child("photos").order_by_child("nama").equal_to(username).get(token=controller.user['idToken'])
		hasil = []
		for i in photos:
			hasil.append(photos.val())
		return hasil,201