module pick(){
scrDst=6;
scrDia=2.5;
strDst=12;
adjDst=3;
h=5;

difference(){
hull(){
translate([strPosX-strDst-adjDst/2,0,0])cylinder(d=scrDia*2.5,h=h);
translate([strPosX-strDst+scrDst+adjDst/2,0,0])cylinder(d=scrDia*2.5,h=h);
translate([strPosX,0,0])cylinder(d=1,h=h);
}    
hull(){
translate([strPosX-strDst-adjDst/2,0,-1])cylinder(d=scrDia,h=h+2);
translate([strPosX-strDst+scrDst+adjDst/2,0,-1])cylinder(d=scrDia,h=h+2);

}    
}
}

module servoMnt(){

srvX=13;
srvY=23;
srvShftP=30;
srvYO=0;
srvYOff=2.5;
scrSDst=2.5;
cblX=4;
cblY=1.5;
scrDst=10;
    
nScr=2;
    
//srvX=20;
//srvY=41;
//srvShftP=30;
//srvYO=0;
//scrSDst=4;
//cblX=4;
//cblY=1.5;
//scrDst=10;
    
wthick=4;
srvSltD=2;

m3Dia=3;
m4Dia=4.3;
m5Dia=5.3;

t=0.2;
edgeR=3;
  

z=slotXY*2/3;
y=srvY+wthick*2+scrSDst*2;
yA=slotXY+wthick*2;
xA=slotXY+wthick*2;
xB=slotXY+wthick*2+srvX+srvYO*2;

    
difference(){
union(){
translate([0,yA/2-slotXY/2-wthick,0])rotate([0,0,0])rcube([xA,yA,z],edgeR);
translate([xB/2-wthick,y/2-slotXY/2-wthick-scrSDst+srvYOff,0])rotate([0,0,0])rcube([xA,y,z],edgeR);
}
translate([0,0,-z/2])rcube([slotXY+t,slotXY+t,z*2],0.1);  
//translate([-(slotXY/2+wthick),slotXY*1.5+wthick,-z/2])rcube([slotXY*2,slotXY*2,z*2],edgeR);  
translate([strPosX,srvY/2-slotXY/2+srvYOff,-1])rcube([srvX+t,srvY+t,slotXY*3],0.1);
translate([strPosX,srvY/2-slotXY/2+srvYOff,-1])rcube([cblX,srvY+cblY*2,slotXY*3],0.1);

if(nScr==2){
    translate([strPosX,srvY-slotXY/2+scrSDst+srvYOff,z])rotate([0,0,0])cylinder(d=m3Dia,h=slotXY+wthick*30, center=true);
    translate([strPosX,-slotXY/2-scrSDst+srvYOff,z])rotate([0,0,0])cylinder(d=m3Dia,h=slotXY+wthick*30, center=true);
}

if(nScr==4){
translate([strPosX-scrDst/2,y/2-slotXY/2+srvY/2-scrSDst+srvYOff,z])rotate([0,0,0])cylinder(d=m3Dia,h=slotXY+wthick*30, center=true);
translate([strPosX-scrDst/2+scrDst,y/2-slotXY/2+srvY/2-scrSDst+srvYOff,z])rotate([0,0,0])cylinder(d=m3Dia,h=slotXY+wthick*30, center=true);
translate([strPosX-scrDst/2+scrDst,-slotXY/2-scrSDst+srvYOff,z])rotate([0,0,0])cylinder(d=m3Dia,h=slotXY+wthick*30, center=true);
translate([strPosX-scrDst/2,-slotXY/2-scrSDst+srvYOff,z])rotate([0,0,0])cylinder(d=m3Dia,h=slotXY+wthick*30, center=true);
}

    
translate([slotXY/2+scrDst+(srvX-scrDst)/2,0,z/2+(srvY/2+scrSDst)])rotate([90,0,0])cylinder(d=m3Dia,h=slotXY+wthick*3, center=true); 
translate([slotXY/2+(srvX-scrDst)/2,0,z/2-(srvY/2+scrSDst)])rotate([90,0,0])cylinder(d=m3Dia,h=slotXY+wthick*3, center=true);
translate([slotXY/2+scrDst+(srvX-scrDst)/2,0,z/2-(srvY/2+scrSDst)])rotate([90,0,0])cylinder(d=m3Dia,h=slotXY+wthick*3, center=true);
  

translate([0,0,z/2])rotate([90,0,-90])cylinder(d=m5Dia,h=slotXY+wthick*3);
}
}
