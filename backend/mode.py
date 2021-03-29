import torch
from torchvision.models import resnet50
from torch import nn

class MyCustomModule(nn.Module):
    def __init__(self):
        super().__init__()
        self.resnet = resnet50(pretrained = True)
        self.freeze()
        self.resnet.fc =nn.Sequential(nn.Linear(2048, 1024),
                                     nn.ReLU(),
                                     nn.Dropout(0.2),
                                      
                                     nn.Linear(1024, 256),
                                     nn.ReLU(),
                                     nn.Dropout(0.2),
                                      
                                     nn.Linear(256, 2),
                                     nn.LogSoftmax())    
        
    def forward(self, x):
        return self.resnet(x)
    
    def freeze(self):
        for param in self.resnet.parameters():
            param.requires_grad = False     
        
    def unfreeze(self):
        for param in self.resnet.parameters():
            param.requires_grad = True
        
    def load(self, model_path):
        self.load_state_dict(torch.load(model_path, map_location="cpu"))
