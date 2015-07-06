function [BumpRight, BumpLeft, BumpFront, Wall, CliffLft, ...
    CliffRgt, CliffFrntLft, CliffFrntRgt, virtWall, SideBrushCurr, Reserved, ...
    MainBrushCurr, RightWheelCurr, LeftWheelCurr, ...
    Dirt, Unused16, RemoteCode, ButtonClean, ButtonSpot, ButtonDock, ...
    ButtonMinute, ButtonHour, ButtonDay, ButtonSchedule, ButtonClock, ...
    Dist, Angle, ChargeState, Volts, Current, Temp, Charge, Capacity, ...
    pCharge, WallSignal, CliffLeftSig, CliffFrontLeftSig, CliffFrontRightSig, ...
    CliffRightSig, Unused32, Unused33, ChargeSource, OIMode, SongNumber, ...
    SongPlaying, NumberStreamPackets, RequestedVel, RequestedRadius, ...
    RequestedRightVel, RequestedLeftVel, LeftEncoderCounts, ...
    RightEncoderCounts, LtbumpLeft, LtbumpFrontLeft, LtbumpCenterLeft, ...
    LtbumpCenterRight, LtbumpFrontRight, LtbumpRight, LightBumpLeftSig, ...
    LightBumpFrontLeftSig, LightBumpCenterLeftSig, LightBumpCenterRightSig, ...
    LightBumpFrontRightSig, LightBumpRightSig, Unused52, Unused53, ...
    LeftMotorCurrent, RightMotorCurrent, MainBrushMotorCurrent, ...
    SideBrushMotorCurrent, Stasis ] =  AllSensorsReadRoomba(serPort);




%{
function [BumpRight, BumpLeft, BumpFront, Wall, virtWall, CliffLft, ...
    CliffRgt, CliffFrntLft, CliffFrntRgt, LeftCurrOver, RightCurrOver, ...
    DirtL, DirtR, ButtonPlay, ButtonAdv, Dist, Angle, ...
    Volts, Current, Temp, Charge, Capacity, pCharge]   = AllSensorsReadRoomba(serPort);

%}
%[BumpRight, BumpLeft, BumpFront, Wall, virtWall, CliffLft, ...
%   CliffRgt, CliffFrntLft, CliffFrntRgt, LeftCurrOver, RightCurrOver, ...
%   DirtL, DirtR, ButtonPlay, ButtonAdv, Dist, Angle, ...
%   Volts, Current, Temp, Charge, Capacity, pCharge]   = AllSensorsReadRoomba(serPort)
% Reads Roomba Sensors
% [BumpRight (0/1), BumpLeft(0/1), BumpFront(0/1), Wall(0/1), virtWall(0/1), CliffLft(0/1), ...
%    CliffRgt(0/1), CliffFrntLft(0/1), CliffFrntRgt(0/1), LeftCurrOver (0/1), RightCurrOver(0/1), ...
%    DirtL(0/1), DirtR(0/1), ButtonPlay(0/1), ButtonAdv(0/1), Dist (meters since last call), Angle (rad since last call), ...
%    Volts (V), Current (Amps), Temp (celcius), Charge (milliamphours), Capacity (milliamphours), pCharge (percent)]
% Can add others if you like, see code
% Esposito 3/2008
% initialize preliminary return values
% By; Joel Esposito, US Naval Academy, 2011
BumpRight = nan;
BumpLeft = nan;
BumpFront = nan;
Wall = nan;
virtWall = nan;
CliffLft = nan;
CliffRgt = nan;
CliffFrntLft = nan;
CliffFrntRgt = nan;
LeftCurrOver = nan;
RightCurrOver = nan;
DirtL = nan;
DirtR = nan;
ButtonPlay = nan;
ButtonAdv = nan;
Dist = nan;
Angle = nan;
Volts = nan;
Current = nan;
Temp = nan;
Charge = nan;
Capacity = nan;
pCharge = nan;



try

%%Flush buffer
%N = serPort.BytesAvailable();
%while(N~=0) 
%srl_fread(serPort,N);
%N = serPort.BytesAvailable();
%end

srl_flush(serPort , 2)    %Flush inserted for Octave

warning off
global td
sensorPacket = [];
% flushing buffer


%confirmation = (srl_fread(serPort,1));
%while ~isempty(confirmation)
%    confirmation = (srl_fread(serPort,26));
%end


%% Get (142) ALL(0) data fields. This has changed to 100
srl_fwrite(serPort, [142 100]);

%% Read data fields
BmpWheDrps = dec2bin(srl_fread(serPort, 1, 'uint8'),8);  %
BumpRight = bin2dec(BmpWheDrps(end));  % 0 no bump, 1 bump
BumpLeft = bin2dec(BmpWheDrps(end-1));
if BumpRight*BumpLeft==1
    BumpRight =0;
    BumpLeft = 0;
    BumpFront =1;
else
    BumpFront = 0;
end
%Packet 8
Wall = srl_fread(serPort, 1);  %0 no wall, 1 wall
%Packet 9-12
CliffLft = srl_fread(serPort, 1); % no cliff, 1 cliff
CliffFrntLft = srl_fread(serPort, 1);
CliffFrntRgt = srl_fread(serPort, 1);
CliffRgt = srl_fread(serPort, 1);

%Packet 13
virtWall = srl_fread(serPort, 1);%0 no wall, 1 wall

%Packet 14
motorCurr = dec2bin( srl_fread(serPort, 1),8 );
SideBrushCurr = motorCurr(end);  % 0 no over curr, 1 over Curr
Reserved = motorCurr(end-1);  % 0 no over curr, 1 over Curr
MainBrushCurr = motorCurr(end-2);  % 0 no over curr, 1 over Curr
RightWheelCurr = motorCurr(end-3);  % 0 no over curr, 1 over Curr
LeftWheelCurr = motorCurr(end-4) ; % 0 no over curr, 1 over Curr

%Packet 15
Dirt = srl_fread(serPort, 1);
%Packet 16
Unused16 = srl_fread(serPort, 1);
%Packet 17
RemoteCode =  srl_fread(serPort, 1); % coudl be used by remote or to communicate with sendIR command
%Packet 18
Buttons = dec2bin(srl_fread(serPort, 1),8);
ButtonClean = Buttons(end);
ButtonSpot = Buttons(end-1);
ButtonDock = Buttons(end-2);
ButtonMinute = Buttons(end-3);
ButtonHour = Buttons(end-4);
ButtonDay = Buttons(end-5);
ButtonSchedule = Buttons(end-6);
ButtonClock = Buttons(end-7);

%Packets 19,20
%Distance is the wrong sign for some reason. 
Dist = -1*srl_fread(serPort, 1, 'int16')/1000; % convert to Meters, signed, average dist wheels traveled since last time called...caps at +/-32
Angle = srl_fread(serPort, 1, 'int16')*pi/180; % convert to radians, signed,  since last time called, CCW positive

%Packet 21-26
ChargeState = srl_fread(serPort, 1);
Volts = srl_fread(serPort, 1, 'uint16')/1000;
Current = srl_fread(serPort, 1, 'int16')/1000; % neg sourcing, pos charging
Temp  =  srl_fread(serPort, 1, 'int8') ;
Charge =  srl_fread(serPort, 1, 'uint16'); % in mAhours
Capacity =  srl_fread(serPort, 1, 'uint16');
pCharge = Charge/Capacity *100;  % May be inaccurate
%checksum =  srl_fread(serPort, 1)

%--------------------------------------------------------------------
%Below is added for the create 2
%1/27/2015 Matthew Powelson

%Packet 27
WallSignal = srl_fread(serPort, 1, 'uint16');
%Packet 28-31
CliffLeftSig = srl_fread(serPort, 1, 'uint16'); %0-4095
CliffFrontLeftSig = srl_fread(serPort, 1, 'uint16');
CliffFrontRightSig = srl_fread(serPort, 1, 'uint16');
CliffRightSig = srl_fread(serPort, 1, 'uint16');
%Packet 32-33
Unused32 = srl_fread(serPort, 1, 'int8');
Unused33 = srl_fread(serPort, 1, 'uint16');

%Packet 34
ChargeSource = srl_fread(serPort, 1, 'uint8');

%Packet 35
OIMode = srl_fread(serPort, 1, 'uint8');
%Packet 36-37
SongNumber = srl_fread(serPort, 1, 'uint8');
SongPlaying = srl_fread(serPort, 1, 'uint8');
%Packet 38
NumberStreamPackets = srl_fread(serPort, 1, 'uint8');
%Packet 39-42
RequestedVel = srl_fread(serPort, 1, 'int16');
RequestedRadius = srl_fread(serPort, 1, 'int16');
RequestedRightVel = srl_fread(serPort, 1, 'int16');
RequestedLeftVel = srl_fread(serPort, 1, 'int16');

%Packet 43-44
LeftEncoderCounts = srl_fread(serPort, 1, 'uint16');
RightEncoderCounts = srl_fread(serPort, 1, 'uint16');

%Packet 45
LightBumper = srl_fread(serPort, 1, 'uint8');
LightBumper = dec2bin(LightBumper,8);
LtbumpLeft = LightBumper(end);
LtbumpFrontLeft = LightBumper(end - 2);
LtbumpCenterLeft = LightBumper(end - 3);
LtbumpCenterRight = LightBumper(end - 4);
LtbumpFrontRight = LightBumper(end - 5);
LtbumpRight = LightBumper(end - 6);

%Packet 46-51
LightBumpLeftSig = srl_fread(serPort, 1, 'uint16');
LightBumpFrontLeftSig = srl_fread(serPort, 1, 'uint16');
LightBumpCenterLeftSig = srl_fread(serPort, 1, 'uint16');
LightBumpCenterRightSig = srl_fread(serPort, 1, 'uint16');
LightBumpFrontRightSig = srl_fread(serPort, 1, 'uint16');
LightBumpRightSig = srl_fread(serPort, 1, 'uint16');

%Packets 52-53
Unused52 = srl_fread(serPort, 1, 'uint8');
Unused53 = srl_fread(serPort, 1, 'uint8');

%Packets 54-57
LeftMotorCurrent = srl_fread(serPort, 1, 'int16');
RightMotorCurrent = srl_fread(serPort, 1, 'int16');
MainBrushMotorCurrent = srl_fread(serPort, 1, 'int16');
SideBrushMotorCurrent = srl_fread(serPort, 1, 'int16');

%Packets 58 
Stasis = srl_fread(serPort, 1, 'uint8');


pause(td)
catch
    disp('WARNING: AllSensorsReadRoomba function did not terminate correctly.  Output may be unreliable.')
end