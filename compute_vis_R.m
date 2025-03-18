function R = compute_vis_R(Individuals_data,day,recover,diagnosis)

% FOR NOW:
% 13 - contagious status ; 16 - contagious day ; 17 - sick day
new_known_infections = length(Individuals_data((Individuals_data(:,13)>=4) &...
                        (Individuals_data(:,17)==diagnosis)));
sum_I=0;

for i = diagnosis+1:recover
    sum_I = sum_I + sum(...
            (Individuals_data(:, 13)>=4) &...
            ((day - Individuals_data(:,16))==i) ) *...
            gampdf(i, (4.5/3.5)^2, (3.5^2)/4.5);          
end

if sum_I > 0
    R = new_known_infections/sum_I;
else
    R = 0;
end