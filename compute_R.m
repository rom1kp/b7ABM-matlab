function R = compute_R(Individuals_data,day,recover)
%Compute R values
new_infections = length(Individuals_data((Individuals_data(:,23)~=1)...
                    & (Individuals_data(:,23)~=3) & (Individuals_data(:,27)==day) ));
sum_I = 0;
% sum infected and compute with contagious risk gamma pdf
for i = 1:recover
    sum_I = sum_I + sum(...
            (Individuals_data(:,23)~=1) &...
            (Individuals_data(:,23)~=3) &...
            ((day - Individuals_data(:,27))==i) ) *...
            gampdf(i, (4.5/3.5)^2, (3.5^2)/4.5);
end

if sum_I > 0
    R = new_infections/sum_I;
else
    R = 0;
end