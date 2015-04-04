function plot_triangle(xy,ind)

xy=xy';
X = [ xy(ind.i,1) xy(ind.j,1) repmat(NaN,size(ind.i))]';
Y = [ xy(ind.i,2) xy(ind.j,2) repmat(NaN,size(ind.i))]';
Z = [ xy(ind.i,3) xy(ind.j,3) repmat(NaN,size(ind.i))]';
X = X(:);
Y = Y(:);
Z = Z(:);
axis equal
% set(the_stick,'XData',X,'YData',Z,'ZData',Y);
line(X,Z,Y,'marker','.','markers',20);
xlabel('X')
ylabel('Z')
zlabel('Y')