
%Code taken from http://wiki.octave.org/Instrument_control_package#Serial
%{
This code shows how to use the instrument control package. 
Note that it requires the added function srl_fwrite to 
send integer values. In the future I hope to do the same thing
for fread in order to accomodate different data types.

%}


pkg load instrument-control

close all
clear all
clc

if (exist("serial") == 3)
    disp("Serial: Supported")
else
    disp("Serial: Unsupported")
endif


# Open default serial port COM1 in default configuration of 115200, 8-N-1
%s0 = serial() 
# Opens serial port COM2 with baudrate of 115200 (config defaults to 8-N-1)
s1 = serial("COM2", 115200) 
%s1 = serial("\\\\.\\COM15")        %Use this for COM ports over 9
%s1 = serial("COM1", 115200) 

# Flush input and output buffers
srl_flush(s1); 
# Blocking write call, currently only accepts strings
%srl_write(s1, "Hello world!");
srl_write(s1, uint8(200));
srl_fwrite(s1, [142 , 300], 'int16');

# Blocking read call, returns uint8 array of exactly 12 bytes read
%data = srl_read(s1, 12)
int8 = srl_read(s1, 1)
%intdata = srl_read(s1, 4)  
intdata = srl_fread(s1, 2, 'int16')
%char(intdata)
# Convert uint8 array to string, 
%char(data)




%{
%}