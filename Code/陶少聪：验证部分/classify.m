function classify(data,default,w) %data的格式类似于模型中的x，有5个值，最后两位为是否为学生；default为是否为正例，和模型中相同；w中包括b
[row,~] = size(data);   %数据个数
zheng = length(find(default)); %数据中的正例个数
 p = exp(data(:,:)*w)./(1+exp(data(:,:)*w));
 p = p./(1-p);  %几率值
 for i=1:row
    if(p(i)>0.7)
        p(i) = 1;
    else
        p(i) = 0;
    end
 end
num_po = length(find(p));  %预测的正例
right=0;  %记录找到了多少个真正例
%ex1、2、3、4分别记录真正例、假正例、真反例、假反例个数
ex1 = 0;
ex2 = 0;
ex3 = 0;
ex4 = 0;
t_p = zeros(row,5);%真正例
f_p = zeros(row,5);%假正例
t_n = zeros(row,5);%真反例
f_n = zeros(row,5);%假反例
 for i=1:row
    if(p(i) == default(i) && p(i) == 1)
        right = right+1;
        ex1 = ex1+1;
        t_p(ex1,:) = data(i,:);
    end
     if(p(i) ~= default(i) && p(i) == 1)
        ex2 = ex2+1;
        f_p(ex2,:) = data(i,:);
     end
     if(p(i) == default(i) && p(i) == 0)
        ex3 = ex3+1;
        t_n(ex3,:) = data(i,:);
     end
     if(p(i) ~= default(i) && p(i) == 0)
        ex4 = ex4+1;
        f_n(ex4,:) = data(i,:);
     end
 end
 %前面给每一个分配的大小都为row是为了保证这些数组都不超出下标范围，下面的操作是为了去除没有用到的空间，不然画图时在（0，0，0）这个点会有很多重复的点
t_p = t_p(1:ex1,:);
f_p = f_p(1:ex2,:);
t_n = t_n(1:ex3,:);
f_n = f_n(1:ex4,:);
disp(t_n)
recall = right/zheng;  %查全率
precision = right/num_po; %查准率
right2 = 0;  
 for i = 1:row
    if(p(i) == default(i))
        right2 = right2+1;
    end
 end
right2 = right2/row; %准确率
fprintf('查全率：%f    查准率：%f    准确率：%f\n',recall,precision,right2)
figure
scatter3(t_p(:,1),t_p(:,2),t_p(:,3))
hold on
scatter3(f_p(:,1),f_p(:,2),f_p(:,3))
hold on
scatter3(t_n(:,1),t_n(:,2),t_n(:,3))
hold on
scatter3(f_n(:,1),f_n(:,2),f_n(:,3))
legend('真正例','假正例','真反例','假反例')
xlabel('balance')
ylabel('income')
zlabel('student')
zlim([-0.5 1.5]) %如果z轴坐标为0到1，则放大后因为坐标轴缩放而看不见图像
end