def random_hyp():
    import random
    
    lr0_range = [0.0001, 0.001, 0.01, 0.1]
    
    lr0 = random.choice(lr0_range)
    momentum = round(random.uniform(0.750, 1.00), 3)
    weight_decay = round(random.uniform(0.0000, 0.0010), 4)
    flipud = round(random.uniform(0.00, 1.00), 2)
    fliplr = round(random.uniform(0.00, 1.00), 2)
    
    return lr0, momentum, weight_decay, flipud, fliplr

lr0, momentum, weight_decay, flipud, fliplr = random_hyp()
print(lr0, momentum, weight_decay, flipud, fliplr)



