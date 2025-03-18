function [Individuals_data,Individuals_data_P] = ind_epidemic(Individuals_data,Individuals_data_P,init_infected) 

% Initial epidemic status, day and probability by age calculation
infection_prob= [0, 18, 0.0742, 0.02;...
                18, 65, 0.0742*2, 0.04;...
                65, 85, 0.0742, 0.02;...
                85, 300, 0.0742*2, 0.04];
admission_prob= [0, 30, 0.073/6, 0.02;...
                30, 50, 0.073/3, 0.02;...
                50, 60, 0.073/1.5, 0.02;...
                60, 70, 0.073, 0.02;...
                70, 80, 0.073*1.5, 0.02;...
                80, 300, 0.073*2.5, 0.02];
mortality_prob= [0, 40, 0.00002, 0;...
                40, 50, 0.002602, 0.001;...
                50, 60, 0.008822, 0.005;...
                60, 70, 0.026025, 0.015;...
                70, 80, 0.06402, 0.03;...
                80, 300, 0.174104, 0.1];

% set agent age, random by age group
kid = Individuals_data(:,6)==1;
mid = Individuals_data(:,6)==2;
old = Individuals_data(:,6)==3;
exact_age = zeros(length(Individuals_data),1);
exact_age(kid) = randi([01,18],sum(kid),1);
exact_age(mid) = randi([19,65],sum(mid),1);
exact_age(old) = randi([66,100],sum(old),1);

% initial infected agents epidemiological status
Individuals_data(:,23)=0; % epidemiological status
Individuals_data(randperm(length(Individuals_data),init_infected),23)=2;
Individuals_data_P=[Individuals_data_P,'epidemiological status'];

% add infection prob by age per agent
for i= 1:length(infection_prob)
    age_group = ((exact_age >= infection_prob(i,1)) & (exact_age <= infection_prob(i,2)));
    Individuals_data(age_group,24) = normrnd(infection_prob(i,3),infection_prob(i,4),[sum(age_group),1]);
end
Individuals_data((Individuals_data(:,24)<0),24) = 0;
Individuals_data_P=[Individuals_data_P,'infection probability'];

% add addmmision prob by age per agent
for i= 1:length(infection_prob)
    age_group = ((exact_age >= admission_prob(i,1)) & (exact_age <= admission_prob(i,2)));
    Individuals_data(age_group,25) = normrnd(admission_prob(i,3),admission_prob(i,4),[sum(age_group),1]);
end
Individuals_data((Individuals_data(:,25)<0),25) = 0;
Individuals_data_P=[Individuals_data_P,'hospitalization probability'];

% add mortality prob by age per agent
for i= 1:length(mortality_prob)
    age_group = ((exact_age >= mortality_prob(i,1)) & (exact_age <= mortality_prob(i,2)));
    Individuals_data(age_group,26) = normrnd(mortality_prob(i,3),mortality_prob(i,4),[sum(age_group),1]);
end
Individuals_data((Individuals_data(:,26)<0),26) = 0;
Individuals_data_P=[Individuals_data_P,'mortaility probability'];

% initial status duration and days
Individuals_data(:,27:33)=nan; % infection day
status_head = [ "infection day","infection duration",...
                "quarantine day","quarantine duration",...
                "hospitalization day","hospitalization duration",...
                "infected by"];
Individuals_data_P=[Individuals_data_P,status_head];

Individuals_data(:,34) = exact_age;
Individuals_data_P=[Individuals_data_P,'exact age'];

% set day 0 for infected agents
Individuals_data(Individuals_data(:,23)==2,27)=0;