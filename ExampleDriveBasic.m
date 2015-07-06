%{
This example demonstrates two of the ways to control the Create's wheels
1) SetFwdVelRadiusRoomba([Serial Port],[Forward Velocity(m/s)],[Radius])
   - Serial Port: Serial port object defined in RoombaInit
   - Forward Velocity: Value between -.5 and +.5 in m/s
   - Radius: + is CCW. - is CW. Valid Range is [-2,2].
      - Special Cases: Straight: inf
                       Turn in place CW: -eps
                       turn in place CCW: eps

2) SetDriveWheelsCreate([Serial Port], [RightWheel], [LeftWheel])
   - Serial Port: Serial port object defined in RoombaInit
   - Right Wheel: Right Wheel Velocity in m/s
   - Left Wheel: Left Wheel Velocity in m/s

Note: Set Serial Port to port connected to Create
%}

close all
clear all
clc

if (exist("serial") == 3)
    disp("Serial: Supported")
else
    disp("Serial: Unsupported")
endif

%
%# Open default serial port ttyUSB0 in default configuration of 115200, 8-N-1
%%s0 = serial() 
%# Opens serial port ttyUSB1 with baudrate of 115200 (config defaults to 8-N-1)
%s1 = serial("COM1", 115200) 
%
%# Flush input and output buffers
%srl_flush(s1); 
%# Blocking write call, currently only accepts strings
%srl_write(s1, "Hello world!") 
%# Blocking read call, returns uint8 array of exactly 12 bytes read
%data = srl_read(s1, 12)  
%# Convert uint8 array to string, 
%char(data)


clear all;
clc

%This adds the Roomba2 Toolbox to the load path for this session
%Be sure to change this to match the correct path
addpath (genpath("C:\Users\Matthew\Documents\Octave Files\Matthew's Packages\OctaveToolboxiRobotCreate2\Functions"))

% Initialize communication: Change to match appropriate Serial Port
[serialObject] = RoombaInit(1)

% Read distance sensor (provides baseline)
InitDistance = DistanceSensorRoomba(serialObject)






%travelDist(serialObject, 0.1, 0.2);







SetDriveWheelsCreate(serialObject, .3, .3);
pause(3);
SetDriveWheelsCreate(serialObject, 0, 0);
% read the distance sensor.
% returns dist since last reading in meters
Distance = DistanceSensorRoomba(serialObject)
%Angle = AngleSensorRoomba(serialObject)

%{
%}