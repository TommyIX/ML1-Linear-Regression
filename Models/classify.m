%模型参数
%csv文件的地址：
path = "C:\Users\jhong\OneDrive\当前项目\彭卫文作业一二 9日代码 13日前交\Data\Advertising_train.csv";

[data,txt,raw]=xlsread(path,1,"B2:E9001");
x=zeros(9000,5);

tea_stu=zeros(9000,2);
default=zeros(9000,1);
for i=1:9000
    if txt(i,2)=="No"
        tea_stu(i,:)=[0,1];
    else
        tea_stu(i,:)=[1,0];
    end
    if txt(i,1)=="No"
        default(i)=0;
    else
        default(i)=1;
    end
end


x(:,1:2)=data;
x(:,3:4)=tea_stu;
%均一化处理
x(:,5)=1;
x(:,1)=x(:,1)./1000;
x(:,2)=x(:,2)./10000;

b=[0.01;0.01;0.01;0.01;0.01];   %初始点
k=0;                       %迭代次数
b1=zeros(5,1,10001);       %记录迭代各次的值
d=zeros(10001,1);       %记录每次下降的距离
t=zeros(10001,1);       %记录每次迭代的方差
inde=zeros(30001,1);    %记录每次迭代的学习步长
b1(:,:,1)=b;

while 1
    k=k+1;
    a1=f(x(:,:),default(1:9000),b1(:,:,k));       %计算最大似然
    a2=f_(x(:,:),default(1:9000),b1(:,:,k));      %计算梯度
    min=100000000000;
    index=0;                        %记录学习效率
    
    for i=1:100                    %一维搜索确定步长
        b2=b1(:,:,k)-(0.001/i).*a2;
        if f(x(:,:),default(1:9000),b2)<min
            index=i;
            min=f(x(:,:),default(1:9000),b2);
        end
    end
    inde(k)=index;
    
    b1(:,:,k+1)=b1(:,:,k)-(0.001/index).*a2;   %迭代
    d(k)=abs(f(x(:,:), default(1:9000),b1(:,:,k+1))-a1);      %记录下降的距离
    t(k)=a1;
    if d(k)<=0.1
        break
    end
end

 test1=exp(x(:,:)*b1(:,:,k))./(1+exp(x(:,:)*b1(:,:,k)));
 
 %再缩放处理
 test1=(test1)./(1-test1); %激活函数
 blyat = test1
 for i=1:9000
    if(test1(i)>0.7)
        test1(i)=1;
    else
        test1(i)=0;
    end
 end
 
 
 times=length(find(test1));
right=0;  %记录找到了多少个真 正例
 for i=1:9000
    if(test1(i)==default(i)&&test1(i)==1)
        right=right+1;
    end
 end
 
 right3=right/294;  %查全率
 right4=right/times; %查准率
 
 right2=0;  
 for i=1:9000
    if(test1(i)==default(i))
        right2=right2+1;
    end
 end
 right2=right2/9000; %准确率
 
 disp("查全率:");
 disp(right3);
 disp("查准率");
 disp(right4);
 disp("准确率");
 disp(right2);
 
 figure("Name","d")
semilogx(d(1:k));           %随着迭代次数d的下降曲线
figure("Name","t")
semilogx(t(1:k));          %随着迭代次数均方误差的下降曲线
 
function e=f(data,default,b)     %对数似然
    y=default;
    x=data(:,1:5);
    e=sum((-y.*(x*b))+log(1+exp(x*b)));
end

function p1=p(data,b)
    p1=exp(data*b)./(1+exp(data*b));
end


function te=f_(data,default,b)   %梯度
    y=default;
    x=data(:,1:5);   
    sum1=x.*(y-p(x,b));
    sum1=sum(sum1,1);
    te=-sum1';
end

