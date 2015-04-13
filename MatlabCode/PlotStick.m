function PlotStick(datadir)

% markers = {'hipc','spine','shc','head','shl','elbl','wristl','handl','shr','elbr','wristr','handr','hipl','kneel','anklel','footl','hipr','kneer','ankler','footr'};
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
if ~isempty(find([listsubj.isdir]==0))
    soggetti=soggetti(2:end);
end
A=load(['mats',filesep,'ReachKinectData']);

CalibPosture=load(['mats',filesep,'Mappe']);

for subj=1:size(A.ind,1)
    
    for sess=1:size(A.ind,2)
        for g = 1:size(A.ind,3)
            if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
                post=CalibPosture.ind{sess,subj}.A_oPosture;
            else
                post=CalibPosture.ind{sess,subj}.APosture;
            end
            Npost = nanmean(post);
            hipL=Npost(:,37:39);
            hipR=Npost(:,49:51);
            hipC=Npost(:,1:3);
            B = [hipR;hipC;hipL];            
            % create the normal vector to our plane
            v1 = cross(hipR-hipC, hipL-hipC);
            mag_v1 = sqrt(sum(v1.^2,2));
            ZB=v1./[mag_v1 mag_v1 mag_v1];
            %verifico che la magnitude sia 1
            sqrt(sum(ZB.^2,2))
            % :-)
            
            %vettore lungo ZB hipR-hipL e calcolo il versore
            vRL = hipR-hipL;
            mag_vRL = sqrt(sum(vRL.^2,2));
            XB = vRL./[mag_vRL mag_vRL mag_vRL];
            %verifico che la magnitude sia 1
            sqrt(sum(XB.^2,2))
            % :-)
            
            % verifico che i vettori ZB e YB siano perpendicolari
            dot(XB,ZB)
            % :-( però...
            acosd(dot(XB,ZB)) % è comunque 90...
            
            % create the normal vector to XB e ZB
            v2 = cross(XB, ZB);
            mag_v2 = sqrt(sum(v2.^2,2));
            YB=v2./[mag_v2 mag_v2 mag_v2];
            %verifico che la magnitude sia 1
            sqrt(sum(XB.^2,2))
            
            dot(YB,XB)
            dot(ZB,YB)
            acosd(dot(ZB,YB))
            
            Q = [XB;YB;ZB];
            [R, OB] = rigid_transform_3D(B,Q);
            %             if ~isnan(start{subj,sess,g})
            for trial = 1:20
                data_markers = A.ind{subj,sess,g}{trial}+repmat(Npost,size(A.ind{subj,sess,g}{trial},1),1);
                zind = find(sum(abs(data_markers'))~=0);
                data_markers=data_markers(zind,:);
                xyz = [];
                for i=1:3:size(data_markers,2)-2
                    %                     xyz = cat(3,xyz, data_markers(:,i:i+2));
                    
                    PB = (R*data_markers(:,i:i+2)')+ repmat(OB,1,size(data_markers(:,i:i+2),1));
                    xyz = cat(3,xyz, PB');
                end
                                
                hipx = squeeze(xyz(:,1,[1 13 17]));
                hipy = squeeze(xyz(:,2,[1 13 17]));
                hipz = squeeze(xyz(:,3,[1 13 17]));
                trunkx = squeeze(xyz(:,1,[2]));
                trunky = squeeze(xyz(:,2,[2]));
                trunkz = squeeze(xyz(:,3,[2]));
                shx = squeeze(xyz(:,1,[3 5 9]));
                shy = squeeze(xyz(:,2,[3 5 9]));
                shz = squeeze(xyz(:,3,[3 5 9]));
                
                
                %     PLOTTO LO SKELETON INTERO   %%
                
                %                 prompt = 'Vuoi vedere lo skeleton? ';
                result = 1;%input(prompt);
                if result==1
                    h_skt=figure;
                    
                    for t = 1:size(hipx,1)
                        
                        line([hipx(t,:) hipx(t,1)],[hipz(t,:) hipz(t,1)],[hipy(t,:) hipy(t,1)])
                        hold on
                        line([hipx(t,1) trunkx(t) shx(t,1)],[hipz(t,1) trunkz(t) shz(t,1)],[hipy(t,1) trunky(t) shy(t,1)])
                        line([shx(t,:) shx(t,1)],[shz(t,:) shz(t,1)],[shy(t,:) shy(t,1)])
                        
                        plot3(hipx(t,1),hipz(t,1),hipy(t,1),'or')
                        hold on
                        plot3(hipx(t,2),hipz(t,2),hipy(t,2),'ob')
                        plot3(hipx(t,3),hipz(t,3),hipy(t,3),'og')
                        
                        xlabel('x')
                        ylabel('z')
                        zlabel('y')
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
                    close
                end
            end %trial
            
            %             end
        end%g
    end%sess
    
    
    
end%subj