include <libs/T-Slot.scad>
include <libs/rcube.scad>;
include <parameter.scad>;
use <libs/Nema17.scad>
include <libs/gearRack.scad>
include <libs/linearBearing.scad>
include <act_portaPitch.scad>
include <act_kickup.scad>
include <string.scad>
include <tuner.scad>
include <bridge.scad>




gHarp();

module gHarp(){

translate([0,0,500])rotate([0,0,0])2020Profile(1000);
//string();
//translate([0,0,400])tuner();
translate([0,0,60])rotate([0,0,0])bridge();
//translate([0,0,120])rotate([0,90,0])kickup(1);
//translate([0,0,120])kickupMnt();
//
//translate([0,0,200])servoMnt();
//translate([0,0,200])teensyMnt();
//translate([0,0,200])jackMnt();
//translate([0,0,200])stopMnt();
//translate([0,strPosY,200])pick();

//translate([0,0,50])moFret();
//translate([0,0,0])pcbMntB();

//translate([0,0,100])nut();

}


module Cello(){
strScale=650;
strDia=3;
strPosX=20;
strPosY=-20;
slotXY=20;

nema17_height=40;
nema17_width=42;
nema17_shftDia=5;
nema17_shftLen=28;
nema17_holeDist=31;
Nema17_gearDia=23;

tuner_bDi=7.8;
tuner_bDo=22.2;
tuner_bZ=10;
tuner_rThick=5;
//tuner_tDia=strPosX*2; (big)
tuner_tDia=strPosX*2-10;
tuner_leverZ=10;
tuner_zPos=225;
tuner_strDia=strDia[0];
tuner_leverY=35;

//----------Kickup----------------------------------------------------

//for Bass
//kickup_baseX=22;
//kickup_baseY=15;
//kickup_zAdjDia=3.3;
//kickup_zAdjL=10;
//kickup_zAdjDist=13;
//kickup_zAdjOff=4;

//for Alt
kickup_baseX=17;
kickup_baseY=13;
kickup_zAdjDia=3.3;
kickup_zAdjL=10;
kickup_zAdjDist=10.5;
kickup_zAdjOff=4;
//------------------------------------------------------------------------

slide_cpDst=1.5;
slide_rackPosX=(55-12.5);

m3NutD=6.6;
m4Dia=4.3;
m4NutD=8.3;
m5Dia=5.3;

edgeR=3;

gearXPos=57;
gearYPos=0;
gearZPos=360;

rackScrD=20;
rack_X=13;
rack_Y=15.5;
rack_extOffX=0;

bearGearD=25;
mntGrD=20.5; //mount gear distance



//translate([-nema17_height-slotXY/2-8,-(-nema17_width/2-slotXY/2)-(nema17_width-Nema17_gearDia)/2,900])rotate([90,0,90])Nema17(MotorHeight=nema17_height,MotorWidth=nema17_width,ShaftDiameter=nema17_shftDia,ShaftLength=nema17_shftLen,FixingHolesInteraxis=nema17_holeDist);

translate([0,0,500])rotate([0,0,0])2020Profile(1000);

//translate([0,0,300])rotate([0,0,0])slide();
//
//
//stpprMnt();
//
//translate([gearXPos-10.5,0,596.5])rotate([180,0,-90])gearRack(1);
//translate([gearXPos,0,gearZPos])rotate([0,0,-90])gearRack(2);
//translate([slide_rackPosX,0,300])rackExt();
////
string();
//
//translate([0,0,400])tuner();
//
!translate([0,0,60])rotate([0,0,0])bridge();
//translate([8,-slotXY,30])rotate([0,0,90])piezoPickup(1);
//
//translate([-39,strPosY,120])rotate([0,90,0])kickup(1);
//translate([0,0,120])kickupMnt();
//
//translate([0,0,200])servoMnt();
//translate([0,0,200])teensyMnt();
//translate([0,0,200])jackMnt();
//translate([0,0,200])stopMnt();
//translate([0,strPosY,200])pick();

//translate([0,0,50])moFret();
//translate([0,0,0])pcbMntB();

//translate([0,0,100])nut();

}




