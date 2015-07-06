function [AngleR] = AngleSensorRoomba(serPort);
%[AngleR] = AngleSensorRoomba(serPort)
% Displays the angle in radians and degrees that Create has turned since the angle was last requested.
% Counter-clockwise angles are positive and Clockwise angles are negative.


% By; Joel Esposito, US Naval Academy, 2011

%Initialize preliminary return values
AngleR = nan;

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

srl_fwrite(serPort, [142]);  srl_fwrite(serPort,20);          %142: Get , 20:Angle

AngleR = srl_fread(serPort, 1, 'int16')*pi/180;
pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end