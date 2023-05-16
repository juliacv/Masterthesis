#!/usr/bin/env python
# coding: utf-8

#Import packages
from subprocess import call
import sys
import sys
import torch

#Input
save_path = sys.argv[1] #Save directory
model_path = sys.argv[2]
path_annotations = sys.argv[3] #Path to csv annotation file

#Set device as cuda
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Device {device}.")

#Evaluate
call(["python", "/Home/siv31/jng001/Master_RetinaNet/keras-retinanet/keras_retinanet/bin/evaluate.py", "--gpu", "1", "--save-path", f"{save_path}", "csv", f"{path_annotations}", "/Home/siv31/jng001/Master_RetinaNet/keras-retinanet/datasets/classes.csv",  f"{model_path}",])