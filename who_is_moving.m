function moving_HH=who_is_moving(HH_data,random_number,unique_stat,intra_SA,K)
    SH=size(HH_data,1);
    R=datasample(random_number,SH); % random number ; 4 times the size of HH
    MM=zeros(SH,1); % zero vector size as HH matrix
    for u=1:length(unique_stat) 
      intra_SA_data = intra_SA(intra_SA(:,1)==unique_stat(u),K); % K={2,3,4} - 'intraSAProb'; matching SA ID
      
      if size(intra_SA_data,1) > 1
          intra_SA_data = nanmean(intra_SA_data); % avarage probability 
      end    
      M=HH_data(:,1)==unique_stat(u) & R<intra_SA_data; % all SA with probabilty higher the threshold
      MM=MM+M; % Append
    end
    moving_HH=HH_data(MM>0,2); % store all random HH ID ready for moving