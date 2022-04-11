# Focuser

A 3d printable focuser for Celestron 11" and Moonlite compatible firmware for arduino.

# Hardware

3d Printable, requires NEMA 17 stepper & m3 screws, 30mm M5 flat head screws, thin m5 nuts nuts.

Prints in 6 parts with no support. top and bottom are each printed in two parts and glued together. The only overhangs are the countersinks on top, they print reliably with no support. For all parts I suggest hotter than normal bed temp (70C for PLA) and no brim. Set the printer to leave the bed hot when done, and cover the part with something insulating like a hand towel before turning off the bed heat. Letting the part soak up the heat from the bed, followed by slow even cooling, zero warpage!

# Software

Adapted from https://www.andico.org/2014/04/arduino-based-motor-focuser-controller.html

I forget what I changed and why.

# Libraries

The following libraries are used:

* AccelStepper by Mike McCauley
* NopSCADlib
* Gears Library for OpenSCAD by janssen86.

They are included in this repo for ease of use.
