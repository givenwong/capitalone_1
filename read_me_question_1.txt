The predictions: I saved 3 arrays of predictions, each of size 1000, into the 'prediction.csv' for ols (linear regression model), random forest of regression trees and neural network. If you ask me to pick one, I will take the result of random forest. Why the random forest is superior? It is good for datasets with lots of missing values and each regression tree can be trained on a separate node with the MapReduce model. The weakness of random forest is it breaks with outliers and concept drift but the code challenge problem mentions it is generated from the same data generating process and I plot the histograms of the targets and features, they seem well behaved.

Yes! Please take the result of the random forest and use the other two results as your reference when you find something strange going on.   




The code instructions: If you want to replicate my results, you need to do these in order:
1. Run the 'code_sql' script with your mySQL database. Of course you have to change the paths in the script to your values. This is for the pre processing of the data like handling missing values, converting nominal features to binary features.
2. Run 'nn.m' with your matlab and its neural network toolbox. The prediction on the test data set is 'predict_nn'
3. Run 'forest.m' with your matlab and its ensemble learning toolbox. The prediction on the test data set is 'predict_forest'. This may take 10 to 30 minutes depending on your hardware configuration. 
4. Run 'ols.m' with your matlab. The prediction on the test data set is 'predict_ols'. 
5. You may see different predictions if you run it yourself. Don't panic: we are just using different random seed. Neural network and random forest both depend on some random number generators.

I suggest you take the prediction by random forest. On this data set, random forest is better than linear regression which is better than neural network in terms of the mean square errors.

Warning: DO NOT try to merge the 3 matlab scripts into a big one and run. This is because the names of the functions and variables conflict. Matlab, like Python or other scripting languages, can't be built with a dependency file, which is different from languages like C, JAVA. It is also to prevent loading too much stuff into the memory in one time. 

If you want to save the time and look into the raw matlab outputs. Yes. I save the workspaces for each of the 3 algorithms into 'forest_result.mat', 'ols_result.mat' and 'nn_result.mat'. It is impossible to send them to you by email as they are large (50Mbs each) so I put them in my GitHub account. I upload everything, including the codes, images and the worksapces... into my GitHub account. This is the link:

https://github.com/givenwong/capitalone-project

For viewing the mat file, you need to open that with your matalb because it is binary rather than ASCII file.
