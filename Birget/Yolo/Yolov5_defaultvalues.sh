#!/bin/bash

#SBATCH --job-name=Default_values.job
#SBATCH --time=0-200:00:00
#SBATCH --mem-per-cpu=64GB

cp ${SLURM_SUBMIT_DIR} /Home/siv31/${USER}/Master_Julia/Yolov5_training.py ${SCRATCH_DIRECTORY}
training_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_training.py

direct=run_da2_default
save_dir_train=$direct/train
    
lr0=0.01
momentum=0.937
weight_decay=0.0005
flipud=0.0
fliplr=0.0
epochs=300
patience=15
    
#Train the model using the hyperparameters
python $training_directory hyp yolov5l $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
python $training_directory hyp yolov5m $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
python $training_directory hyp yolov5n $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
python $training_directory hyp yolov5s $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
python $training_directory hyp yolov5x $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
 
# after the job is done we copy our output back to $SLURM_SUBMIT_DIR
cp output_${SLURM_ARRAY_TASK_ID}.txt ${SLURM_SUBMIT_DIR} /Home/siv31/${USER}/Master_Julia/
           

#Validation 
validation_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_validation.py;
rm val_output_.txt
array=()
save_dir=yolov5/$direct/val
task=val
val_dir=/Home/siv31/${USER}/Master_Julia/yolov5/$direct/val_output.txt

cd "yolov5"
cd "$direct"
cd "train"


for exp in */; do
    echo $exp
    directory="yolov5/$direct/train/$exp/weights/best.pt"
    array+=($directory)
    done

cd ".."
cd ".."
cd ".."

for dir in "${array[@]}"; do
    echo $dir >> $val_dir
    python $validation_directory $dir $save_dir $task>> $val_dir
    done

    
#Detection
detection_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_detection.py;
python $detection_directory $direct $val_dir


#Printing results file
csv_directory=/Home/siv31/jng001/Master_Julia/yolov5/$direct/Yolov5_val_results.csv

python /Home/siv31/${USER}/Master_Julia/Yolov5_best_model_info_2.py $direct $csv_directory; 

#Ending the file
cd ${SLURM_SUBMIT_DIR}
exit 0