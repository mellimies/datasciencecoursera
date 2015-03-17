function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

load('ex6data3.mat');
test_vals = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
len_vals = length(test_vals);
pred_errors = zeros(len_vals, len_vals);

for i = 1:len_vals
    C = test_vals(i);
    for j = 1:len_vals
        sigma = test_vals(j);
        model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
        predictions = svmPredict(model, Xval);
        pred_error = mean(double(predictions ~= yval));
        pred_errors(i, j) = pred_error;
    end
end

%pred_errors
%[min_val, min_index] = min(pred_errors(:))
%min_row = floor(min_index / len_vals)
%min_col = mod(min_index,len_vals)
% optimal values how to get them from matrix automatically?

C = 1;
sigma = 0.1;




% =========================================================================

end
