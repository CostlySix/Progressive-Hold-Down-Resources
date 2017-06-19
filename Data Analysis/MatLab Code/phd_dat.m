function [PHD_Dat] = phd_dat( Var )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n = length(Var);

% Number of Reinforcers%
for i = 1:n
Reinforcers(1,i) = length(find(Var{1,i}(:,2) == 25));
end;

%Number of Presses made%
for i = 1:n
    Hold(1,i) =  length(find(Var{1,i}(:,2) == 1015)); 
    Hold(2,i) = length(find(Var{1,i}(:,2) == 1016));
end;


% ------- New Lever ID generator-------%

%Find rows of end trials
for i = 1:n
    EndTrial_rows{1,i} = find(Var{1,i}(:,2)==112);
end


for i = 1:n
   if isempty(EndTrial_rows{1,i})
       EndTrial_rows{1,i} = length(Var{1,i}(:,1));
   else
       EndTrial_rows{1,i} = EndTrial_rows{1,i};
   end
end 

    
%Find first time trial ends
for i = 1:n
        Row_First_EndTrial(1,i) = EndTrial_rows{1,i}(1,1);
end

% Easier name to use%
RFET = Row_First_EndTrial;

%New Lever ID generator%
for i = 1:n
    if Var{1,i}(RFET(1,i)-1,2) == 1017
        Lev_ID(1,i)=1;
    else
        Lev_ID(1,i)=2;
    end
end
% -----------------------------------------%

for i = 1:n
    if Lev_ID(1,i) == 1
        Presses(1,i) = [Hold(1,i)];
    else
        Presses(1,i) = [Hold(2,i)];
    end
end


%Session Duration%
for i = 1:n;
    start(1,i) = find(Var{1,i}(:,2) == 113);
    stop(1,i) = find(Var{1,i}(:,2) == 114);
    SessionDur(1,i) = (Var{1,i}(stop(1,i),1) - Var{1,i}(start(1,i),1))/60;
end;

%Total Number of Head Pokes%

for i = 1:n
    HeadPokes(1,i) = length(find(Var{1,i}(:,2)==1011));
end


%Efficiency%

for i = 1:n
    Rein_rows{1,i} = find(Var{1,i}(:,2)==25);
end

for i = 1:n
   if isempty(Rein_rows{1,i})
       Row_last_rein(1,i) = 1;
   else
       Row_last_rein(1,i) = Rein_rows{1,i}(end,1);
   end
end

RLR = Row_last_rein;
    %Number Presses to Max%
    
%Number of Presses made%
for i = 1:n
    NTM_Hold(1,i) = length(find(Var{1,i}(1:RLR(1,i),2) == 1015)); 
    NTM_Hold(2,i) = length(find(Var{1,i}(1:RLR(1,i),2) == 1016));
end;


for i = 1:n
    if Lev_ID(1,i) == 1
        NTM_Presses(1,i) = [NTM_Hold(1,i)];
    else
        NTM_Presses(1,i) = [NTM_Hold(2,i)];
    end
end    


% --------- calculating  Efficiency%

for i = 1:n
    Efficiency(1,i) = Reinforcers(1,i)./NTM_Presses(1,i);
end


PHD_Dat = struct('Reinforcers',[],'Presses',[],'HeadPokes',[],'SessionDur',[],...
    'Number_to_Max',[],'Efficiency',[]);
PHD_Dat.Reinforcers = Reinforcers;
PHD_Dat.Presses = Presses;
PHD_Dat.HeadPokes = HeadPokes;
PHD_Dat.SessionDur = SessionDur;
PHD_Dat.Number_to_Max = NTM_Presses;
PHD_Dat.Efficiency = Efficiency;
end

