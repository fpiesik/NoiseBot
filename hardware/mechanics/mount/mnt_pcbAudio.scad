include <libs/rcube.scad>;
include <parameter.scad>;

pcbX=mnt_pcbA_X;
pcbY=8;
pcbZ=40;
pcbZu=4;

wtPcb=4;
wtSlot=4;

z=pcbZ+wtPcb*2;
x=pcbX+wtSlot*2;

btmTh=2;




difference(){
union(){
difference(){
translate([0,pcbY/2-wtSlot/2,0])rcube([x,pcbY+wtSlot,z],0.1);
translate([0,pcbY/2+wtSlot/2,wtPcb])rcube([pcbX,pcbY+wtSlot,pcbZ],0.1);
}

translate([pcbX/2-slotXY/2,-1,z/2])rotate([-90,0,0])cylinder(d=slotXY,h=pcbZu+1);
translate([-(pcbX/2-slotXY/2),-1,z/2])rotate([-90,0,0])cylinder(d=slotXY,h=pcbZu+1);

}

translate([pcbX/2-slotXY/2,0,z/2])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);
translate([-(pcbX/2-slotXY/2),0,z/2])rotate([-90,0,0])cylinder(d=m4Dia,h=pcbZu+btmTh);


translate([-(pcbX/2-slotXY/2),-wtSlot,z/2])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=6);
translate([pcbX/2-slotXY/2,-wtSlot,z/2])rotate([-90,30,0])cylinder(d=m4NutD,h=wtSlot,$fn=6);

}

for (i = [0 : nStr-1]) {
translate([-x/2+slotXY/2+wtSlot+i*x/2-i*(slotXY+wtSlot*2)/2,0,0])difference(){
    
translate([0,-(slotXY+wtSlot)/2,0])rcube([slotXY+wtSlot*2,slotXY+wtSlot,z],1);

translate([0,-(slotXY+wtSlot*2)/2,-1])rcube([slotXY,slotXY+wtSlot*2,pcbZ+wtSlot*2+2],0.01);

translate([0,-(slotXY+wtSlot*2)/2,z/2])rotate([0,90,0])cylinder(d=m5Dia,h=slotXY*2,center=true);
}
}