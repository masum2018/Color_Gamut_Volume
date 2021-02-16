function output = camcat_cc(XYZ1, XYZn, XYZa)

% Function to transform colour coordinates to a reference viewing
% condition using the Bradford chromatic adaptation method. 
%
% input:  XYZ1, Measured tristimulus values
%         XYZn, Measured tristimulus value of the display white
%         XYZa, Tristimulus value of reference white
%
% output: XYZ measured tristimulus values relative to reference white
%        

M = [ 0.8951,  0.2664, -0.1614;...
     -0.7502,  1.7135,  0.0367;...
      0.0389, -0.0685,  1.0296]';

% transform into Bradford cone space

RGBn = XYZn*M;
RGBa = XYZa*M;

% calculate corresponding colours

A = diag(RGBa./RGBn);
MAM = M*A/M;

% correct the XYZ tristimulus values

output = XYZ1*MAM;
