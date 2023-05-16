#!/bin/bash

#SBATCH --job-name=best_model_yolo.job
#SBATCH --time=0-100:00:00
#SBATCH --mem-per-cpu=10GB


#Printing results file
direct=run_da2_default_sx
csv_directory=/Home/siv31/jng001/Master_Julia/Yolov5_val_results.csv

python /Home/siv31/${USER}/Master_Julia/Yolov5_best_model_info_2.py $direct $csv_directory; 

