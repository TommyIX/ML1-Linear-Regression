num=xlsread("C:\Users\53412\Desktop\机器学习\数据集-第一次作业&第二次作业\数据集-第一次作业&第二次作业\3\Advertising_train.csv",1,"B2:E181");

num(:,1)=num(:,1)./5;        %均一化处理
num(:,3)=num(:,3)./2;        %均一化处理
w=[0.1;0.1;0.1;0.1];   %初始点
k=0;                       %迭代次数
w1=zeros(4,1,10000);       %记录迭代各次参数向量的值
d=zeros(30001,1);       %记录每次均方误差下降的大小
t=zeros(30001,1);       %记录每次迭代的方差
inde=zeros(30001,1);    %记录每次迭代的学习步长
w1(:,:,1)=w;
while 1
    k=k+1;
    a1=f(num(:,1:4),w1(:,:,k));       %计算方差
    a2=f_(num(:,1:4),w1(:,:,k));      %计算梯度
    min=100000000000;
    index=0;                        %记录学习效率
    
    for i=1:100                    %一维搜索确定步长
        w2=w1(:,:,k)-(0.0001/i).*a2;
        if f(num(:,1:4),w2)<min
            index=i;
            min=f(num(:,1:4),w2);
        end
    end
    
    inde(k)=index;
    w1(:,:,k+1)=w1(:,:,k)-(0.0001/index).*a2;   %迭代
    d(k)=abs(f(num(:,1:4), w1(:,:,k+1))-a1);      %记录均方误差下降的大小
    t(k)=a1;
    if d(k)<0.00001
        break
    end
    if k>=30000           %迭代次数小于30000次
        break
    end
end

%测试模型
x1=num(:,1:3);
x1(:,4)=5;
disp("参数向量:")
disp(w1(:,:,k));         %最终的参数向量
%disp(x1*w1(:,:,k));      %参数向量数据的结果
%disp(x1*w1(:,:,k)-num(:,4))  %预测值与实际值比较
diff=x1*w1(:,:,k)-num(:,4);
diff=diff.*diff;
disp("均方误差:")
disp(sum(diff)/180)          %均方误差
figure("Name","d")
semilogx(d(1:k));           %随着迭代次数d的下降曲线
figure("Name","t")
semilogx(t(1:k));          %随着迭代次数均方误差的下降曲线


function e=f(data,w)     %均方误差
    y=data(:,4);
    x=data(:,1:3);
    x(:,4)=5;   %将常数b记为5
    e=(y-x*w)'*(y-x*w);
end

function te=f_(data,w)   %梯度
    y=data(:,4);
    x=data(:,1:3);
    x(:,4)=5;    %将常数b记为5
    te=2*x'*(x*w-y);
end
