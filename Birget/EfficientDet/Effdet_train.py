#!/usr/bin/env python
# coding: utf-8

#Import packages
import torch
from subprocess import call
import sys

#Input
save_dir = sys.argv[1]
epochs = sys.argv[2]
batch_size_in = sys.argv[3]
learning_rate = sys.argv[4]
compound_coeff = sys.argv[5]
min_delta = sys.argv[6]
patience = sys.argv[7]
weights = sys.argv[8]

#Set device as cuda
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Device {device}.")

#train
call(["python", "/Home/siv31/jng001/Master_EfficientDet/Yet-Another-EfficientDet-Pytorch/train.py", "-p", "Request", "-c", f"{compound_coeff}", "--batch_size", f"{batch_size_in}", "--lr", f"{learning_rate}", "--num_epochs", f"{epochs}", "--es_min_delta", f"{min_delta}", "--es_patience", f"{patience}", "--log_path", f"logs/{save_dir}", "-w", f"/Home/siv31/jng001/Master_EfficientDet/weights/{weights}", "--saved_path", f"logs/{save_dir}", "--debug", "True"])

