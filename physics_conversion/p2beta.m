function [ beta ] = p2beta( p )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% p unit in eV/c
m0 = 0.511E6;
beta = p./(sqrt(p.^2+m0^2));

end

