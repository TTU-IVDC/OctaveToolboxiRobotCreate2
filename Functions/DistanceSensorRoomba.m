function [Distance] = DistanceSensorRoomba(serPort);
%[Distance] = DistanceSensorRoomba(serPort)
% Gives the distance traveled in meters since last requested. Positive
% values indicate travel in the forward direction. Negative values indicate
% travel in the reverse direction. If not polled frequently enough, it is
% capped at its minimum or maximum of +/- 32.768 meters.


% By; Joel Esposito, US Naval Academy, 2011

%Initialize preliminary return values
Distance = nan;

try
    
%Flush Buffer    
%N = serPort.BytesAvailable();
%while(N~=0) 
%srl_fread(serPort,N);
%N = serPort.BytesAvailable();
%end
srl_flush(serPort, 2);

warning off
global td
srl_fwrite(serPort, [142]);  srl_fwrite(serPort,19);

%Distance is the wrong sign for some reason
%There are other issues too 2/4/15
%Try swap bytes
%Try uint16 ?
Distance = -1 * srl_fread(serPort, 1, 'int16');
if (Distance > 32) | (Distance <-32)
    disp('Warning:  May have overflowed')
end

pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
