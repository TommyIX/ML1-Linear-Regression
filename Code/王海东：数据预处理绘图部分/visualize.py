
import matplotlib.pyplot as plt
import pandas as pd
import csv

def visualize(path):
    with open(path, 'r') as ad_data:
        num = []
        workbook = csv.reader(ad_data)
        col = next(workbook)
        # 处理Default_train中的No 和 Yes的循环
        for tmp in workbook:
            if workbook.line_num > 1 and (tmp[1] == 'No' or tmp[1] == 'Yes'):
                if tmp[1] == 'No':
                    tmp[1] = 0
                else:
                    tmp[1] = 1
                if tmp[2] == 'No':
                    tmp[2] = 0
                else:
                    tmp[2] = 1
            tmp = list(map(float, tmp))
            num.append(tmp)

        # 全部数据的Dataframe
        df = pd.DataFrame(num, columns=col)
        df.drop(col[0], axis=1, inplace=True)
        df.index = range(1, df.shape[0] + 1)

        # 可视化
        if ad_data.name == "Data/Advertising_train.csv":
            colors = {"TV": 'r', "radio": 'b', "newspaper": 'g'}
            legn = []
            plt.figure(figsize=(16, 8))
            for tmps in df.columns:
                if tmps != "sales":
                    plt.scatter(df[tmps], df["sales"], s=5, c=colors[tmps])
                    legn.append(tmps)
            #修改坐标轴和图例
            plt.legend(legn)
            plt.ylabel("Sales")
            plt.xticks(range(0, 300, 20))
            #plt.savefig("Q1_scatter.png")
            plt.show()

        if ad_data.name == "Data/Default_train.csv":
            plt.figure(figsize=(16, 8))
            ax = plt.axes(projection='3d')
            # print(df.loc[1]["default"])
            tmp1 = []
            tmp2 = []
            for idx in df.index:
                if df.loc[idx]["default"] == 0:
                    tmp1.append(idx - 1)
                else:
                    tmp2.append(idx - 1)
            pos = df.drop(df.index[tmp1], inplace=False)
            neg = df.drop(df.index[tmp2], inplace=False)
            ax.scatter3D(pos.income, pos.balance, pos.student, s=5, c='r', alpha=0.5)
            ax.scatter3D(neg.income, neg.balance, neg.student, s=5, c='g', alpha=0.2)
            #修改坐标轴和图例
            plt.legend(["Default", "NotDefault"])
            ax.set_xlabel("Income")
            ax.set_ylabel("Balance")
            ax.set_zlabel("Student", rotation=180)
            ax.set_zlim(-1, 2)
            ax.set_zticks([0, 1])
            ax.set_zticklabels(["No", "Yes"])
            # plt.savefig("Q2_scatter.png")
            plt.show()

visualize('Data/Default_train.csv')





