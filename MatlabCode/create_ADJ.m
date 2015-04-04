function Adj = create_ADJ(data_markers,marker_conns)

Adj=zeros(size(marker_conns,1),size(marker_conns,1));
for i=1:size(marker_conns,1)
    for j=1:size(marker_conns,1)
        if strcmp(marker_conns(i,1),data_markers(j))
            indr=j;
            break;
        end
    end
    for j=1:size(marker_conns,1)
        if strcmp(marker_conns(i,2),data_markers(j))
            indc=j;
            break;
        end
    end
    [indr indc]
    Adj(indr,indc)=1;
end