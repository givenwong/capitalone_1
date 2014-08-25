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
               
% train the random forest of regression trees 
bag = fitensemble(features_train',target_train','Bag',300,'Tree','type','regression');
predict_forest_validate = bag.predict(features_validate');
mse_forest = 27*27*mse(predict_forest_validate,target_validate);
plotregression(predict_forest_validate,target_validate);

% make the predictions on your test data set (originally 'codetest_test.txt')
test= importdata('C:\Users\econometrican\Desktop\captial one code challenge\test.txt');
test = test';
features_test= [test(1:259,:) 
                test(261:262,:)];

predict_forest = bag.predict(features_test');
predict_forest = predict_forest*27;






