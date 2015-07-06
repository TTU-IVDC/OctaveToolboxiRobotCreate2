function [Voltage] = BatteryVoltageRoomba(serPort);
%Indicates the voltage of Create's battery in Volts


% By; Joel Esposito, US Naval Academy, 2011

%Initialize preliminary return values
Voltage = nan;

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
srl_fwrite(serPort, [142]);  srl_fwrite(serPort,22);     %Changed to opcode 22

Voltage = srl_fread(serPort, 1, 'uint16')/1000;

pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end