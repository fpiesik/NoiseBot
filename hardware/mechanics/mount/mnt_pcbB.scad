include <libs/rcube.scad>;
include <parameter.scad>;

pcbMntB();

module pcbMntB(){

wthick=2.5;
cblX=5.5;
m3Dia=3;
m4Dia=4.3;
m5Dia=5.3;
scrSDst=4.5;
scrDst=10;
t=0.2;
sltPcbD=6; //distance between mount and pcb
  

mntZ=slotXY;
mntY=slotXY+sltPcbD;
mntX=slotXY+wthick*2;
    
pcbX=49.5;
pcbZ=93.5;
pcbY=4;

pcbMX=pcbX+wthick*2;
pcbMZ=pcbZ+wthick*2;
pcbMY=pcbY+2;
pcbXOff=-(pcbMX/2-slotXY/2-wthick);

edgeR=1;

zipZ=8;
zipY=3;

connZ=10;


difference(){
    union(){
    translate([0,mntY/2+(sltPcbD)/2,pcbMZ/2])rotate([90,0,0])rcube([mntX,pcbMZ,mntY],edgeR);
    translate([pcbXOff,slotXY/2+sltPcbD+pcbMY,pcbMZ/2])rotate([90,0,0])rcube([pcbMX,pcbMZ,pcbMY],edgeR);
        }
    translate([mntX/2-slotXY/2-wthick,0,-1])rotate([0,0,0])rcube([slotXY+t,slotXY+t,pcbMZ*2],0.1);
    translate([pcbXOff,slotXY/2+pcbMY*2-pcbY+sltPcbD,pcbMZ/2])rotate([90,0,0])rcube([pcbX,pcbZ,pcbMY],0.1);
    translate([0,0,pcbMZ/2])rotate([0,90,0])cylinder(d=m5Dia,h=mntX+1,center=true);
    translate([0,slotXY/2+sltPcbD-zipY/2,pcbMZ/2])cube([pcbMX+2,zipY,zipZ],center=true);
        }
}