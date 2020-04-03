include <libs/rcube.scad>;
include <parameter.scad>;

pcbMntB();

module pcbMntB(){
srvX=20.5;
srvY=41;
srvYO=8;
wthick=5;
srvSltD=2;
cblX=5.5;
m3Dia=3;
m4Dia=4.3;
m5Dia=5.3;
scrSDst=4.5;
scrDst=10;
t=0.2;
sltPcbD=5;
  

mntZ=slotXY;
mntY=slotXY+wthick+sltPcbD;
mntX=slotXY+wthick*2;
    
pcbX=46.5;
pcbZ=54.75;
pcbY=5;

pcbMX=pcbX+wthick*2;
pcbMZ=pcbZ+wthick;
pcbMY=pcbY+2;

edgeR=3;

connZ=10;


difference(){
    union(){
    translate([mntX/2-slotXY/2-wthick,mntY/2+(sltPcbD-wthick)/2,mntZ/2])rotate([90,0,0])rcube([mntX,mntZ,mntY],edgeR);
    translate([pcbMX/2-slotXY/2-wthick,slotXY/2+pcbMY+sltPcbD,pcbMZ/2])rotate([90,0,0])rcube([pcbMX,pcbMZ,pcbMY],edgeR);
        }
    translate([mntX/2-slotXY/2-wthick,0,-1])rotate([0,0,0])rcube([slotXY+t,slotXY+t,mntZ*2],0.1);
    translate([pcbMX/2-slotXY/2-wthick,slotXY/2+pcbMY*2-pcbY+sltPcbD,pcbMZ/2])rotate([90,0,0])rcube([pcbX,pcbZ,pcbMY],0.1);
    translate([0,0,mntZ/2])rotate([90,0,0])cylinder(d=m5Dia,h=slotXY);
    translate([0,0,mntZ/2])rotate([0,90,0])cylinder(d=m5Dia,h=slotXY);
        }
}