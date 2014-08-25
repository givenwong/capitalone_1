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

% train the linear regression model               
lm = LinearModel.fit(features_train',target_train','linear');
predict_ols_validate = predict(lm,features_validate');
predict_ols_validate = predict_ols_validate';
mse_ols = 27*27*mse(predict_ols_validate,target_validate);
plotregression(predict_ols_validate,target_validate)


% make the predictions on your test data set (originally 'codetest_test.txt')
test= importdata('C:\Users\econometrican\Desktop\captial one code challenge\test.txt');
test = test';
features_test= [test(1:259,:) 
                test(261:262,:)];

predict_ols = predict(lm,features_test');
predict_ols = predict_ols';
predict_ols = predict_ols*27;






