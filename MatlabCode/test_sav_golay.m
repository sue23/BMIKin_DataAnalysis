function cutoff=test_sav_golay(frame,polord,derorder,fc)
debug = 0;

x = rand(100000,1);
[px,wx]=spectrum(x,[],[],[],50);


y = sav_golay(x,frame,polord,derorder,fc);
[p,w]=spectrum(y,[],[],[],fc);

if debug
 line(wx,px(:,1)./max(px(:,1)),'col','k');
 line(w,p(:,1)./max(p(:,1)),'col','r');
 line([0 25],[1 1]./sqrt(2));
 set(gca,'yscale','log');
end

% Find cutoff frequency
cutoff = max(w(find(p(:,1)>max(p(:,1))./sqrt(2))));
