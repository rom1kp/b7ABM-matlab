function building_average_sa=cal_bui_sa(Work_places,Build_Data,subsidy_trigger)
u=unique(Work_places(:,1)); % col 1 'building id'
h=Build_Data(ismember(Build_Data(:,1),u),3); % col 3 'Usage' for all unique buildings
u2=u(h==3); % landuse value 3: commercial 
for i=1:length(u2) 	
	% Get the salary values for the current building
	building_salaries = Work_places(Work_places(:,1) == u2(i), 8); % col 8 'salary'
	if subsidy_trigger==1
		building_salaries = sort(building_salaries, 'descend'); % Sort salaries in descending order
		building_salaries = building_salaries(3:end); % Remove the 2 lowest salaries
	end	
	% Calculate the total salary for each workplace (after removing 2 lowest if applicable)
	building_average_sa(i,:) = [u2(i), sum(building_salaries)];

end