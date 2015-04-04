function [DimJerk] = m3_P_DimJerk(Time,CursorXY)
% When called, this function will calculate the dimensionless jerk for the reach
% It is adapted from Hogan 2009. Originally written by Mei-Hua Lee.
% Adapted by: Ismael Seanez
% Date: Oct 20, 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
dt = 0.02; % Sampling time

    % Velocity
    Vx = smooth(diff(CursorXY(:,1))/dt,17);
    Vy = smooth(diff(CursorXY(:,2))/dt,17);
    
    % Acceleration
    Ax = smooth(diff(Vx)/dt,17);
    Ay = smooth(diff(Vy)/dt,17);
    
    % Jerk
    Jx = smooth(diff(Ax)/dt,21);
    Jy = smooth(diff(Ay)/dt,21);
    
    % Peak speed
    vlrx = Vx;
    vlry = Vy;

    % 3D resultant speed
    rs = sqrt((vlrx.^2) + (vlry.^2));
    mrs = mean(rs); % average resultant speed
    prs = max(rs);  % peak resultant speed

    % Jerk 
    jlrx = Jx;
    jlry = Jy;

    % Resultant Jerk
    rj = sqrt((jlrx.^2) + (jlry.^2));

    % Integrated squared jerk (cm^2/s^5)
    dt = 0.02;
    ij = (trapz(rj.^2))*dt/2;

    % Movement time
    mt =  Time(end)-Time(1);

    % Mean square jerk (cm^2/s^6)
    msj = ij/mt;

    % Cumulative squared jerk (cm^2/s^6)
    csj = (sum(ij.^2));

    % Soot mean squared jerk (cm/s^3)
    rmj = sqrt(msj);

    % Mean squared jerk normalized by peak speed (cm/s^5)
    msjnp = msj/prs;

    % Integrated absolute jerk (cm/s^2)
    iaj=(trapz(abs(rj)))*dt/2;

    % Mean absolute jerk normalized by peak speed (1/s^2)
    majnp = iaj/mt/prs;

    % Dimensionless integrated squared jerk:
        % Normalized by mean speed
        DimJerk = sqrt(ij*(mt^3)/(mrs^2));
        % Normalized by peak speed
        % DimJerk = sqrt(ij*(mt^3)/(prs^2));
