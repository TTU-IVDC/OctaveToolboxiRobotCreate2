%{
This example demonstrates the various methods of reading the Create2's
sensors. For details on interpreting the sensor readings, see the Create
Open Interface Manual.

Note that not all sensor read functions are included in this example. See
the documentation for information on other individual sensor read
functions.
%}

%This adds the Roomba2 Toolbox to the load path for this session
%Be sure to change this to match the correct path
%addpath (genpath('C:\Users\Grad Student\Documents\MATLAB\Toolboxes\MatlabToolboxiRobotCreate2'))

% Initialize communication
clear all;
clc;
PAGER("more");   %Fixes autoscroll


[serialObject] = RoombaInit(1)       %Change to match serial port

format compact


% Stores the values of the all sensors in the appropriate variables
[BumpRight, BumpLeft, BumpFront, Wall, CliffLft, ...
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
    SideBrushMotorCurrent, Stasis ]   = AllSensorsReadRoomba(serialObject);



% Checks the Bump Sensors and Wheel Drop Sensors
[BumpRight,BumpLeft,WheDropRight,WheDropLeft,BumpFront] = ...
    BumpsWheelDropsSensorsRoomba(serialObject);


% Returns the distance traveled since the last time the distance was
% checked. Note that AllSensorsReadRoomba also resets the distance.
[Distance] = DistanceSensorRoomba(serialObject);

% Checks what buttons are pressed
[ButtonClean, ButtonSpot, ButtonDock, ButtonMinute, ButtonHour...
    ButtonDay, ButtonSchedule, ButtonClock] = ButtonsSensorRoomba(serialObject);
% See the MTIC Documentation for details on the other individual sensor read
% funcions
%}