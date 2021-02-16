function [Data,filename] = ui_read_data(pattern)

% User interface to browse for a measurement file and read the data

[filename,path] = uigetfile(pattern);
file = fopen([path '/' filename]);

% keyboard;

% while(isempty(Data{1}))
    fgetl(file);
%      Data = textscan(file,'%d %f %f %f %f %f %f');
%     Data=csvread(filename);

 Data= readtable(filename);
 
%  keyboard;
%     keyboard;
% end
fclose(file);
