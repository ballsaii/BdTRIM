function [ output ] = p2gamma( p )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% p in eV/c
output = sqrt((p/0.511E6).^2+1);

end

