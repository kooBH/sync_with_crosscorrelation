close all;

path_criteria = 'clap.wav';
path_relative_1 = 'clap_forward_345.wav';
path_relative_2 = 'clap_backward_456.wav';

data_criteria = audioread(path_criteria);
data_relative_1 = audioread(path_relative_1);
data_relative_2 = audioread(path_relative_2);

[r_1,lags_1] = xcorr(data_criteria(:,1),data_relative_1(:,1));   
[r_2,lags_2] = xcorr(data_criteria(:,1),data_relative_2(:,1));   


[max_val,max_idx] = max(abs(r_1));
delay_1 = lags_1(max_idx);
[max_val,max_idx] = max(abs(r_2));
delay_2 = lags_2(max_idx);

disp(delay_1)
if delay_1 > 0
    data_sync_1 = data_criteria(delay_1+1 : end,1);
else
    pad = zeros(delay_1,1);
    data_sync_1 = [pad,data_criteria];
end

disp(delay_2)
if delay_2 > 0
    data_sync_2 = data_criteria(delay_2+1:end,1);
else
    pad = zeros(abs(delay_2),1);
    data_sync_2 = cat(1,pad,data_criteria);
end

audiowrite('output_1.wav',data_sync_1,16000);
audiowrite('output_2.wav',data_sync_2,16000);
%% 
%{
[acor,lag] = xcorr(x(:,1),u(:,1));
[~,I] = max(abs(acor));
lagDiff = lag(I)

if lagDiff < 0        
    u = u(-lagDiff+1:end,:);
    x = x(1:length(u(:,1)));
end
%}