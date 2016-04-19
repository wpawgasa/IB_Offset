%Initalize waitbar
h = waitbar(0,'Loading...',...
            'Name','Matlabvn_waitbar');
steps = 1000;
% Update waitbar
for step = 1:steps
    waitbar(step / steps,h,sprintf('Loading...%.2f%%',step/steps*100));
end
% %Delete waitbar
% delete(h)