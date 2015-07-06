# OctaveToolboxiRobotCreate2

This code is being published for use in an unfinished state. This is a list of known issues and work to be done. If issues are fixed, 
please indicate in this document and leave the date the issue was fixed.

Also note that many of the functions included in this toolbox are untested. New issues may arise.

Tennessee Tech University
Last Updated: 4/20/2015

* Sensor Reading 
** Distance and Angle Readings are wrong    <----- Major Issue
** Schedule and Clock Buttons do not work

* Examples to add
** Basic Object Avoidance - relied on waitDist. Preferably fix waitDist and keep same example as with Create1
** Example of Keyboard Control - This was kind of cool on the Create1 but not necessary. Fixing waitDist/Angle should fix it.
** Output Example - LED and Beep examples.

* To Implement
** TravelDist and TurnAngle are no longer supported due to the lack of waitAngle and waitDist on the Create2. A replacement can be written.
** LED functions need to be looked at in general
** SetLED for digits - Create2 has a 4 digit ASCII display. A function to use this would be convenient. See 'IVDC' display in RoombaInit for example of manual display.

Dependencies
This package requires the instrument control toolbox. It is included with this download or can be found at the link below.
http://octave.sourceforge.net/instrument-control/

The instrument control toolbox requires Octave version 3.2.0 or greater

