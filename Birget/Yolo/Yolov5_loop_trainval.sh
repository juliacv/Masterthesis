#!/bin/bash

#SBATCH --job-name=Yolov5_loop.job
#SBATCH --time=0-500:00:00
#SBATCH --mem-per-cpu=64GB


cp ${SLURM_SUBMIT_DIR} /Home/siv31/${USER}/Master_Julia/Yolov5_training.py ${SCRATCH_DIRECTORY}
training_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_training.py
hyp_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_randomesearch.py;

direct=run_da2_3
save_dir_train=$direct/train
epochs=35
patience=5

for i in {1..5}; do
    my_tuple=$(python $hyp_directory)
    
    IFS=' '
    read -a strarr<<<"$my_tuple"
    
    lr0=${strarr[0]}
    momentum=${strarr[1]}
    weight_decay=${strarr[2]}
    flipud=0.0 #${strarr[3]}
    fliplr=0.0 #${strarr[4]}
    
    #Train the model using the hyperparameters
    python $training_directory hyp yolov5l $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
    python $training_directory hyp yolov5m $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
    python $training_directory hyp yolov5n $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
    python $training_directory hyp yolov5s $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
    python $training_directory hyp yolov5x $lr0 $momentum $weight_decay $flipud $fliplr $save_dir_train $epochs $patience
 
    # after the job is done we copy our output back to $SLURM_SUBMIT_DIR
    cp output_${SLURM_ARRAY_TASK_ID}.txt ${SLURM_SUBMIT_DIR} /Home/siv31/${USER}/Master_Julia/
           
    done



#Validation 
validation_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_validation.py;
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
csv_directory=/Home/siv31/jng001/Master_Julia/Yolov5_val_results.csv

python /Home/siv31/${USER}/Master_Julia/Yolov5_best_model_info_2.py $direct $csv_directory; 


#Ending the file
cd ${SLURM_SUBMIT_DIR}
exit 0