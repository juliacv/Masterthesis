#!/bin/bash

#SBATCH --job-name=Selection_test.job
#SBATCH --time=0-100:00:00
#SBATCH --mem-per-cpu=50GB

run=run_default_3

#Find the model with highest mAP using weighted average precision
modelselection_Path=/Home/siv31/${USER}/Master_RetinaNet/RetinaNet_modelselection.py
val_file=/Home/siv31/${USER}/Master_RetinaNet/Results/val/$run/val_txt.txt;

python $modelselection_Path $run $val_file

#The directory to the best model
directory_file=/Home/siv31/jng001/Master_RetinaNet/Results/test/$run/detect_info.txt
model_dir=$(head -n 1 $directory_file)

#Evaluate the model on test set
Evaluate_Path=/Home/siv31/${USER}/Master_RetinaNet/RetinaNet_evaluate.py;
Test_Path=/Home/siv31/${USER}/Master_RetinaNet/keras-retinanet/datasets/test_annotations_1.csv

test_save_Path=/Home/siv31/${USER}/Master_RetinaNet/Results/test/$run;
mkdir $test_save_Path
test_file=/Home/siv31/${USER}/Master_RetinaNet/Results/test/$run/test_txt.txt;

echo $model_dir >> $test_file
python $Evaluate_Path $test_save_Path $model_dir $Test_Path >> $test_file