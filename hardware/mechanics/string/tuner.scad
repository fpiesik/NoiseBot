include <../libs/rcube.scad>;
include <../parameter.scad>;

//tuner();

module tuner(){
  
$fn=32;
strDia=4.5; // strDia;
tDia=tuner_tDia;
bDi=tuner_bDi-0.6; //inner bearing dia
bDo=tuner_bDo;
zB=tuner_bZ;
leverZ=14;//tuner_leverZ;
zPos=tuner_zPos;
leverY=tuner_leverY;
wthick=slotWthick;
xA=22;
y=slotXY+wthick*2;
scrwDia=4.6;
nutDia=8;
nutZ=3.6;
sltAxDst=25; 
t=0.2;
tB=2; //Distance between wheel and top/bottom
edgeR=3;
railSink=12;
railDia=12;

topH=6;
//adjust theese settings to add a nut-screw to tune the string
btmH=6;
nutScrewDia=0;//5.5;

z=tDia+tB*2+topH+btmH;

printSp=0.3;

translate([0,0,-z/2+btmH+tB]){
wheel();

    difference(){
        t=0.2;
        union(){
        translate([0,0,-btmH-tB])rcube([slotXY+wthick*2,slotXY+wthick*2,tDia+tB*2+topH+btmH],edgeR);
        translate([0,-slotXY,-btmH-tB])rcube([slotXY+wthick*2,slotXY+wthick*2,tDia+tB*2++topH+btmH],edgeR);
        translate([-slotXY,0,tDia+tB])rcube([slotXY+wthick*4,slotXY+wthick*2,topH],edgeR); 
        translate([-slotXY/2+slotXY/4-slotXY-wthick*1.5,-slotXY+wthick,tDia+tB-topH])rcube([slotXY/2+wthick,
					slotXY+wthick,+topH*2],edgeR);
        hull(){
        translate([-slotXY,0,tDia+tB-topH])rcube([slotXY+wthick*4,slotXY+wthick*2,topH],edgeR);  
        translate([-slotXY/2,0,-tB-btmH])rcube([wthick,slotXY+wthick*2,topH],edgeR);  
        } 
          
        }
        translate([0,0,-tB-btmH-1])rcube([slotXY+t,slotXY+t,tDia*2],0.1);
        translate([0,-slotXY,-tB])rcube([slotXY*2,zB+t*2,tDia+tB*2],0.1);
        translate([-slotXY/2+slotXY/4-slotXY-wthick*1.5,strPosY,0])cylinder(d=scrwDia,h=tDia*2);

        translate([0,0,tDia/2])rotate([90,0,0])cylinder(d=bDi,h=slotXY*3);
        
        translate([0,0,tDia/2])rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY*3);
        //translate([0,0,0])rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY*3);
        }
    }

module wheel(){
translate([0,-slotXY-zB/2,tDia/2])rotate([-90,-90,0]){
difference(){
union(){
cylinder(d=tDia,h=zB);
hull(){
cylinder(d=leverZ,h=zB);
translate([0,-leverY,0])cylinder(d=leverZ,h=zB);
}
}
translate([0,0,zB/2]){
rotate_extrude(convexity = 10)
translate([tDia/2, 0, 0])
circle(d = strDia, $fn = 100);
}
translate([leverZ/2,-tDia/2-strDia/2+-1,zB/2])scale([0.5,1,1])rotate([90,0,0])cylinder(d=zB-2,h=100,$fn=16);
translate([0,0,1])cylinder(d=bDo,h=zB);
translate([0,0,0])cylinder(d=bDo-2,h=zB);
//translate([0,0,(slotZ/2+slotXY/2)-70])rotate([0,90,0])2020Profile(slotX-slotXY*2);
}
}
}
}