#!/bin/bash

#SBATCH --job-name=val_test.job
#SBATCH --time=0-200:00:00
#SBATCH --mem-per-cpu=10GB

run_dir=runs_6
VAL_DIRECTORY=/Home/siv31/${USER}/Master_Julia/yolov5/$run_dir/val
rm -rf ${VAL_DIRECTORY}
rm val_output_.txt

#Validation 
validation_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_validation.py;
array=()
save_dir=yolov5/$run_dir/val
task=val
save_txt=/Home/siv31/${USER}/Master_Julia/yolov5/$run_dir/val_output.txt

cd "yolov5"
cd "$run_dir"
cd "train"


for exp in */; do
    echo $exp
    directory="yolov5/$run_dir/train/$exp/weights/best.pt"
    array+=($directory)
    done

cd ".."
cd ".."
cd ".."

for dir in "${array[@]}"; do
    echo $dir >> $save_txt
    python $validation_directory $dir $save_dir $task>> $save_txt
    done

exit 0