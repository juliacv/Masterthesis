#!/bin/bash

#SBATCH --job-name=detect_test.job
#SBATCH --time=0-100:00:00
#SBATCH --mem-per-cpu=10GB

run_dir=runs_default_340
detection_directory=/Home/siv31/jng001/Master_Julia/Yolov5_detection.py;
val_dir=/Home/siv31/jng001/Master_Julia/yolov5/$run_dir/val_output.txt


#Detection
python $detection_directory $run_dir $val_dir

exit 0