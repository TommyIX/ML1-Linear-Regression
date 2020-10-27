第一题：
x_tr, y_tr, x_te, y_te = pww_1_1 (path)

x_tr[0]为第一个w矩阵（不含1），训练
y_tr[0]为第一个w矩阵对应的y列向量，训练
x_te[0]为第一个w矩阵（不含1），测试
y_te[0]为第一个w矩阵对应的y列向量，测试
从0到9一共10个

path为csv文件路径

第二题：
x_tr, y_tr, x_te, y_te = pww_1_1 (path，mode)

path为csv文件路径
mode=1就是10 01
mode=2就是1 0
mode=3就是1 -1

4个返回值跟上面一样
