function lockdown = building_lockdown (Build_Data, sc, vR, prevVR)

lockdown = ones(length(Build_Data),1);
if sum(contains(sc,'GRADUAL'))
    if 1<vR && 2<vR % if visible R is between 1 & 2
        if prevVR<=1 || prevVR>=2
            if sum(contains(sc,'ALL'))
                non_residential = Build_Data(:,3)>=3; % building usage
                bb = Build_Data(non_residential,:);
                [~,locB] = ismember(bb(:,1),Build_Data(:,1));
                rand_non_res = randsample(locB,fix(length(locB)/2)); % half of the buildings ; round down
                lockdown(rand_non_res) = 0; % set lockdown
            end
        else
            lockdown = Build_Data(:, 24); % full lockdown ; no change
        end
    elseif vR>=2 % visible R is greater than 2
        if sum(contains(sc,'ALL'))
            non_residential = Build_Data(:,3)>=3; % all commerical
            lockdown(non_residential) = 0; % close all commercial and public buildings
        end   
    end
else 
    if 1<vR % R is greater than 1
        if sum(contains(sc,'ALL'))
            non_residential = Build_Data(:,3)>=3; % all commerical
            lockdown(non_residential) = 0; % close all commercial and public buildings
        end   
    end
end