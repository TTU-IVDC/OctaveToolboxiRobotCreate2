function [Charge, Capacity, Percent] = BatteryChargeReaderRoomba(serPort);
% Displays the current percent charge remaining in Create's Battery 

% By; Joel Esposito, US Naval Academy, 2011

%Initialize preliminary return values
Charge = nan;
Capacity = nan;
Percent = nan;

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
srl_fwrite(serPort, [142]);  srl_fwrite(serPort,25);
Charge =  srl_fread(serPort, 1, 'uint16');
srl_fwrite(serPort, [142]);  srl_fwrite(serPort,26);
Capacity =  srl_fread(serPort, 1, 'uint16');

Percent=Charge/Capacity*100;


pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
