#!/bin/bash

#SBATCH --job-name=final_Yolov5_loop.job
#SBATCH --time=0-500:00:00
#SBATCH --mem-per-cpu=100GB

direct=run_da3_default_x

#Detection
detection_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_detection_test.py;
validation_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_validation.py;
val_dir=/Home/siv31/jng001/Master_Julia/yolov5/$direct/val_output.txt

python $detection_directory $direct $val_dir

#Read the detection file
filename=/Home/siv31/${USER}/Master_Julia/yolov5/$direct/final/detect_info.txt
line=$(head -n 1 $filename)

#Validation Results of Test set
weights=$line
save_dir_detect=yolov5/$direct/final
task_test=test

python $validation_directory $weights $save_dir_detect $task_test >> /Home/siv31/${USER}/Master_Julia/yolov5/$direct/final/detection_results.txt


#Printing results file
csv_directory=/Home/siv31/jng001/Master_Julia/Yolov5_results_final.csv

python /Home/siv31/${USER}/Master_Julia/Yolov5_best_model_info_3.py $direct $csv_directory; 

#Ending the file
cd ${SLURM_SUBMIT_DIR}
exit 0
