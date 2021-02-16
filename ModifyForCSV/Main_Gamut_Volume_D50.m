% load, validate and pre-process the data

[CIELAB, TRI, RGB, filename] = load_and_prepare_data('iec_data/*.csv');

% get the map of the volume in cylindrical coordinates and sum it

V_map=Gamut_Volume_cyl_map(TRI,CIELAB,100,360);
V_total=sum(V_map(:));

% plot the gamut

figure;
trisurf(TRI, CIELAB(:,2),CIELAB(:,3),CIELAB(:,1),...
    'FaceVertexCData',RGB/max(RGB(:)),'FaceColor','interp');
view([30 30]);
xlabel('CIE a^*','FontSize',14);
ylabel('CIE b^*','FontSize',14);
zlabel('CIE L^*','FontSize',14);
t=sprintf('CIELab gamut volume = %g from file "%s"\n', V_total,filename);
title(t,'Interpreter', 'none');
fprintf('%s\n',t);
axis equal;
