#!/usr/bin/env python
# coding: utf-8

#Import packages
from subprocess import call
import sys


#Input
Path_training = sys.argv[1] #Training model directory
Path_save = sys.argv[2] #Saving directory

call(["python", "setup.py", "build_ext", "--inplace"])

#Transform the training model to inference model
call(["python", "/Home/siv31/jng001/Master_RetinaNet/keras-retinanet/keras_retinanet/bin/convert_model.py", f"{Path_training}", f"{Path_save}"])
