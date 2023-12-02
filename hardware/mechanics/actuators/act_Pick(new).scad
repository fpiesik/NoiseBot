include <../libs/rcube.scad>
include <../parameter.scad>

//moPick();

module moPick(){
    pick2();
    rotate([0,180,90])servoMnt();
}



module pick2(){
$fn=16;
outerdia=12;
innerdia=6;
height=5;
length=24;
thickness=1;
skrewdia=3.5;
skrewsupport=3;
cutradius=120;

rotate([0,180,0])
difference(){
union(){
cylinder(d=outerdia,h=height);
translate([-outerdia/2,0,0]){
cube([outerdia,length,height]);}
}
cylinder(d=innerdia,h=height-skrewsupport);
cylinder(d=skrewdia,h=height);
translate([cutradius/2+thickness/2,length,-0.5]){
cylinder(d=cutradius,h=height+1,$fn=64);}
translate([-cutradius/2-thickness/2,length,-0.5]){
cylinder(d=cutradius,h=height+1,$fn=64);}
}
}


module servoMnt(){
$fn=16;
//srvX=13;
//srvY=23;
//srvShftP=30;
//srvYO=0;
//srvYOff=2.5;
//scrSDst=2.5;
//cblX=4;
//cblY=1.5;
//scrDst=10;
    
nScr=2;
    
srvX=15;//slotXY; //has to be slot-wide to be directly mounted
srvY=52;//48;
srvShftP=30;
srvYO=0;
srvYOff=3;
scrSDst=0;
cblX=4;
cblY=1.5;

    
wthick=5;
srvSltD=2;

m3Dia=3.3;
m3NutDia=6.3;
m3NutH=2;
m4Dia=4.3;
m5Dia=5.3;

t=0;
edgeR=1.5;
  

z=10;//slotXY;
y=srvY+wthick+9;
yA=slotXY+wthick*2;
xA=slotXY+wthick*2;
xB=srvX+wthick*2;

    
difference(){
union(){
translate([0,yA/2-slotXY/2-wthick,0])rotate([0,0,0])rcube([xA,yA,z],edgeR);
translate([strPosX,y/2-slotXY/2-wthick,0])rotate([0,0,0])rcube([xB,y,z],edgeR);
}
translate([srvX/2,0,-z/2])rcube([slotXY+srvX,slotXY+t,z*2],0.1);  
translate([-slotXY/2,slotXY/2-0.1+t/2,-z/2])rcube([wthick*3,0.2,z*2],0.1);  
//translate([-(slotXY/2+wthick),slotXY*1.5+wthick,-z/2])rcube([slotXY*2,slotXY*2,z*2],edgeR);  
translate([strPosX,y/2-slotXY/2,-1])rcube([srvX+t,y,slotXY*3],0.1);
translate([strPosX-srvX/2+cblX/2,srvY,-1])rcube([cblX,srvY+cblY*2,slotXY*3],0.1);

//translate([strPosX+srvX/2-0.1/2,srvY,-1])rcube([0.1,srvY+cblY*2,slotXY*3],0.1);
 
translate([strPosX+(srvX/2+wthick),srvY-slotXY/2+srvYOff,z/2])rotate([0,-90,0])cylinder(d=m3Dia+t,h=xA);
translate([strPosX+(srvX/2+wthick+0.1),srvY-slotXY/2+srvYOff,z/2])rotate([0,-90,0])cylinder(d1=m3Dia*2,d2=m3Dia+t,h=2);
translate([strPosX+(srvX/2+wthick+0.1),srvY-slotXY/2+srvYOff,z/2])rotate([0,-90,0])cylinder(d=m3Dia+t,h=wthick);
translate([strPosX-(srvX/2+wthick)+m3NutH,srvY-slotXY/2+srvYOff,z/2])rotate([0,-90,0])cylinder(d=m3NutDia+t,h=xA,$fn=6);


    

  

translate([0,0,z/2])rotate([90,0,-90])cylinder(d=m5Dia,h=slotXY+wthick*3);
translate([0,0,z/2])rotate([90,0,-180])cylinder(d=m5Dia,h=slotXY+wthick*3);
}
}
