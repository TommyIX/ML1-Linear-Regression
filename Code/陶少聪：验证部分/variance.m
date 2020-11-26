function var = variance(test_data,w)  %计算测试集方差
    test_data(:,1) = test_data(:,1)./5;        %均一化处理
    test_data(:,3) = test_data(:,3)./2;         %均一化处理
    [row,~] = size(test_data);  %测试集的个数
    x = test_data(:,1:3);
    x(:,4) = 5; %将常数b记为5
    y = x*w;    %预测值
    var = (test_data(:,4)-y)'*(test_data(:,4)-y)/row;
    fprintf('方差:%f\n',var)
end