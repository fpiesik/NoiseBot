include <libs/rcube.scad>;
include <parameter.scad>;

module kickup(orientation){

hub=4;

top=4;

magdia=5.7;
magZ=20;
magnutdia=9.5;
magnutZ=4;
magthreadZ=magnutZ*2;

bottom=magZ-hub+1+magthreadZ;

zAdjDia=kickup_zAdjDia;
zAdjL=kickup_zAdjL;
zAdjDist=kickup_zAdjDist;
zAdjOff=kickup_zAdjOff;

coildia=14;
upperidlerZ=2;
loweridlerZ=2;
threaddepth=4;
coilZ=18; //magZ-bottom+threaddepth;
echo(coilZ);
magholedia=magdia;
wallthick=1;
coilthreaddia=4.9;

rampZ=3;
rampdia=coildia;


innerX=15;
innerY=16;
innerZ=coilZ+hub;

baseX=kickup_baseX;
baseY=kickup_baseY;
baseZ=innerZ+bottom+top;
echo(baseZ);


jackX=6.5;
jackY=3.5;
jackZ=10;
jacksupport=2;
jackpindia=1.5;
jackpindist=2.54;
jackpinsupport=1.5;

mountsupportY=2;

$fn=32;

solenoid();

module solenoid(){


module Ccube( size, align = [ 0, 0, 0 ] ){
 translate(size/2*[[align[0],0,0],[0,align[1],0],[0,0,align[2]]])
  cube( size, center = true );
}

module base(){
    
difference(){
}
translate([0,0,0]){
difference(){
Ccube([baseX,baseY,baseZ],[0,0,1]);
translate([0,0,bottom])Ccube([innerX,innerY,innerZ],[0,0,1]);
cylinder(d=magdia,h=baseZ+1);
hull(){
translate([0,0,magthreadZ-magnutZ])rotate([0,0,30])cylinder(d=magnutdia,h=magnutZ,$fn=6);
translate([0,-baseY,magthreadZ-magnutZ])rotate([0,0,30])cylinder(d=magnutdia,h=magnutZ,$fn=6);
}
hull(){
translate([zAdjDist/2,0,bottom/2-zAdjL/2+zAdjOff])rotate([90,0,0])cylinder(d=zAdjDia,h=baseZ*2,center=true);
translate([zAdjDist/2,0,bottom/2+zAdjL/2+zAdjOff])rotate([90,0,0])cylinder(d=zAdjDia,h=baseZ*2,center=true);
}
hull(){
translate([-zAdjDist/2,0,bottom/2-zAdjL/2+zAdjOff])rotate([90,0,0])cylinder(d=zAdjDia,h=baseZ*2,center=true);
translate([-zAdjDist/2,0,bottom/2+zAdjL/2+zAdjOff])rotate([90,0,0])cylinder(d=zAdjDia,h=baseZ*2,center=true);
}
}}
}



module coil(){
difference(){
union(){
cylinder(d=magholedia+wallthick*2,h=coilZ);
translate([0,0,loweridlerZ])cylinder(d1=rampdia,d2=magholedia+wallthick*2,h=rampZ);
translate([0,0,coilZ-upperidlerZ-rampZ])cylinder(d2=rampdia,d1=magholedia+wallthick*2,h=rampZ);
translate([0,0,coilZ-upperidlerZ])cylinder(d=coildia,h=upperidlerZ);
//Ccube([coildia,coildia,upperidlerZ],[0,0,1]);
translate([0,0,0]){
Ccube([coildia,coildia,loweridlerZ],[0,0,1]);

}
}
translate([0,0,threaddepth]){
cylinder(d=magholedia,h=coilZ);}
cylinder(d=coilthreaddia,h=coilZ+1);
}}

module mount(){
wthick=4;
edgeR=3;

slotKickD=-strPosY-slotXY/2-kickup_baseY/2;
ax=slotXY*2+wthick;
ay=slotXY+slotKickD+wthick;
az=kickup_baseX;

scrwD=2.6;

t=0.2;
difference(){
    translate([-slotXY/2-wthick/2,-slotKickD/2+wthick/2,-az/2])rcube([ax,ay,az],edgeR);
    translate([slotXY/2,-slotXY/2,-az/2-1])rcube([slotXY*2+t,slotXY*2+t,az*2],0.1);
    rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY);
    hull(){
    translate([-slotXY*0.65,0,kickup_zAdjDist/2])rotate([-90,0,0])cylinder(d=scrwD,h=slotXY*2,center=true);
    translate([-slotXY*1.4,0,kickup_zAdjDist/2])rotate([-90,0,0])cylinder(d=scrwD,h=slotXY*2,center=true);
    }
    hull(){
    translate([-slotXY*0.65,0,-kickup_zAdjDist/2])rotate([-90,0,0])cylinder(d=scrwD,h=slotXY*2,center=true);
    translate([-slotXY*1.4,0,-kickup_zAdjDist/2])rotate([-90,0,0])cylinder(d=scrwD,h=slotXY*2,center=true);
    }
}

}

if(orientation==1){
translate([0,strPosY,-39]){
base();
translate([0,0,bottom+threaddepth])coil();}
translate([0,slotXY+strPosY,0])rotate([0,-90,0])mount();
}

if(orientation==2){
base();
translate([25,0,0])rotate([90,0,0])coil();
}

}
}
