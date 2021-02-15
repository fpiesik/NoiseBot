include <libs/rcube.scad>;
include <parameter.scad>;

//mnt();
//prop();

module rotor(){
mnt();
    }

module mnt(){
adj=15;
wthick=3;
wthickX=3;
t=1;

edgeR=1.5;

x= slotXY+wthickX+adj;
y= slotXY*2+wthick*2;
z=13;

mDia=9;
mPosX=x/2-mDia/2+adj/2-wthickX/2-2;
mPosY=-y/2-slotXY/2+mDia/2+wthick;
mMntC=2;

thrdDia=2.7;
thrdPosY=-slotXY/2-thrdDia/2-wthick-1;

scrwSink=2.5;

difference(){
    translate([adj/2-wthickX/2,-y/2+wthick+slotXY/2,0])rcube([x,y,z],edgeR,$fn=16);
    translate([slotXY/2+adj/2,-t/2,-1])rcube([slotXY*2+adj,slotXY+t,z*2],0.1);
    translate([slotXY+adj-2+m5Dia/2+wthick,slotXY/2,-1])rcube([slotXY*2,slotXY,z*2],0.1);
    translate([((slotXY/2+mPosX-mDia/2-2)-slotXY)/2,-slotXY/2,-1])rcube([slotXY/2+mPosX-mDia/2-2,slotXY*2,z*2],0.1);
    hull(){
        translate([adj-wthick,0,z/2])rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY);
        translate([0,0,z/2])rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY);
    }
    translate([mPosX,mPosY,0])cylinder(d=mDia,h=z*3,center=true);
    translate([mPosX,-slotXY+mDia/2,0])cube([mMntC,slotXY,z*3],center=true);
    translate([mPosX,thrdPosY,z/2])rotate([0,90,0])cylinder(d=thrdDia,h=x/2,$fn=16,center=true);
    
    translate([mPosX,thrdPosY,z/2])rotate([0,90,0])cylinder(d=m3Dia,h=x,$fn=16);
    translate([adj/2-wthickX/2+x/2-scrwSink+0.1,thrdPosY,z/2])rotate([0,90,0])cylinder(d1=m3Dia,d2=m3NutD,h=scrwSink,$fn=16);
    

}

}

module prop(){
$fn=16;
dO=4;
dI=1.2;
h=5;
t=1.5;
b=9;
cB=1.5;
cH=3.5;
wthick=1;
    
difference(){
union(){
cylinder(d=dO,h=h);
translate([0,0,h/2])cube([b,t,h],center=true);
}
translate([0,0,-1])cylinder(d=dI,h=h);
translate([b/2-cB/2-wthick,0,h/2])cube([cB,t*2,cH],center=true);
translate([-(b/2-cB/2-wthick),0,h/2])cube([cB,t*2,cH],center=true);
}

}
