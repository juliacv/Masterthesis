# Master thesis
Code and examples for Julia Nguyen's master thesis.
How to run the codes and the data of the codes is explained in Appendix A in the master thesis. 

## Folder Birget: 
The folder includes all codes for running Yolov5, RetinaNet and EfficientDet on Birget slurm controller. 

The training, validation and detection python files uses the belonging training, validation and detection files of the original repositories and are meant to be used together with the bash files. The parameter run/save_run/direct in the different files, are the name of the folder where the results will be saved. This should be changed for each run of the code. 

### Yolo
For Yolo the files *Yolov5_loop_trainval.sh*, *Yolov5_defaultvalues.sh* and *Yolov5_finalmodel.sh* are the most important files to run for a full model selection and model evaluation process. 
- *Yolov5_loop_trainval.sh* includes a loop with training of the five different pretrained weights, random search of hyperparameters, validation of the the models with validation data, and detection on the validation data.
- *Yolov5_defaultvalues.sh* is the same loop, but default values of the hyperparameters (the flipping hyperparameters are still set to 0)
- *Yolov5_finalmodel.sh* is the validation and detection process for the final model on the test set. 

Yolo has a folder named "Other" as well. This folder contains the sligthly changed validation code for Yolov5, *val.py*,to be able to print out the metrics and use the metrics further into the training and validation loop. The folder also includes the files *request_1.yaml* and *hyp.scratch-low.yaml*. The first file is the yaml file for the Request dataset with paths to the images, labels and the number of classes with names. This files should be moved to *yolov5/data* after the original repository is cloned. The second file, is the file with the default hyperparameters used in this thesis. 

### RetinaNet

### EfficientDet

## Folder Exploratory data analysis: 
- Includes codes for  plotting and analysis of the data.


## Folder Preprocessing: 
- Includes codes for transformations of annotations and data augmentation.
