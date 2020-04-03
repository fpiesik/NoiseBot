include <libs/rcube.scad>;
include <parameter.scad>;

pcbX=mnt_pcbA_X;
pcbY=8;
pcbZ=mnt_pcbA_Y;
pcbZu=4;

wtPcb=4;
wtSlot=4;

z=pcbZ+wtPcb*2;
x=pcbX+wtSlot*2;

btmTh=2;

//base();
lid();

module base(){

difference(){
union(){
difference(){
translate([0,pcbY/2-wtSlot/2,0])rcube([x,pcbY+wtSlot,z],0.1);
translate([0,pcbY/2+wtSlot/2,wtPcb])rcube([pcbX,pcbY+wtSlot,pcbZ],0.1);
}

translate([pcbX/2-slotXY/2,-1,wtPcb+slotXY/2])rotate([-90,0,0])cylinder(d=slotXY,h=pcbZu+1);
translate([-(pcbX/2-slotXY/2),-1,wtPcb+slotXY/2])rotate([-90,0,0])cylinder(d=slotXY,h=pcbZu+1);
translate([pcbX/2-slotXY/2,-1,wtPcb-slotXY/2+pcbZ])rotate([-90,0,0])cylinder(d=slotXY,h=pcbZu+1);
translate([-(pcbX/2-slotXY/2),-1,wtPcb-slotXY/2+pcbZ])rotate([-90,0,0])cylinder(d=slotXY,h=pcbZu+1);
}

translate([pcbX/2-slotXY/2,0,wtPcb+slotXY/2])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);
translate([-(pcbX/2-slotXY/2),0,wtPcb+slotXY/2])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);
translate([pcbX/2-slotXY/2,0,wtPcb-slotXY/2+pcbZ])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);
translate([-(pcbX/2-slotXY/2),0,wtPcb-slotXY/2+pcbZ])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);

translate([pcbX/2-slotXY/2,-wtSlot,wtPcb+slotXY/2])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=6);
translate([-(pcbX/2-slotXY/2),-wtSlot,wtPcb+slotXY/2])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=6);
translate([pcbX/2-slotXY/2,-wtSlot,wtPcb-slotXY/2+pcbZ])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=6);
translate([-(pcbX/2-slotXY/2),-wtSlot,wtPcb-slotXY/2+pcbZ])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=6);
}

for (i = [0 : nStr-1]) {
translate([-x/2+slotXY/2+wtSlot+i*x/2-i*(slotXY+wtSlot*2)/2,0,0])difference(){
    
translate([0,-(slotXY+wtSlot)/2,0])rcube([slotXY+wtSlot*2,slotXY+wtSlot,z],1);

translate([0,-(slotXY+wtSlot*2)/2,-1])rcube([slotXY,slotXY+wtSlot*2,pcbZ+wtSlot*2+2],0.01);

translate([0,-(slotXY+wtSlot*2)/2,z*5/6])rotate([0,90,0])cylinder(d=m5Dia,h=slotXY*2,center=true);
translate([0,-(slotXY+wtSlot*2)/2,z*1/6])rotate([0,90,0])cylinder(d=m5Dia,h=slotXY*2,center=true);
    
//translate([slotXY/2+wthick,-(slotXY+wthick*2)/2,z*1/6])rotate([0,90,0])cylinder(d=m5HeadD,h=slotXY);
//translate([-(slotXY/2+wthick),-(slotXY+wthick*2)/2,z*1/6])rotate([0,-90,0])cylinder(d=m5HeadD,h=slotXY);
//    
//translate([slotXY/2+wthick,-(slotXY+wthick*2)/2,z*5/6])rotate([0,90,0])cylinder(d=m5HeadD,h=slotXY);
//translate([-(slotXY/2+wthick),-(slotXY+wthick*2)/2,z*5/6])rotate([0,-90,0])cylinder(d=m5HeadD,h=slotXY);
}
}
}

module lid(){
    pcbY=25;
    topTh=2.5;
    screwSockZ=4;
    sizeExtra=4;
    
difference(){
union(){
    difference(){
    translate([0,pcbY/2-topTh/2,0])rcube([x,pcbY+topTh,z],0.1);
    translate([0,pcbY/2+topTh/2,wtPcb-sizeExtra/2])rcube([pcbX+sizeExtra,pcbY+wtSlot,pcbZ+sizeExtra],0.1);
    }

    translate([pcbX/2-slotXY/2,-1,wtPcb+slotXY/2])rotate([-90,0,0])cylinder(d=slotXY,h=screwSockZ);
    translate([-(pcbX/2-slotXY/2),-1,wtPcb+slotXY/2])rotate([-90,0,0])cylinder(d=slotXY,h=screwSockZ);
    translate([pcbX/2-slotXY/2,-1,wtPcb-slotXY/2+pcbZ])rotate([-90,0,0])cylinder(d=slotXY,h=screwSockZ);
    translate([-(pcbX/2-slotXY/2),-1,wtPcb-slotXY/2+pcbZ])rotate([-90,0,0])cylinder(d=slotXY,h=screwSockZ);
    }

translate([pcbX/2-slotXY/2,0,wtPcb+slotXY/2])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);
translate([-(pcbX/2-slotXY/2),0,wtPcb+slotXY/2])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);
translate([pcbX/2-slotXY/2,0,wtPcb-slotXY/2+pcbZ])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);
translate([-(pcbX/2-slotXY/2),0,wtPcb-slotXY/2+pcbZ])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);

translate([pcbX/2-slotXY/2,-wtSlot,wtPcb+slotXY/2])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=16);
translate([-(pcbX/2-slotXY/2),-wtSlot,wtPcb+slotXY/2])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=16);
translate([pcbX/2-slotXY/2,-wtSlot,wtPcb-slotXY/2+pcbZ])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=16);
translate([-(pcbX/2-slotXY/2),-wtSlot,wtPcb-slotXY/2+pcbZ])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=16);
    
    translate([0,pcbY+topTh/2,-1])rcube([40,pcbY+wtSlot,pcbZ*2],0.1);
        translate([pcbX/2,pcbY+topTh/2,56-10])rcube([pcbX,pcbY+wtSlot,20],0.1);
}
}