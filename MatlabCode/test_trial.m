close all
cursor = load('cursor');
start = load('start');
stop = load('stop');

start2 = load('start2');
stop2 = load('stop2');
plotReconstructedTrajByTraj(cursor.ind,start.ind,stop.ind,start2.ind,stop2.ind);
