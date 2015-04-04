function [xyzBm]=TKinectInBody(post,data,start,stop)
%Trasfoma coordinate kinect in body
% post: coordinate 4 posture nella calib
% A coordinate nel sistema kinect
% xyzB: coordinate nel sistema body

                
        %prendo configurazioni durante la calibrazione e faccio la media
        Npost = nanmean(post);
        data_markers = data + repmat(Npost,size(data,1),1);
        hipL=Npost(:,37:39);
        hipR=Npost(:,49:51);
        hipC=Npost(:,1:3);
        
        %% definisco sistemi
%         B = [hipL;hipC;hipR];
        B = [hipR;hipC;hipL];
        r = rank(B);
        Q = orth(B);%.*(-1);
%         Q=[0 0 0; 0 0 0; 0 0 0]+mean([hipR;hipC;hipL])
%         Q2 = orth([hipL;hipC;hipR]).*(-1);
%         line([0 0 0; Q2(1,:)],[0 0 0; Q2(2,:)],[0 0 0; Q2(3,:)],'col','r')
%         text(Q2(1,1),Q2(2,1),Q2(3,1),'X2')
%         text(Q2(1,2),Q2(2,2),Q2(3,2),'Y2')
%         text(Q2(1,3),Q2(2,3),Q2(3,3),'Z2')
        
        K = [1 0 0; 0 0 1;0 1 0];
%         K = [1 0 0; 0 1 0;0 0 1];

        
        centroQ=mean(Q);
        centroK =mean(K);
        dist=centroQ;%-centroK;
%         dist=abs([0 0 dist(3)]);
        [R, OB] = rigid_transform_3D(Q,K);
%         dist=R*dist';
        r=[1 0 0; 0 cos(pi) sin(pi);0 -sin(pi) cos(pi)];
%         
%         plot3(PB1(1)+OB(1),PB1(2)+OB(2),PB1(3)+OB(3),'og')
%         plot3(PB2(1)+OB(1),PB2(2)+OB(2),PB2(3)+OB(3),'og')
%         distB = sqrt(sum(((PB1)-(PB2)).^2))
        
        % applico trasformazione
% keyboard
            xyzK=[];
            xyzB = [];
            for i=1:3:size(data_markers,2)-2
                P = data_markers(:,i:i+2);%+ repmat(dist,size(data_markers(:,i:i+2),1),1);
                PB = (R*P');% - repmat(OB,1,size(P,1));
                
%                 PB = (R*data_markers(:,i:i+2)') + repmat(OB,1,size(data_markers(:,i:i+2),1));
                xyzB = cat(3,xyzB, PB');
                xyzK =cat(3,xyzK, data_markers(:,i:i+2));
            end
            xyzM=nanmean(xyzK,1);
            xyzBm=xyzK-repmat(hipC,size(xyzK,1),1,size(xyzK,3));%repmat(dist,size(xyzK,1),1,size(xyzK,3));%
            xyzB=xyzB-repmat(mean(squeeze(xyzB(1,:,[1 13 17])),2)',size(xyzB,1),1,size(xyzB,3))+repmat(centroQ,size(xyzB,1),1,size(xyzB,3));
            keyboard
            trial=1;
            hipxm = squeeze(xyzBm(start(trial):stop(trial),1,[1 13 17]));
            hipym = squeeze(xyzBm(start(trial):stop(trial),2,[1 13 17]));
            hipzm = squeeze(xyzBm(start(trial):stop(trial),3,[1 13 17]));
            trunkxm = squeeze(xyzBm(start(trial):stop(trial),1,[2]));
            trunkym = squeeze(xyzBm(start(trial):stop(trial),2,[2]));
            trunkzm = squeeze(xyzBm(start(trial):stop(trial),3,[2]));
            shxm = squeeze(xyzBm(start(trial):stop(trial),1,[3 5 9]));
            shym = squeeze(xyzBm(start(trial):stop(trial),2,[3 5 9]));
            shzm = squeeze(xyzBm(start(trial):stop(trial),3,[3 5 9]));
            
            hipx = squeeze(xyzB(start(trial):stop(trial),1,[1 13 17]));
            hipy = squeeze(xyzB(start(trial):stop(trial),2,[1 13 17]));
            hipz = squeeze(xyzB(start(trial):stop(trial),3,[1 13 17]));
%             centro = squeeze(nanmean(xyzB(1,:,[1 13 17])))'-centroQ;
%             xyzB=xyzB-repmat(centro,size(xyzB,1),1,size(xyzB,3));
            
            hipx = squeeze(xyzB(start(trial):stop(trial),1,[1 13 17]));
            hipy = squeeze(xyzB(start(trial):stop(trial),2,[1 13 17]));
            hipz = squeeze(xyzB(start(trial):stop(trial),3,[1 13 17]));
            
            trunkx = squeeze(xyzB(start(trial):stop(trial),1,[2]));
            trunky = squeeze(xyzB(start(trial):stop(trial),2,[2]));
            trunkz = squeeze(xyzB(start(trial):stop(trial),3,[2]));
            shx = squeeze(xyzB(start(trial):stop(trial),1,[3 5 9]));
            shy = squeeze(xyzB(start(trial):stop(trial),2,[3 5 9]));
            shz = squeeze(xyzB(start(trial):stop(trial),3,[3 5 9]));
            
            khipx = squeeze(xyzK(start(trial):stop(trial),1,[1 13 17]));
            khipy = squeeze(xyzK(start(trial):stop(trial),2,[1 13 17]));
            khipz = squeeze(xyzK(start(trial):stop(trial),3,[1 13 17]));
            ktrunkx = squeeze(xyzK(start(trial):stop(trial),1,[2]));
            ktrunky = squeeze(xyzK(start(trial):stop(trial),2,[2]));
            ktrunkz = squeeze(xyzK(start(trial):stop(trial),3,[2]));
            kshx = squeeze(xyzK(start(trial):stop(trial),1,[3 5 9]));
            kshy = squeeze(xyzK(start(trial):stop(trial),2,[3 5 9]));
            kshz = squeeze(xyzK(start(trial):stop(trial),3,[3 5 9]));
            h_skt=figure;
            
%             line([0 1;0 0;0 0]',[0 0;0 1;0 0]',[0 0;0 0;0 1]','col','m')
            
            line([0 0 0;K(1,:)],[0 0 0;K(2,:)],[0 0 0; K(3,:)],'col','m')
            hold on
            text(K(1,1),K(2,1),K(3,1),'Xk')
            text(K(1,2),K(2,2),K(3,2),'Yk')
            text(K(1,3),K(2,3),K(3,3),'Zk')
%             text(1,0,0,'XK')
%             text(0,1,0,'YK')
%             text(0,0,1,'ZK')
            %
            
%             line([centroKB(1) centroKB(1) centroKB(1); KB(1,:)],[centroKB(2) centroKB(2) centroKB(2); KB(2,:)],[centroKB(3) centroKB(3) centroKB(3);KB(3,:)],'col','k')
%             text(KB(1,1),KB(2,1),KB(3,1),'XkB')
%             text(KB(1,2),KB(2,2),KB(3,2),'YkB')
%             text(KB(1,3),KB(2,3),KB(3,3),'ZkB')
            
            line([centroQ(1) centroQ(1) centroQ(1); Q(1,:)],[centroQ(2) centroQ(2) centroQ(2); Q(2,:)],[centroQ(3) centroQ(3) centroQ(3); Q(3,:)],'col','g')
            text(Q(1,1),Q(2,1),Q(3,1),'XB')
            text(Q(1,2),Q(2,2),Q(3,2),'YB')
            text(Q(1,3),Q(2,3),Q(3,3),'ZB')
            xlabel('x')
            ylabel('y')
            zlabel('z')
%             
            for t = 1:stop(trial)-start(trial)+1
                
                 line([khipx(t,:) khipx(t,1)],[khipy(t,:) khipy(t,1)],[khipz(t,:) khipz(t,1)],'col','g')
                hold on
                line([khipx(t,1) ktrunkx(t) kshx(t,1)],[khipy(t,1) ktrunky(t) kshy(t,1)],[khipz(t,1) ktrunkz(t) kshz(t,1)],'col','m')
                line([kshx(t,:) kshx(t,1)],[kshy(t,:) kshy(t,1)],[kshz(t,:) kshz(t,1)],'col','g')
                
                plot3(khipx(t,1),khipy(t,1),khipz(t,1),'or')
                hold on
                plot3(khipx(t,2),khipy(t,2),khipz(t,2),'ob')
                plot3(khipx(t,3),khipy(t,3),khipz(t,3),'og')
                
                
                line([hipxm(t,:) hipxm(t,1)],[hipym(t,:) hipym(t,1)],[hipzm(t,:) hipzm(t,1)],'col','c')
                hold on
                line([hipxm(t,1) trunkxm(t) shxm(t,1)],[hipym(t,1) trunkym(t) shym(t,1)],[hipzm(t,1) trunkzm(t) shzm(t,1)],'col','c')
                line([shxm(t,:) shxm(t,1)],[shym(t,:) shym(t,1)],[shzm(t,:) shzm(t,1)],'col','c')
                
                plot3(hipxm(t,1),hipym(t,1),hipzm(t,1),'or')
                hold on
                plot3(hipxm(t,2),hipym(t,2),hipzm(t,2),'ob')
                plot3(hipxm(t,3),hipym(t,3),hipzm(t,3),'og')
                
                
                line([hipx(t,:) hipx(t,1)],[hipy(t,:) hipy(t,1)],[hipz(t,:) hipz(t,1)])
                hold on
                line([hipx(t,1) trunkx(t) shx(t,1)],[hipy(t,1) trunky(t) shy(t,1)],[hipz(t,1) trunkz(t) shz(t,1)],'col','r')
                line([shx(t,:) shx(t,1)],[shy(t,:) shy(t,1)],[shz(t,:) shz(t,1)])
                
                plot3(hipx(t,1),hipy(t,1),hipz(t,1),'or')
                hold on
                plot3(hipx(t,2),hipy(t,2),hipz(t,2),'ob')
                plot3(hipx(t,3),hipy(t,3),hipz(t,3),'og')
                xlabel('x')
                ylabel('y')
                zlabel('z')
                %                         zlim([-1 1])
                % xlim([0 3])
                %                         ylim([2.06 3])
                view(0,0);
                %                         view(-90,0);
                drawnow
                %
                %                 pause(1)
            end
            keyboard
