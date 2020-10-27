import csv
import numpy as np
from sklearn.model_selection import KFold

def pww_1_1(path):
    csvFile = open(path, "r")
    reader = csv.reader(csvFile)
    xy = []
    m = 0
    for row in reader:
        lr = len(row)
        if m != 0:
            for i in range(lr):
                row[i] = float(row[i])
            xy.append(row[1:lr])
        m += 1
    xy = np.array(xy)
    kf = KFold(n_splits=10, shuffle=False)
    x_tr = []
    y_tr = []
    x_te = []
    y_te = []
    for train_index, test_index in kf.split(xy):
        xy_tr, xy_te = xy[train_index], xy[test_index]
        x_tr.append(xy_tr[:, 0:3])
        y_tr.append(xy_tr[:, 3])
        x_te.append(xy_te[:, 0:3])
        y_te.append(xy_te[:, 3])
    return x_tr,y_tr,x_te,y_te

def pww_1_2_1(path):
    csvFile = open(path, "r")
    reader = csv.reader(csvFile)
    xy = []
    m = 0
    for row in reader:
        lr = len(row)
        if m != 0:
            if row[1]=='No':
                row[0]=0
            if row[1]=='Yes':
                row[0]=1
            if row[2]=='No':
                row[1]=0
                row[2]=1
            if row[2]=='Yes':
                row[1]=1
                row[2]=0
            row[3]=float(row[3])
            row[4]=float(row[4])
            row.reverse()   #student no -> 10
            xy.append(row)
        m += 1
    xy = np.array(xy)
    kf = KFold(n_splits=10, shuffle=False)
    x_tr = []
    y_tr = []
    x_te = []
    y_te = []
    for train_index, test_index in kf.split(xy):
        xy_tr, xy_te = xy[train_index], xy[test_index]
        x_tr.append(xy_tr[:, 0:4])
        y_tr.append(xy_tr[:, 4])
        x_te.append(xy_te[:, 0:4])
        y_te.append(xy_te[:, 4])
    return x_tr,y_tr,x_te,y_te

def pww_1_2_2(path):
    csvFile = open(path, "r")
    reader = csv.reader(csvFile)
    xy = []
    m = 0
    for row in reader:
        lr = len(row)
        if m != 0:
            if row[1]=='No':
                row[1]=0
            if row[1]=='Yes':
                row[1]=1
            if row[2]=='No':
                row[2]=0
            if row[2]=='Yes':
                row[2]=1
            row[3]=float(row[3])
            row[4]=float(row[4])
            row.reverse()   #student no -> 0
            xy.append(row[0:4])
        m += 1
    xy = np.array(xy)
    kf = KFold(n_splits=10, shuffle=False)
    x_tr = []
    y_tr = []
    x_te = []
    y_te = []
    for train_index, test_index in kf.split(xy):
        xy_tr, xy_te = xy[train_index], xy[test_index]
        x_tr.append(xy_tr[:, 0:3])
        y_tr.append(xy_tr[:, 3])
        x_te.append(xy_te[:, 0:3])
        y_te.append(xy_te[:, 3])
    return x_tr,y_tr,x_te,y_te

def pww_1_2_3(path):
    csvFile = open(path, "r")
    reader = csv.reader(csvFile)
    xy = []
    m = 0
    for row in reader:
        lr = len(row)
        if m != 0:
            if row[1]=='No':
                row[1]=0
            if row[1]=='Yes':
                row[1]=1
            if row[2]=='No':
                row[2]=-1
            if row[2]=='Yes':
                row[2]=1
            row[3]=float(row[3])
            row[4]=float(row[4])
            row.reverse()   #student no -> -1
            xy.append(row[0:4])
        m += 1
    xy = np.array(xy)
    kf = KFold(n_splits=10, shuffle=False)
    x_tr = []
    y_tr = []
    x_te = []
    y_te = []
    for train_index, test_index in kf.split(xy):
        xy_tr, xy_te = xy[train_index], xy[test_index]
        x_tr.append(xy_tr[:, 0:3])
        y_tr.append(xy_tr[:, 3])
        x_te.append(xy_te[:, 0:3])
        y_te.append(xy_te[:, 3])
    return x_tr,y_tr,x_te,y_te

def pww_1_2(path,mode):
    if mode==1:
        return(pww_1_2_1(path))
    if mode==2:
        return(pww_1_2_2(path))
    if mode==3:
        return(pww_1_2_3(path))

csv1='Advertising_train.csv'
csv2='Default_train.csv'
x_tr,y_tr,x_te,y_te=pww_1_1(csv1)
x_tr,y_tr,x_te,y_te=pww_1_2(csv2,3)
