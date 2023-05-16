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

directory = sys.argv[1] 
save_dir = sys.argv[2]
task = sys.argv[3]

call(["python", "/Home/siv31/jng001/Master_Julia/yolov5/val.py", "--weights", f"{directory}", "--batch", "16", "--data", "/Home/siv31/jng001/Master_Julia/yolov5/data/request_1.yaml", "--task", f"{task}", "--project", f"{save_dir}", "--name", "val"])