include <parameter.scad>
include <libs/rcube.scad>;

nut();

module nut(){
$fn=16;
shftDia=5.7;
nutDia=11.5;
nutZ=2.5;
wthick=4;
edgeR=3;
adjDist=4;

x=slotXY+wthick*2;
yA=slotXY+wthick*2;
yB=strPosX+shftDia/2+wthick; 
z=nutDia+1.5;

difference(){
union(){
translate([0,0,0])rcube([x,yA,z],edgeR);
translate([0,-yB/2,0])rcube([x,yB,z],edgeR);
}
translate([0,strPosY,z/2])rotate([0,90,0])cylinder(d=shftDia,h=x*2,center=true);

translate([0,0,-1])rcube([slotXY,slotXY,z+2],0.1);
translate([0,0,z/2])rotate([0,-90,0])cylinder(d=m5Dia,h=x*2);
}
}