module jackMnt(){
wthick=3.5;
edgeR=3;
jackX=17.5;
jackDia=9.5;
t=0.2;
    
mntZ=slotXY;
mntY=slotXY+wthick*2;
mntX=slotXY+wthick*2;
    
difference(){
    union(){
    translate([0,0,0])rcube([mntX,mntY,mntZ],edgeR);
    translate([-mntX/2-jackX/2+wthick,slotXY/2+wthick/2,0])rcube([jackX+wthick*2,wthick,slotXY],edgeR/2);
        }
    translate([-(mntX/2+jackX/2),0,mntZ/2])rotate([-90,0,0])cylinder(d=jackDia,h=mntY);
    translate([0,0,mntZ/2])rotate([90,0,0])cylinder(d=m5Dia,h=mntY);
    translate([0,0,-1])rcube([slotXY+t,slotXY+t,mntZ+2],0.1);
    
    }
}