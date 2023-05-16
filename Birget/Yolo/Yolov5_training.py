#!/usr/bin/env python
# coding: utf-8

#Import packages
import cv2
import torch
from subprocess import call, Popen

import numpy as np
import os
from PIL import Image
import matplotlib.pyplot as plt
import random
import sys

#Hyperparameter yaml file
Filename = sys.argv[1] #Name of the hyperparameterfile 
model = sys.argv[2] #Name of the model
lr0 = sys.argv[3] # Initial learning rate 
momentum = sys.argv[4] #SGD momentum 
weight_decay = sys.argv[5] #optimizer weight decay 5e-4 
flipud = sys.argv[6] #image flip up-down (probability)
fliplr = sys.argv[7] #image flip left-right (probability)
save_dir = sys.argv[8]
nr_epochs = sys.argv[9]
patience = sys.argv[10]


arg_list = ["py_name", "Filename", "Model", "lr0", "lrf", "momentum", "weight_decay", "warmup_epochs", "warmup_momentum", "warmup_bias_lr", "box", "cls", "cls_pw", "obj", "obj_pw", "iou_t", "anchor_t", "fl_gamma", "hsv_h", "hsv_s", "hsv_v", "degrees", "translate", "scale", "shear", "perspective", "flipud", "fliplr", "mosaic", "mixup", "copy_paste"]

hyp_list = ["name", Filename, model, lr0, 0.01, momentum, weight_decay, 3.0, 0.8, 0.1, 0.05, 0.5, 1.0, 1.0, 1.0, 0.20, 4.0, 0.0, 0.015, 0.7, 0.4, 0.0, 0.1, 0.5, 0.0, 0.0, flipud, fliplr, 1.0, 0.0, 0.0]

#File with the hyperparameters
filename = (f"{Filename}_{model}_{lr0}_{momentum}_{weight_decay}_{flipud}_{fliplr}"+".yaml")
new_file_path = os.path.join(f"/Home/siv31/jng001/Master_Julia/yolov5/data/hyps/{filename}")
new_file = open(new_file_path, "w")

for arg, element in zip(arg_list, hyp_list):
         
    if arg == "py_name":
        continue
    if arg == "Filename":
        continue
    if arg == "Model":
        continue
      
    new_file.write(f"{arg}" + ": " + f"{element}")
    new_file.write("\n")
    
new_file.close()


#Set up yolov5
#call(["git", "clone", "https://github.com/ultralytics/yolov5"])
#os.chdir("/Home/siv31/jng001/Master_Julia/yolov5")
#call([sys.executable, "-m", "pip", "install", "-qr", "/Home/siv31/jng001/Master_Julia/yolov5/requirements.txt"])

import utils
# Set device
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Device {device}.")

# ## Training
call(["python", "/Home/siv31/jng001/Master_Julia/yolov5/train.py", "--img", "640", "--batch", "16", "--epochs", f"{nr_epochs}", "--data", "/Home/siv31/jng001/Master_Julia/yolov5/data/request_1.yaml", "--weights", f"{model}.pt", "--cfg", f"{model}.yaml", "--project", f"{save_dir}", "--hyp", f"/Home/siv31/jng001/Master_Julia/yolov5/data/hyps/{filename}", "--patience", f"{patience}"])






