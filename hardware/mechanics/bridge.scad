include <libs/rcube.scad>;
include <parameter.scad>;

bridge();

module bridge(){
edgeR=3;
wthick=4;
pzDia=28;
pzSink=2;
pzThick=0.6;

pcbX=4;
pcbY=17.3;
pcbZ=27;

bH=slotXY*1.175;    
xy=slotXY+wthick*2;
h=pzDia+wthick+2;
t=0.1;
$fn=32;

piezo();
translate([0,0,-bH])bridge();
//translate([slotXY/2+wthick+pzThick-pzSink,-slotXY,h/2])rotate([0,90,0])Pz2Str();

module piezo(){
difference(){
hull(){
rcube([xy,xy,h],edgeR);
translate([0,strPosY,0])rcube([xy,pzDia+wthick*2,h],edgeR);
}
translate([-xy/2,strPosY+5,h/2-pcbZ+pzDia/2])rcube([pcbX,pcbY,pcbZ],0.1);
translate([-xy/2,strPosY+5,h/2-pcbZ+pzDia/2-2])rcube([pcbX,4,pcbZ],0.1);
translate([0,0,-5])rcube([slotXY+t,slotXY+t,h*2],0.1);
translate([xy/2,strPosY,h/2])rotate([0,-90,0])cylinder(d=pzDia,h=pzSink*2,center=true);
translate([0,0,h/2])rotate([-90,0,0])cylinder(d=m5Dia,h=xy);
hull(){
d=6;
translate([0,strPosY,h/2+pzDia/5])rotate([0,90,0])cylinder(d=d,h=xy*2,center=true);
translate([0,strPosY,h/2+pzDia/2-d/2])rotate([0,90,0])cylinder(d=d,h=xy*2,center=true);
}
}
}

module Pz2Str(){
    bridgeZ=4.5;
    pzDia=pzDia-1;
    bridgeD=m3NutD*1.5;
    baseZ=3.5;
    m4Dia=4.5;
    scrwD=3.3;
    nutD=m3NutD;
    scrwDst=12;//pzDia-bridgeD;
    cDia=4;
    difference([0,0,0]){
    union(){
    cylinder(d=pzDia,h=baseZ);
    translate([0,0,8])difference(){
    hull(){
        translate([0,scrwDst/2,0])cylinder(d=bridgeD,h=bridgeZ);
        translate([0,-scrwDst/2,0])cylinder(d=bridgeD,h=bridgeZ);
    }
    translate([0,scrwDst/2,-1.5])cylinder(d=nutD,h=bridgeZ,$fn=6);
    translate([0,-scrwDst/2,-1.5])cylinder(d=nutD,h=bridgeZ,$fn=6);
    translate([0,0,0])rotate([90,0,0])scale([1,0.6,1]){
    rotate_extrude(convexity = 10)
    translate([(bridgeD)/2+cDia/2, 0, 0])
    union(){
    circle(r = cDia/2, $fn = 100);
    translate([0,-cDia/2,0])square([cDia*6,cDia]);
    }
    }
}

}
    

    translate([0,scrwDst/2,1])cylinder(d=scrwD,h=20);
    translate([0,-scrwDst/2,1])cylinder(d=scrwD,h=20);
}
}
module bridge(){
    
xy=slotXY+wthick*2;
h=bH;

difference(){
hull(){
rcube([xy,xy,h],edgeR);
translate([0,strPosY,0])rcube([xy,pzDia+wthick*2,h],edgeR);
translate([0,strPosY,0])rcube([xy,pzDia+wthick*2,h],edgeR);
}
translate([0,0,h/2])rotate([-90,0,0])cylinder(d=m5Dia,h=xy);
translate([0,0,-5])rcube([slotXY+t,slotXY+t,h*2],0.1);
translate([xy/2+1,strPosY,h*0.92])rotate([0,-120,0])cylinder(d=strDia+0.3,h=xy*4,center=true);
translate([xy/2+5,strPosY,h*0.5])rotate([0,-90,0])cylinder(d=4.8,h=xy);
}

}

module piezoramp(){
piezodia=27.5;
plate_height=8;
screwdia=5.8;
screwsink=6;
ramp_balldia=16;
$fn=32;
piezosupport=0;
piezosink=pzSink;
screwsink=5;
width=10;
spread=10;

scale([1,1,1.1]){
translate([0,spread/2,-piezosink]){
difference(){
sphere(d=ramp_balldia);
translate([0,0,-ramp_balldia/2]){
cube([ramp_balldia*2,ramp_balldia*2,ramp_balldia],center=true);}
translate([ramp_balldia/2+width/2,0,0]){
cube([ramp_balldia,ramp_balldia,ramp_balldia],center=true);}
translate([-ramp_balldia/2-width/2,0,0]){
cube([ramp_balldia,ramp_balldia,ramp_balldia],center=true);}
}}
translate([0,-spread/2,-piezosink]){
difference(){
sphere(d=ramp_balldia);
translate([0,0,-ramp_balldia/2]){
cube([ramp_balldia*2,ramp_balldia*2,ramp_balldia],center=true);}
translate([ramp_balldia/2+width/2,0,0]){
cube([ramp_balldia,ramp_balldia,ramp_balldia],center=true);}
translate([-ramp_balldia/2-width/2,0,0]){
cube([ramp_balldia,ramp_balldia,ramp_balldia],center=true);}
}}
}
}

}