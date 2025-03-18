function [Individuals_data] = infected_exposure(Individuals_data,Build_Data,HH_data,infected_blds,susceptible_blds,day,norm_factor) 
% copy matrix and set all zeros to nan
A= infected_blds;      A(A==0) = NaN;  A= A(~isnan(A(:,2)), :);
B= susceptible_blds;   B(B==0) = NaN;  B= B(~isnan(B(:,2)), :);

for i = 1:size(A,1) % loop over the infected agents
    % find the rows of infected buildings that shared with susceptible buildings
    ind = any(ismember(B(:,2:end),A(i,2:end) ), 2); 
    if any(ind) 
        pot_infected = sortrows(B(ind,[1,2]),1);
        curr_infected = A(i,[1,2]);
        a_infected = ismember(Individuals_data(:,1),pot_infected(:,1));
        
        % agent id; hh id; status; infection p; age; home bld id
        a_infected2 = [sortrows(Individuals_data(a_infected,[1,3,23,24,34]),1),...
                        pot_infected(:,2)];
        [~, ind_hh] = ismember(a_infected2(:,2), HH_data(:,2));
        a_infected2(:,7) = HH_data(ind_hh,6);
        [~, ind_xy] = ismember(a_infected2(:,6), Build_Data(:,1));
        a_infected2(:,8) = Build_Data(ind_xy,5);
        a_infected2(:,9) = Build_Data(ind_xy,6);
        
        % agent id; hh id; status; infection dur; age; home bld id
        a_curr = ismember(Individuals_data(:,1),curr_infected);
        a_curr2 = [sortrows(Individuals_data(a_curr,[1,3,23,28,34]),1),...
                    curr_infected(:,2)];        
        [~, ind_hh] = ismember(a_curr2(:,2), HH_data(:,2));
        a_curr2(:,7) = HH_data(ind_hh,6);
        [~, ind_xy] = ismember(a_curr2(:,6), Build_Data(:,1));
        a_curr2(:,8) = Build_Data(ind_xy,5);
        a_curr2(:,9) = Build_Data(ind_xy,6);
        
        % age diff, income diff, distance
        diff = abs([a_infected2(:,[5,7])-a_curr2(1,[5,7]),...
                pdist2(a_infected2(:,8:9),a_curr2(1,8:9))]);
        % utility = 1- ((age/100 + income/max + dis/max) /3)
        w_func =1-( (diff(:,1)/max(diff(:,1)) + diff(:,2)/max(diff(:,2)) + diff(:,3)/max(diff(:,3)))/3 );
        gamma = gampdf(a_curr2(4), (4.5/3.5)^2, (3.5^2)/4.5);
        % probability = utility * infection robability * gamma pdf * factor
        infec_prob = w_func.*a_infected2(:,4)*gamma*norm_factor;
        
        % identify and update new infected
        rand_cont = rand(size(infec_prob));                                             
        infections = infec_prob > rand_cont;
        
        % new infected update
        a_infected3 = a_infected2(a_infected2(infections,3)<2,1); % infected & status<2
        new_infected = ismember(Individuals_data(:,1),a_infected3);
        Individuals_data(new_infected,23)=2; % 2 - Infected, Undiagnosed
        Individuals_data(new_infected,27)=day; 
        Individuals_data(new_infected,33)=curr_infected(1); % infected by
        
        % new quarantined infected update
        a_quarantined = a_infected2(a_infected2(infections,3)==3,1); % infected & status=3
        new_quarantined_infected = ismember(Individuals_data(:,1),a_quarantined);
        Individuals_data(new_quarantined_infected,23)=4; % 4 - Quarantined, Infected, Undiagnosed
        Individuals_data(new_quarantined_infected,27)=day; 
        Individuals_data(new_quarantined_infected,33)=curr_infected(1); % infected by

        del_duplicate = ismember(B(:,1),a_infected3);
        B(del_duplicate,:)=[];
    end
end