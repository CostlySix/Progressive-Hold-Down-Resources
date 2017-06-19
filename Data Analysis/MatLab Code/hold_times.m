function [ HOLD_Times ] = hold_times(Var)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% ------- New Lever ID generator-------%
n = length(Var);
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
        Lev_ID(1,i) = 1;
    elseif Var{1,i}(RFET(1,i)-1,2) == 1015;
        Lev_ID(1,i) = 1;
    else
        Lev_ID(1,i) = 2;
    end
end


%Getting Row numbers of all Press - Down's and Up's%

Left_Press_down = cell(1,n);
Left_Press_up = cell(1,n); 
Right_Press_down = cell(1,n);
Right_Press_up = cell(1,n);


for i = 1:n
    Left_Press_down{1,i} = find(Var{1,i}(:,2) == 1015);
    Left_Press_up{1,i} = find(Var{1,i}(:,2) == 1017);
    Right_Press_down{1,i} = find(Var{1,i}(:,2) == 1016); 
    Right_Press_up{1,i} = find(Var{1,i}(:,2) == 1018);
end


%Determining the durations of holds%

Left_hold_dur = cell(1,n);
Right_hold_dur = cell(1,n);

for i = 1:n
    Left_hold_dur{1,i} = Var{1,i}(Left_Press_up{1,i},1)...
        - Var{1,i}(Left_Press_down{1,i},1);
    Right_hold_dur{1,i} = Var{1,i}(Right_Press_up{1,i},1)...
        - Var{1,i}(Right_Press_down{1,i},1);
end

%Hot Hold Down Times%

for i = 1:n
    if Lev_ID(1,i) == 1
        Hot_HoldTimes{1,i} = [Left_hold_dur{1,i}];
    else
        Hot_HoldTimes{1,i} = [Right_hold_dur{1,i}];
    end
end


%Hot Press Times%

for i = 1:n
    if Lev_ID(1,i) == 1
        Hot_PressTimes{1,i} = [Left_Press_down{1,i}];
    else
        Hot_PressTimes{1,i} = [Right_Press_down{1,i}];
    end
end


%Average Hold Duration%
Avg_Hold_Dur = [];

for i = 1:n
    Avg_Hold_Dur(1,i) = mean(Hot_HoldTimes{1,i});
end


%Estimating expoential distribution mean of Hold TImes%

for i = 1:n
   exp_mean(1,i) = expfit(Hot_HoldTimes{1,i}); 
end


% Generating the Data Structure%
HOLD_Times = struct('Hot_HoldTimes',{{}},'Hot_PressTimes',{{}});
HOLD_Times.Hot_HoldTimes = Hot_HoldTimes;
HOLD_Times.Hot_PressTimes = Hot_PressTimes;
end

