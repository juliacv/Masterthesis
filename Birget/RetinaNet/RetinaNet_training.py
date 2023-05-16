#!/usr/bin/env python
# coding: utf-8

#Import packages
import torch
from subprocess import call
import sys


#Input
Save_dir = sys.argv[1] #Save directory
epoch_in = sys.argv[2]
batch_size_in = sys.argv[3]
learning_rate_in = sys.argv[4]
steps_in = sys.argv[5]


#Set device as cuda
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Device {device}.")


#Setup RetinaNet
#call(["git", "clone", "https://github.com/fizyr/keras-retinanet"])
#call(["pip", "install","numpy", "--user"])

#os.chdir("/Home/siv31/jng001/Master_RetinaNet/keras-retinanet")
#call(["pip", "install", ".", "--user"])
#call(["python", "setup.py", "build_ext", "--inplace"])


#Train and validate 
call(["python", "/Home/siv31/jng001/Master_RetinaNet/keras-retinanet/keras_retinanet/bin/train.py", "--batch-size", f"{batch_size_in}",  "--gpu", "1", "--epochs", f"{epoch_in}", "--lr", f"{learning_rate_in}", "--steps", f"{steps_in}","--snapshot-path", f"{Save_dir}", "--weights", "/Home/siv31/jng001/Master_RetinaNet/resnet50_oid_v1.0.0.h5",  "csv", "/Home/siv31/jng001/Master_RetinaNet/keras-retinanet/datasets/train_annotations_1.csv", "/Home/siv31/jng001/Master_RetinaNet/keras-retinanet/datasets/classes.csv", "--val-annotations", "/Home/siv31/jng001/Master_RetinaNet/keras-retinanet/datasets/val_annotations_1.csv" ])