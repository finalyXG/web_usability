function [ param ] = get_params( four_edges_analysis )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    param = [];
    for i = 1 : 4
        param{i} = get_dirichlet_a(four_edges_analysis,i);
    end

end

