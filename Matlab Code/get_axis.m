function [ a, b, c ] = get_axis( m, n )
% Summary of this function goes here
%   Use Monte Carlo method creating ellipsoids' volume,
%   which has a log-normal distribution.
%   Then return to the axis value of ellipsoids.
%   R = lognrnd(mu,sigma) returns an array of random numbers 
%   generated from the lognormal distribution with parameters mu and sigma. 
%   mu and sigma are the mean and standard deviation, respectively, 
%   of the associated normal distribution.
% Detailed explanation goes here
%   a,b,c       the axis of ellipsoids(a<b<c)
%   m,n         a/b, c/b

global MAX_VOLUME;

sigma=1;
mu=1/2;

 v = lognrnd(mu,sigma);
 while (v > MAX_VOLUME)
     v = lognrnd(mu,sigma);
 end
     volume = v;
     
    b = ((3*volume)/(4*pi*m*n))^(1/3);
    a = m * b;
    c = n * b;
end

