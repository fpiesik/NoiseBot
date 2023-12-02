include <libs/T-Slot.scad>
use <libs/Nema17.scad>
include <libs/gearRack.scad>
include <libs/linearBearing.scad>

include <parameter.scad>
include <string/bridgeV2.scad>
include <string/tuner.scad>
include <actuators/act_kickup.scad>
include <actuators/act_Pick.scad>
include <actuators/act_motor.scad>
include <actuators/act_PortaPitch.scad>
include <actuators/act_palm.scad>
use <mount/stand_A.scad>

nStr=3;
strDist=90;

for (a = [0 : nStr-1]) {
    translate([0, a*strDist, 0]){ 
        oneString();       
    }
}
stand_multi(nStr,strDist);
//top_multi(nStr,strDist);


module oneString(){

translate([0,0,500])rotate([0,0,0])2020Profile(1000);
translate([0,0,1000-strScale]){
translate([0,0,strScale-90])tuner();
translate([0,0,0])bridge();
translate([0,0,50])kickup(0);
translate([0,0,90])moPick();
translate([0,0,105])rotor();
translate([0,0,559])portaPitch();
translate([0,0,0])palm();
}
}

oneString();