function [Assets,HH_data,Build_Data,LU,new_A,new_B,HH_change]=new_house(possible_assets,Assets,HH_data,Build_Data,FFF1)
LU=[];
new_A=[];
new_B=[];
HH_change=[];
if size(possible_assets,1)>1 
    selected_A=datasample(possible_assets,1);
else
    selected_A=(possible_assets);
end
if selected_A(3)>1 
    Assets(Assets(:,3)==selected_A(3),11)=1; % mark asses as occupied
    Assets(Assets(:,3)==HH_data(FFF1,11),11)=0; % mark old assets empty
    new_A(:,4)=HH_data(FFF1,1);
    HH_data(FFF1,11)=selected_A(3); % change HH data to new assets
    HH_data(FFF1,10)=selected_A(2); % change HH data to new building
    new_A(:,1)=selected_A(3);
    new_A(:,2)=1;
    new_A(:,3)=selected_A(1);
    new_B=selected_A(2);
    HH_change=HH_data(FFF1,2);
    if Build_Data(Build_Data(:,3)==selected_A(2),3)==0
        Build_Data(Build_Data(:,3)==selected_A(2),3)=1; % change building land use
        LU=selected_A(2); % changed land use    
    end
end