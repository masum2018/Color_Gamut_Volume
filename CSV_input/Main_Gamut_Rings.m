[CIELAB, TRI, RGB, filename] = load_and_prepare_data('iec_data/*.csv');

%get the map of the volume in cylintrical coordinates
[V_map,L,Hue]=Gamut_Volume_cyl_map(TRI,CIELAB,100,360);
%Get the accumulated volume sum (the final row will be the total)
%and calculate the radius required to represent that volume
rings=(2*cumsum(V_map)/(Hue(2)-Hue(1))).^0.5;
%Plot against the mid-point of the angle ranges
midH=(Hue(1:end-1)+Hue(2:end))/2;
x=repmat(sin(midH'),length(L)-1,1).*rings;
y=repmat(cos(midH'),length(L)-1,1).*rings;
%plot the figure
figure;
plot(x(10:10:end,[1:end 1])',y(10:10:end,[1:end 1])','k');
hold on
%add labels for L* 10, 50 and 100
for n=[10 50 100]
    text(x(n,1),y(n,1),sprintf('L*=%d',n));
end
%add a central marker
plot(0,0,'+','MarkerSize',20);
%and lines for the RGB primaries
maxRad=max(rings(:));
RGB=RGB/max(RGB(:));
for prim={1,0,0,'r';0,1,0,'g';0,0,1,'b'}'
    IX=RGB(:,1)==prim{1} & RGB(:,2)==prim{2} & RGB(:,3)==prim{3};
    ab=CIELAB(IX,2:3);
    ab=1.1*ab*maxRad/hypot(ab(1),ab(2));
    plot([0,ab(1)],[0,ab(2)],prim{4});
end
%make the axes equal
axis equal
xlabel('a^*RSS','FontSize',12);
ylabel('b^*RSS','FontSize',12);
%add the title
t=sprintf('CIELab gamut rings\n from file "%s"\nVolume = %g',filename,sum(V_map(:)));
title(t,'Interpreter', 'none');
