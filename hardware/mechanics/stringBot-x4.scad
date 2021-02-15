include <libs/T-Slot.scad>
use <libs/Nema17.scad>
include <libs/gearRack.scad>
include <libs/linearBearing.scad>

include <parameter.scad>
include <bridge.scad>
include <tuner.scad>
include <act_kickup.scad>
include <act_Pick.scad>
include <act_motor.scad>
include <act_PortaPitch.scad>
include <oneString.scad>

for (a = [0 : 3]) {
    translate([0, a*120, 0]) 
        oneString();
}
