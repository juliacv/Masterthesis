#Import packages
from subprocess import call

import numpy as np
import sys

save_dir = sys.argv[1]
val_dir = sys.argv[2]

directory =[]
mAP50 = []
mAP50_95 = []

with open(f"{val_dir}", 'r') as val_txt:
    for count, line in enumerate(val_txt, start=1):
        if count % 2 == 0:
           new_line = line.replace("\n","").split(",") 
           mAP50.append(float(new_line[2]))
           mAP50_95.append(float(new_line[3]))
        else:
           line = line.replace("\n","")
           directory.append(line)
            
max_index = np.argmax(mAP50)
path = directory[max_index]
exp = path.split("/")
exp_best = exp[3]


print("Detection on the test set")
call(["python", "/Home/siv31/jng001/Master_Julia/yolov5/detect.py", "--weights", f"{path}", "--img", "640", "--conf", "0.25", "--source", "/Home/siv31/jng001/Master_Julia/datasets/Request_da_2/images/val", "--data","/Home/siv31/jng001/Master_Julia/yolov5/data/request_1.yaml", "--project", f"yolov5/{save_dir}/detect", "--name", "detect", "--save-conf", "--save-txt"])


#Save weights used for detection and validation results
info_file = open(f"/Home/siv31/jng001/Master_Julia/yolov5/{save_dir}/detect/detect_info.txt", "w")
info_file.write(f"{path}\n")
info_file.write(f"{exp_best}")
info_file.close()

