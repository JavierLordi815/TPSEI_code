function [ error ] = calcError( testNew, test )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [~, testNew] = max(testNew);
    [~, test] = max(test);
    error = sum(testNew ~= test, 2) / size(test, 2);
    
    %error = mean(testNew ~= test);
end

