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

save_dir = sys.argv[1]
val_dir = sys.argv[2]

directory = []
mAP_wap = []
mAP = []

with open(f"{val_dir}", 'r') as val_txt:
    line_array = val_txt.readlines()
    number = int(len(line_array)/4)
    val_array = np.array(line_array).reshape(number, 4)
    
    for model in val_array:
        directory.append(model[0])
        map_wap_el = str(model[2]).split(":")
        mAP_wap.append(float(map_wap_el[1]))
        map_el = str(model[3]).split(":")
        mAP.append(float(map_el[1]))          

val_txt.close()

max_index = np.argmax(mAP_wap)
path = directory[max_index]

#Save Information to use on test set
newpath = f"/Home/siv31/jng001/Master_RetinaNet/Results/test/{save_dir}/"
if not os.path.exists(newpath):
    os.makedirs(newpath)
    
info_file = open(f"/Home/siv31/jng001/Master_RetinaNet/Results/test/{save_dir}/detect_info.txt", "w")
info_file.write(f"{path}\n")
info_file.close()

