#Save the information of the best model in one place
import csv
import sys

run_dir = sys.argv[1]
save_dir = sys.argv[2]

with open(f"/Home/siv31/jng001/Master_Julia/yolov5/{run_dir}/final/detect_info.txt") as exp_file:
    for count, line in enumerate(exp_file, start=1):
        if count % 2 == 0:
           exp = line.replace("\n","")
    exp_file.close()

opt_list=[]
with open(f"/Home/siv31/jng001/Master_Julia/yolov5/{run_dir}/train/{exp}/opt.yaml") as opt_file:
    for line in opt_file:
        new_line = line.replace("\n","").replace(" ","").split(":")
        opt_list.append(new_line)

weights = opt_list[0][1]
model_path = opt_list[1][1].split("/")
model = model_path[7]
lr0 = opt_list[4][1]
momentum = opt_list[6][1]
flipud = opt_list[27][1]
fliplr = opt_list[28][1]
weight_decay = opt_list[7][1]
epochs = opt_list[32][1]
batch = opt_list[33][1]


with open(f"/Home/siv31/jng001/Master_Julia/yolov5/{run_dir}/final/detection_results.txt") as detect_file:
    for line in detect_file:
        new_line = line.replace("\n","").split(",")
        mp=new_line[0]
        mr=new_line[1]
        mAP50=new_line[2]
        mAP50_95=new_line[3]
    detect_file.close()


#Training info of the best model
train_line = f"The training exp that had the best weights was: {exp} in directory: {run_dir}\n"

#General info of the best model
model_line = f"The model architecture of the best model was:{model}, with the weights: {weights}.\n"
hyperparameter_line = f"The hyperparameters tuned was, \n initial learning rate lr0: {lr0} \n SGD momentum: {momentum}, \n Weight decay: {weight_decay}, \n flip up and down flipud: {flipud}, \n and flip left and right fliplr: {fliplr}.\n"
epochs_line = f"Number of epochs used was: {epochs}, and the batch size was given was: {batch}.\n"


#Results of the best model
results_line = f"The precision of the best model was {mp}, recall was {mr}, mAP50 was {mAP50} and mAP50-95 was {mAP50_95}.\n"


#Write everything to file
info_file = open(f"/Home/siv31/jng001/Master_Julia/yolov5/{run_dir}/Yolov5_results_final.txt", "w")
info_file.write(train_line)
info_file.write(model_line)
info_file.write("\n")
info_file.write(hyperparameter_line)
info_file.write("\n")
info_file.write(epochs_line)
info_file.write("\n")
info_file.write(results_line)
info_file.close()

#CSV file with the information
Header = ["Runs","Best train exp", "Model architecture", "Weights", "lr0", "SGD momentum", "Weight Decay", "Flip Up Down", "Flip Left Right", "Epochs", "Batch", "Precision", "Recall", "mAp50", "mAP50_95"]
data = [run_dir, exp, model, weights, lr0, momentum, weight_decay, flipud, fliplr, epochs, batch, mp, mr, mAP50, mAP50_95]

with open(f"{save_dir}", "a") as csv_file:
    writer = csv.writer(csv_file)
    writer.writerow(Header)
    writer.writerow(data)
    
    csv_file.close()
    