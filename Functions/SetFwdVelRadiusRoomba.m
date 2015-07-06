function [] = SetFwdVelRadiusRoomba(serPort, FwdVel, Radius);
%[] = SetFwdVelRadiusRoomba(serPort, FwdVel, Radius)

%  Moves Roomba by setting forward vel and turn radius
%  serPort is a serial port object created by Roombainit 
%  FwdVel is forward vel in m/sec [-0.5, 0.5],
%  Radius in meters, postive turns left, negative turns right [-2,2].
%  Special cases: Straight = inf
%  Turn in place clockwise = -eps
%  Turn in place counter-clockwise = eps

% By; Joel Esposito, US Naval Academy, 2011
try
    
%Flush Buffer    
%N = serPort.BytesAvailable();
%while(N~=0) 
%fread(serPort,N);
%N = serPort.BytesAvailable();
%end
srl_flush(serPort, 2);      % Replaced with flush for Octave

warning off
global td
%% Convert to millimeters
FwdVelMM = min( max(FwdVel,-.5), .5)*1000;
if isinf(Radius)
    RadiusMM = 32768;
elseif Radius == eps
    RadiusMM = 1;
elseif Radius == -eps
    RadiusMM = -1;
else
    RadiusMM = min( max(Radius*1000,-2000), 2000);
end

%fwrite(serPort, [137, 255, 56, 1, 244])

srl_fwrite(serPort, [137]);  
srl_fwrite(serPort,FwdVelMM, 'int16'); 
srl_fwrite(serPort,RadiusMM, 'int16');
%disp('moving!')
pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end

