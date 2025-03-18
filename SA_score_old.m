function score=SA_score_old(pd,wresd,Build_Data,Individuals_data,HH_data,FFF1,u)
% same calculation as in HH_living_data
hh_id=HH_data(FFF1,2); % moving HH ID
ind=Individuals_data(Individuals_data(:,3)==hh_id,:); % agents in HH 
num_worker=sum(ind(:,12)==2); % 
HH_house_xy=Build_Data(Build_Data(:,1)==HH_data(FFF1,10),5:6);
build_id=HH_data(FFF1,10);
maxD=max(pdist2(HH_house_xy,Build_Data(Build_Data(:,4)==u,[5:6])));

a=find(ind(:,12)==2);
D_work=0;
for i=1:num_worker
    work_b=ind(a(i),14);
    dis=pdist2(Build_Data(Build_Data(:,1)==work_b,[5:6]),HH_house_xy);
    if size(dis,1)>0
    D_work(i)=max(dis);
    end
end

% same calculation as in pref_hh

age_M=mean(Individuals_data(Individuals_data(:,2)==u,6));
age_std=std(Individuals_data(Individuals_data(:,2)==u,6));

income_M=mean(HH_data(HH_data(:,1)==u,6));
income_std=std(HH_data(HH_data(:,1)==u,6));

% z score

income=(HH_data(FFF1,7)-income_M)/income_std;
income=pdf(pd,income)/pdf(pd,0);
age=(mean(ind(:,6))-age_M)/age_std;
age=pdf(pd,age)/pdf(pd,0);

Y=(income+age)/2;
A=num_worker>0;
D_work=nanmean(D_work);
D_work(isnan(D_work))=0;
B=wresd*D_work/maxD;
C=1-(A*wresd);

score=A*B+C*Y;