function [serPort] = RoombaInit(my_COM);
%[serPort] = RoombaInit(my_COM)
% initializes serial port for use with Roomba
% COMMport is the number of the comm port 
% ex. RoombaInit(1) sets port = 'COM1'
% note that it sets baudrate to a default of 57600
% can be changed (see SCI).  
% An optional time delay can be added after all commands
% if your code crashes frequently.  15 ms is recommended by irobot
% By; Joel Esposito, US Naval Academy, 2011
global td
td = 0.015;
% This code puts the robot in CONTROL(132) mode, which means does NOT stop 
% when cliff sensors or wheel drops are true; can also run while plugged into charger
Contrl = 131;  % Changed to Safe Mode 11/14/2013 (TTU)

% Esposito 9/2008 

warning off

%% set up serial comms,   
% output buffer must be big enough to take largest message size
comm = strcat('COM', num2str(my_COM))

%{
%instrfind is not supported in Octave 3/2/15
a = instrfind('port',comm);
if ~isempty(a)
            disp('That com port is in use.   Closing it.')
            fclose(a);
            pause(1)
            delete(a);
            pause(1)
end
  
%}
  
disp('Establishing connection to Roomba...');

% defaults at 115200 for Create2, can change to 19200 if needed. 
serPort = serial(comm, 115200, 10)
%test to see if supported 3/2/15
%set(serPort,'Terminator','LF')
%set(serPort,'InputBufferSize',100)
%set(serPort, 'Timeout', 1)
%set(serPort, 'ByteOrder','bigEndian');
%set(serPort, 'Tag', 'Roomba')

disp('Opening connection to Roomba...');
fopen(serPort);

%% Confirm two way connumication
disp('Setting Roomba to Control Mode...');
% Start! and see if its alive

Start=[128];
%srl_write(serPort,Start);        %Check fwrite vs srl_write for octave
srl_fwrite(serPort, 128);        %Check fwrite vs srl_write for octave
pause(.1)

Contrl;
%srl_write(serPort,Contrl);
srl_fwrite(serPort,Contrl);
pause(.1)
% light LEDS check these on Create 2
srl_fwrite(serPort,[164 73 86 68 67]); %Display "IVDC"
%srl_write(serPort,[139 25 0 128]);

% set song
srl_fwrite(serPort, [140 2 3 76 5 77 5 79 5]);

%srl_write(serPort, [140 2 6 48 20 55 25 52 50 76 5 77 5 79 5]);
pause(0.05)
% sing it
srl_fwrite(serPort, [141 2]);
%Define "Beep"
srl_fwrite(serPort, [140 1 1 60 30]);
% srl_write(serPort, [141 1])

disp('I am alive if I my lights say IVDC and I beep')

confirmation = (srl_read(serPort,4))
pause(.1)
%{
%}
