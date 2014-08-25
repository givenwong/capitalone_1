clear;
% change the URI if you want to replicate the code.
data= importdata('C:\Users\econometrican\Desktop\captial one code challenge\train.txt');
data = [data(:,1)/27, data(:,2:263)];

% split the data set into the 1st part for training, cross validation and
% the 2nd part for performance measurement.
data_train = data(1:4000,:);
data_validate = data(4001:5000,:);
data_train_trans = data_train.';
data_validate_trans = data_validate.';

% find and delete the rank deficiency column
for i = 2:263  
    r = rank([data_train_trans(1:i-1,:)
              data_train_trans(i+1:263,:)]);
    if(r == 262)
     result = i;
     break;
    end
end

target_train = data_train_trans(1,:);
features_train =  [data_train_trans(2:260,:) 
                   data_train_trans(262:263,:)];

target_validate = data_validate_trans(1,:);
features_validate = [data_validate_trans(2:260,:) 
                   data_validate_trans(262:263,:)];
 
% train the neural network with 2 hidden layers with 10 neurons each
% transfer fuction is 'tansig'
net = fitnet([10,10]);
net.layers{3}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{1}.transferFcn = 'tansig';
net = train(net,features_train,target_train);

% on my performance measurement data set
predict_nn_validate = net(features_validate);
grid = [1:100];
plot(grid,predict_nn_validate(1:100),grid,target_validate(1:100));
mse_nn = 27*27*mse(predict_nn_validate,target_validate);
scatter(predict_nn_validate,target_validate);
plotregression(predict_nn_validate,target_validate);

% make the predictions on your test data set (originally 'codetest_test.txt')
test= importdata('C:\Users\econometrican\Desktop\captial one code challenge\test.txt');
test = test';
features_test= [test(1:259,:) 
                test(261:262,:)];

predict_nn = net(features_test);
predict_nn = predict_nn';
predict_nn = predict_nn*27;






