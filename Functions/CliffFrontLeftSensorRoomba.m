function [state] = CliffFrontLeftSensorRoomba(serPort);
%[state] = CliffFrontLeftSensorRoomba(serPort)
% Specifies the state of the Cliff Front Left sensor
% Either triggered or not triggered

% By; Joel Esposito, US Naval Academy, 2011

%Initialize preliminary return values
state = nan;
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

srl_fwrite(serPort, [142]);  srl_fwrite(serPort,10); 
CliffFrntLft = dec2bin(srl_fread(serPort, 1));
state = bin2dec(CliffFrntLft(end));

pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
