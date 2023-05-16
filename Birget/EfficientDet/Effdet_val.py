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

#Input
weightfile = sys.argv[1]
compoundcoeff = sys.argv[2]

#Evaluate the model
call(["python", "Yet-Another-EfficientDet-Pytorch/coco_eval.py", "-c", f"{compoundcoeff}", "-p", "Request", "-w", f"{weightfile}"])