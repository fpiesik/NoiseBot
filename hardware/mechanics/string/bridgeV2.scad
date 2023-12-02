include <../libs/rcube.scad>;
include <../parameter.scad>;
include <string.scad>;

//bridge();
//translate([0,0,-20])string();
//piezoramp();

module bridge(){
edgeR=3;
wthick=slotWthick;
pzDia=12.3;
pzSink=2;
pzThick=0.6;

dampDiaO=pzDia+3;
dampDiaI=5.4;
cblDia=3.5;
cbleZOff=-15;
  
pcbX=4;
pcbY=17.3;
pcbZ=27;

bH=22;    
xy=slotXY+wthick*2;
hA=pzDia+wthick+2;
hB=22;  
h=hA+hB;
t=0.1;
$fn=32;


difference(){
  union(){
    translate([0,0,-hA/2])piezo();
    translate([0,0,-hA/2-hB])strFix();
  }
translate([xy/2+0.01,strPosY+dampDiaO/2.5,cbleZOff])rotate([0,-90,0])cylinder(d=cblDia,h=xy+1);
 translate([0,0,hA/2-h/2])rotate([0,-90,0])cylinder(d=m5Dia,h=xy);
}
  
  
module piezo(){
difference(){
hull(){
rcube([xy,xy,hA],edgeR);
translate([0,strPosY,0])rcube([xy,pzDia+wthick*2,hA],edgeR);
}
//translate([-xy/2,strPosY+5,h/2-pcbZ+pzDia/2])rcube([pcbX,pcbY,pcbZ],0.1);
//translate([-xy/2,strPosY+5,h/2-pcbZ+pzDia/2-2])rcube([pcbX,4,pcbZ],0.1);
translate([0,0,-5])rcube([slotXY+t,slotXY+t,hA*2],0.1);

//translate([xy/2+0.01,strPosY,h/2])rotate([0,-90,0])cylinder(d1=pzDia,d2=dampDiaO,h=pzSink);
translate([xy/2+0.01,strPosY,hA/2])rotate([0,-90,0])cylinder(d=dampDiaO,h=xy-10);
translate([xy/2+0.01,strPosY,hA/2])rotate([0,-90,0])cylinder(d=dampDiaI,h=xy+1);
}

difference(){
  translate([xy/2+0.01,strPosY,hA/2])rotate([0,-90,0])cylinder(d=dampDiaO-0.5,h=xy-15.1);
  translate([xy/2+0.02,strPosY,hA/2])rotate([0,-90,0])cylinder(d=pzDia+0.66,h=pzSink);
}


translate([0,0,0])difference(){
    intersection(){
        translate([xy/2+0.02,strPosY,hA/2])rotate([0,90,0])cylinder(d=pzDia,h=pzSink+5);
        translate([xy/2+0.02,strPosY,hA/2])rotate([90,0,0])cylinder(d=pzDia,h=pzDia,center=true);
}
hull(){
translate([xy/2,strPosY+pzDia/2,hA/2])rotate([90,0,0])cylinder(d=cblDia,h=pzDia,center=true);
translate([xy/2+cblDia/2,strPosY+pzDia/2,hA/2])rotate([90,0,0])cylinder(d=cblDia,h=pzDia,center=true);
translate([xy/2+4,strPosY+pzDia/2,hA/2])rotate([90,0,-50])cylinder(d=cblDia,h=pzDia,center=true);
}
translate([xy/2+1.5,strPosY+pzDia/2,hA/2])rotate([0,90,0])cylinder(d=cblDia,h=pzDia,center=true);
}

}


module strFix(){
    
xy=slotXY+wthick*2;
h=hB;

difference(){
hull(){
rcube([xy,xy,h],edgeR);
translate([0,strPosY,0])rcube([xy,pzDia+wthick*2,h],edgeR);
translate([0,strPosY,0])rcube([xy,pzDia+wthick*2,h],edgeR);
}
translate([0,0,-5])rcube([slotXY+t,slotXY+t,h*2],0.1);
translate([xy/2+1,strPosY,h*0.92])rotate([0,-120,0])cylinder(d=strDia+0.3,h=xy*4,center=true);
translate([xy/2+5,strPosY,h*0.5])rotate([0,-90,0])cylinder(d=4.6,h=xy);
}

}
}

module piezoramp(){
piezodia=27.5;
plate_height=8;
screwsink=6;
ramp_balldia=16;
$fn=32;
piezosupport=0;
piezosink=pzSink;
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