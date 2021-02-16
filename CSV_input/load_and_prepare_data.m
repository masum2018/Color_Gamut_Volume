function [CIELAB, TRI, RGB, filename] = load_and_prepare_data(pattern)

% Function to load, process and validate the measured data

[Data,filename] = ui_read_data(pattern);

% RGB=[Data{2} Data{3} Data{4}];                  
% XYZ=[Data{5} Data{6} Data{7}];
RGB=Data{:,4:6};
XYZ=Data{:,7:9};
RGBmax = max(RGB(:));
% keyboard;
XYZn = XYZ(all(RGB==RGBmax,2),:);
keyboard;

D50=[96.42957  100.0000  82.51046]/100;

% Chromatic adaption

if ~all(XYZn==D50)
    XYZ = camcat_cc(XYZ, XYZn, D50);
end

% Get the standard tessellation relative to the supplied RGB values

[TRI_ref, RGB_ref] = make_tesselation(unique(RGB));
map = map_rows(RGB_ref,RGB);
if (~all(map>0))
    fprintf('Missing RGB data\n');
    fprintf('%g, %g, %g\n',unique(RGB_ref(map==0,:),'rows')');
    return;
end
TRI=map(TRI_ref);

% Convert to CIE 1971 L*a*b* (CIELAB) colour space

CIELAB=XYZ2Lab(XYZ,D50);
