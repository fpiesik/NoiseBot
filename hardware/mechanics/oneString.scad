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
include <act_PortaDamp.scad>

module oneString(){

translate([0,0,500])rotate([0,0,0])2020Profile(1000);

translate([0,0,280]){
translate([0,0,strScale])tuner();
bridge();
translate([0,0,100])kickup(0);
translate([0,0,150])moPick();
translate([0,0,180])rotor();
translate([0,0,470])portaPitch();
translate([0,0,-70])portaDamp();
   
}
}

oneString();