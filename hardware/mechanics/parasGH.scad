include <libs/T-Slot.scad>
use <libs/Nema17.scad>
include <libs/gearRack.scad>
include <libs/linearBearing.scad>

strScale=650;
strDia=3;
strPosX=20;
strPosY=-20;
slotXY=20;

nema17_height=40;
nema17_width=42;
nema17_shftDia=5;
nema17_shftLen=28;
nema17_holeDist=31;
Nema17_gearDia=23;

tuner_bDi=7.8;
tuner_bDo=22.2;
tuner_bZ=10;
tuner_rThick=5;
//tuner_tDia=strPosX*2; (big)
tuner_tDia=strPosX*2-10;
tuner_leverZ=10;
tuner_zPos=225;
tuner_strDia=strDia[0];
tuner_leverY=35;

//----------Kickup----------------------------------------------------

//for Bass
//kickup_baseX=22;
//kickup_baseY=15;
//kickup_zAdjDia=3.3;
//kickup_zAdjL=10;
//kickup_zAdjDist=13;
//kickup_zAdjOff=4;

//for Alt
kickup_baseX=20;
kickup_baseY=13;
kickup_zAdjDia=3.3;
kickup_zAdjL=10;
kickup_zAdjDist=10.5;
kickup_zAdjOff=4;
//------------------------------------------------------------------------

slide_cpDst=1.5;
slide_rackPosX=(55-12.5);

m3NutD=6.6;
m4Dia=4.3;
m4NutD=8.3;
m5Dia=5.3;

edgeR=3;

gearXPos=57;
gearYPos=0;
gearZPos=360;

rackScrD=20;
rack_X=13;
rack_Y=15.5;
rack_extOffX=0;

bearGearD=25;
mntGrD=20.5; //mount gear distance



//translate([-nema17_height-slotXY/2-8,-(-nema17_width/2-slotXY/2)-(nema17_width-Nema17_gearDia)/2,900])rotate([90,0,90])Nema17(MotorHeight=nema17_height,MotorWidth=nema17_width,ShaftDiameter=nema17_shftDia,ShaftLength=nema17_shftLen,FixingHolesInteraxis=nema17_holeDist);

translate([0,0,500])rotate([0,0,0])2020Profile(1000);

//translate([0,0,300])rotate([0,0,0])slide();
//
!kickup(1);
//stpprMnt();
//
//translate([gearXPos-10.5,0,596.5])rotate([180,0,-90])gearRack(1);
//translate([gearXPos,0,gearZPos])rotate([0,0,-90])gearRack(2);
//translate([slide_rackPosX,0,300])rackExt();
////
string();
//
//translate([0,0,400])tuner();
//
translate([0,0,60])rotate([0,0,0])bridge();
//translate([8,-slotXY,30])rotate([0,0,90])piezoPickup(1);
//
//translate([-39,strPosY,120])rotate([0,90,0])kickup(1);
//translate([0,0,120])kickupMnt();
//
//translate([0,0,200])servoMnt();
//translate([0,0,200])teensyMnt();
//translate([0,0,200])jackMnt();
//translate([0,0,200])stopMnt();
//translate([0,strPosY,200])pick();

//translate([0,0,50])moFret();
//translate([0,0,0])pcbMntB();

//translate([0,0,100])nut();


module rackExt(){
extL=62;
extOffX=2;
difference(){
translate([extOffX+0,0,0])rcube([17,slotXY+slide_cpDst*2,extL],1.5);
translate([extOffX-2,0,-1])rcube([rack_X+4,rack_Y,extL+2],0.1);
translate([0,0,m4Dia/2+wthick])rotate([90,0,0])cylinder(d=m4Dia,h=slotXY+slide_cpDst*3,center=true);
translate([0,0,extL-m4Dia/2-wthick*2])rotate([90,0,0])cylinder(d=m4Dia,h=slotXY+slide_cpDst*3,center=true);
}
}

module nut(){
shftDia=6.3;
nutDia=11.5;
nutZ=2.5;
wthick=4;
edgeR=3;
adjDist=4;

x=slotXY+wthick*2;
yA=slotXY+wthick*2;
yB=-strPosY+wthick/2+adjDist; 
z=nutDia+1.5;

difference(){
union(){
translate([0,0,0])rcube([x,yA,z],edgeR);
translate([0,-yB/2,0])rcube([x,yB,z],edgeR);
}
hull(){
translate([0,strPosY+shftDia/1.7-adjDist/2,z/2])rotate([0,90,0])cylinder(d=shftDia,h=x*2,center=true);
translate([0,strPosY+shftDia/1.7+adjDist/2,z/2])rotate([0,90,0])cylinder(d=shftDia,h=x*2,center=true);
}
hull(){
translate([x/2-nutZ,strPosY+shftDia/1.7-adjDist/2,z/2])rotate([30,0,0])rotate([0,90,0])cylinder(d=nutDia,h=x*2,$fn=6);
translate([x/2-nutZ,strPosY+shftDia/1.7+adjDist/2,z/2])rotate([30,0,0])rotate([0,90,0])cylinder(d=nutDia,h=x*2,$fn=6);
}
translate([0,0,-1])rcube([slotXY,slotXY,z+2],0.1);
translate([0,0,z/2])rotate([0,-90,0])cylinder(d=m5Dia,h=x*2);
}
}

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


module moFret(){
    y=13;
    bH=3.5; //mount thickness
    sShftHA=8;
    sShftW=22.8; //servo width without mount
    sMntW=4;
    sHA=20;
    sD=13;
    sW=31.5;
    sBtm=2; //distance of the servo from the mount
    sScrDia=3;
    sScrDist=28;
    mScrDia=4.3;
    smSDia=1.4; //diameter of the screws to mount the servoMounts to the main mount
    smSDist=7;
    holeX=7.5;
    holeY=7;
    fDia=3;
    fSY=0.9;
    slotX=slotXY;
    
    wthick=4;
    
    hookH=5;
    hookD=3;
    hookLA=0.5;
    hookLB=22;
    hookScrD=1.8;
    hookDeep=7;
    


    difference(){
    translate([13.25,strPosY,0])rotate([-90,0,90])all();
    translate([0,0,-y])rcube([slotXY,slotXY,y*2],0.01);
    rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY+wthick);
    rotate([0,-90,0])cylinder(d=m5Dia,h=slotXY+wthick);
    translate([-slotXY/2-wthick,0,0])rotate([0,-90,0])cylinder(d=m5Dia*2,h=slotXY+wthick);
        }
    
    module all(){
        translate([0,0,-bH]){
            //servo();
            servoMnt();
            //rotate([0,0,0])hook();
        }
    
    
    
  
}

    module servoMnt(){
        translate([-sShftHA/2-holeX/2,0,0])difference(){
            union(){
            translate([0,0,bH])rcube([sShftHA,y,sW+sBtm],0.01);
            translate([-strPosY/2+sShftHA/4+(wthick+slotXY/2)/2,y/2,(sW+sBtm)/2+bH])rotate([90,0,0])rcube([sShftHA+sShftHA/2-strPosY+wthick+slotXY/2,sW+sBtm+bH*2,y],1);
                }
            translate([-(-sShftHA/2-holeX/2)+(-strPosY-slotXY/2)/2,0,bH])rcube([(-strPosY-slotXY/2),y+1,sW+sBtm-(sW-sShftW)/2],0.1);
            translate([sShftHA,0,bH])rcube([sShftHA,y+1,sW+sBtm-(sW-sShftW)/2],0.1);
            
            translate([-(-sShftHA/2-holeX/2),0,0])rcube([holeX,holeY,bH],0.01);
                
            translate([-(-sShftHA/2-holeX/2),y/2-fDia/2,0])rcube([holeX*1,fSY,bH],0.1);
                
            translate([0,0,bH+sMntW+sBtm])rcube([sShftHA,sD+1,sShftW],0.01);
                
            translate([-sShftHA,0,bH+sMntW+sBtm+sShftW/2-sScrDist/2])rotate([0,90,0])cylinder(d=sScrDia,h=sShftHA*2,$fn=12);
            translate([-sShftHA,0,bH+sMntW+sBtm+sShftW/2+sScrDist/2])rotate([0,90,0])cylinder(d=sScrDia,h=sShftHA*2,$fn=12);

        
    } 
}
    module servo(){    
   translate([-sHA/2-sShftHA-holeX/2,0,bH+sMntW+sBtm])rcube([sHA,sD,sShftW],0.01);
   }
   
    module hook(){ 
    translate([0,-hookH/2,0])rotate([0,90,90]){
     difference(){
      hull(){
       translate([-(hookLB+hookScrD+2),0,0])cylinder(d=holeX,h=hookH,$fn=16); 
       translate([hookLA,0,0])cylinder(d=holeX,h=hookH);  
      }
      hull(){
       translate([-(hookLB+holeX),0,0])cylinder(d=hookD,h=hookH,$fn=12); 
       translate([hookLA,0,0])cylinder(d=hookD,h=hookH,$fn=12);  
      }
       hull(){
       translate([-((hookLB+holeX)-hookD/2),hookD,0])rotate([0,0,45])cylinder(d=hookD*2,h=hookH,$fn=4); 
       translate([hookLA-hookD/2-hookDeep,hookD,0])rotate([0,0,45])cylinder(d=hookD*2,h=hookH,$fn=4);  
      }
      translate([-hookLB-holeX/2-hookScrD/1.2,-hookD,0])rotate([0,0,45])cylinder(d=holeX,h=hookH,$fn=4);
      translate([-hookLB,0,hookH/2])rotate([90,0,0])cylinder(d=hookScrD,h=holeX,$fn=12); 
     }
    } 
}
    module stable(){
        servoWidth=10.2;
        depth=5;
        spY=3;
        z=5;
        
        difference(){
            translate([0,0,(depth+spY)/2-depth/2])cube([93,z,depth+spY],center=true);
            for (n=[0:2]){
                translate([strPos[n]-10,0,0]){
                cube([servoWidth,z+1,depth],center=true);
                    //servoMnt(); 
                }
            }
        }
    }

}

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

module stopMnt(){
wthick=2.5;
edgeR=2;
jackX=17.5;
jackDia=9.5;
t=0.2;
    
mntZ=13;
mntY=slotXY+wthick;
mntX=slotXY+wthick*2;

difference(){
    union(){
    translate([0,0,0])rcube([mntX,mntY,mntZ],edgeR);
        }
    translate([0,0,mntZ/2])rotate([90,0,0])cylinder(d=m5Dia,h=mntY);
    translate([0,wthick*1.5,-1])rcube([slotXY,slotXY+wthick*2,mntZ+2],0.1);
    
    }
}

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

module teensyMnt(){
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
    
pcbX=36.3;
pcbZ=37.5;
pcbY=9;

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
    translate([pcbMX/2-slotXY/2-wthick+pcbX/2-connZ/2,slotXY/2+pcbMY*2-pcbY+sltPcbD,pcbMZ/2])rotate([90,0,0])rcube([connZ,pcbZ*2,pcbMY],0.1);
    translate([0,0,mntZ/2])rotate([90,0,0])cylinder(d=m5Dia,h=slotXY);
    translate([0,0,mntZ/2])rotate([0,90,0])cylinder(d=m5Dia,h=slotXY);
        }
    
    
        

}

module kickup(orientation){

hub=4;

top=4;

magdia=5.7;
magZ=20;
magnutdia=9.5;
magnutZ=4;
magthreadZ=magnutZ*2;

bottom=magZ-hub+1+magthreadZ;

zAdjDia=kickup_zAdjDia;
zAdjL=kickup_zAdjL;
zAdjDist=kickup_zAdjDist;
zAdjOff=kickup_zAdjOff;

coildia=14;
upperidlerZ=2;
loweridlerZ=2;
threaddepth=4;
coilZ=18; //magZ-bottom+threaddepth;
echo(coilZ);
magholedia=magdia;
wallthick=1;
coilthreaddia=4.9;

rampZ=3;
rampdia=coildia;


innerX=15;
innerY=16;
innerZ=coilZ+hub;

baseX=kickup_baseX;
baseY=kickup_baseY;
baseZ=innerZ+bottom+top;
echo(baseZ);


jackX=6.5;
jackY=3.5;
jackZ=10;
jacksupport=2;
jackpindia=1.5;
jackpindist=2.54;
jackpinsupport=1.5;

mountsupportY=2;

$fn=32;

solenoid();

module solenoid(){


module Ccube( size, align = [ 0, 0, 0 ] ){
 translate(size/2*[[align[0],0,0],[0,align[1],0],[0,0,align[2]]])
  cube( size, center = true );
}

module base(){
    
difference(){
//Ccube([baseX,baseY,magthreadZ],[0,0,1]);

}
translate([0,0,0]){
difference(){
Ccube([baseX,baseY,baseZ],[0,0,1]);
translate([0,0,bottom])Ccube([innerX,innerY,innerZ],[0,0,1]);
cylinder(d=magdia,h=baseZ+1);
hull(){
translate([0,0,magthreadZ-magnutZ])rotate([0,0,30])cylinder(d=magnutdia,h=magnutZ,$fn=6);
translate([0,-baseY,magthreadZ-magnutZ])rotate([0,0,30])cylinder(d=magnutdia,h=magnutZ,$fn=6);
}
hull(){
translate([zAdjDist/2,0,bottom/2-zAdjL/2+zAdjOff])rotate([90,0,0])cylinder(d=zAdjDia,h=baseZ*2,center=true);
translate([zAdjDist/2,0,bottom/2+zAdjL/2+zAdjOff])rotate([90,0,0])cylinder(d=zAdjDia,h=baseZ*2,center=true);
}
hull(){
translate([-zAdjDist/2,0,bottom/2-zAdjL/2+zAdjOff])rotate([90,0,0])cylinder(d=zAdjDia,h=baseZ*2,center=true);
translate([-zAdjDist/2,0,bottom/2+zAdjL/2+zAdjOff])rotate([90,0,0])cylinder(d=zAdjDia,h=baseZ*2,center=true);
}
}}

//translate([0,-(baseY/2+(jackY+jacksupport)/2),0]){
//difference(){
//translate([0,0,0])Ccube([jackX+jacksupport*2,jackY+jacksupport,jackZ],[0,0,1]);
//translate([0,jacksupport/2,0])Ccube([jackX,jackY,jackZ-jackpinsupport],[0,0,1]);
//translate([jackpindist/2,jacksupport/2,0])cylinder(d=jackpindia,h=jackZ);
//translate([-jackpindist/2,jacksupport/2,0])cylinder(d=jackpindia,h=jackZ);
//}}


}



module coil(){
difference(){
union(){
cylinder(d=magholedia+wallthick*2,h=coilZ);
translate([0,0,loweridlerZ])cylinder(d1=rampdia,d2=magholedia+wallthick*2,h=rampZ);
translate([0,0,coilZ-upperidlerZ-rampZ])cylinder(d2=rampdia,d1=magholedia+wallthick*2,h=rampZ);
translate([0,0,coilZ-upperidlerZ])cylinder(d=coildia,h=upperidlerZ);
//Ccube([coildia,coildia,upperidlerZ],[0,0,1]);
translate([0,0,0]){
Ccube([coildia,coildia,loweridlerZ],[0,0,1]);

}
}
translate([0,0,threaddepth]){
cylinder(d=magholedia,h=coilZ);}
cylinder(d=coilthreaddia,h=coilZ+1);
}}

if(orientation==1){
base();
translate([0,0,bottom+threaddepth])rotate([0,0,0])coil();
}

if(orientation==2){
base();
translate([25,0,0])rotate([90,0,0])coil();
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

module kickupMnt(){
wthick=4;
edgeR=3;

slotKickD=-strPosY-slotXY/2-kickup_baseY/2;
ax=slotXY*2+wthick;
ay=slotXY+slotKickD+wthick;
az=kickup_baseX;

scrwD=2.6;

t=0.2;
difference(){
    translate([-slotXY/2-wthick/2,-slotKickD/2+wthick/2,-az/2])rcube([ax,ay,az],edgeR);
    translate([slotXY/2,-slotXY/2,-az/2-1])rcube([slotXY*2+t,slotXY*2+t,az*2],0.1);
    rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY);
    hull(){
    translate([-slotXY*0.65,0,kickup_zAdjDist/2])rotate([-90,0,0])cylinder(d=scrwD,h=slotXY*2,center=true);
    translate([-slotXY*1.4,0,kickup_zAdjDist/2])rotate([-90,0,0])cylinder(d=scrwD,h=slotXY*2,center=true);
    }
    hull(){
    translate([-slotXY*0.65,0,-kickup_zAdjDist/2])rotate([-90,0,0])cylinder(d=scrwD,h=slotXY*2,center=true);
    translate([-slotXY*1.4,0,-kickup_zAdjDist/2])rotate([-90,0,0])cylinder(d=scrwD,h=slotXY*2,center=true);
    }
}

}

module bridge(){
edgeR=3;
wthick=4;
pzDia=28;
pzSink=2;
pzThick=0.6;

pcbX=4;
pcbY=17.3;
pcbZ=27;

bH=slotXY*1.15;    
xy=slotXY+wthick*2;
h=pzDia+wthick+2;
t=0.1;

//piezo();
//translate([0,0,-bH])bridge();
//translate([slotXY/2+wthick+pzThick,-slotXY,h/2])rotate([0,90,0])piezoramp();
translate([slotXY/2+wthick+pzThick-pzSink,-slotXY,h/2])rotate([0,90,0])Pz2Str();

module piezo(){
difference(){
hull(){
rcube([xy,xy,h],edgeR);
translate([0,strPosY,0])rcube([xy,pzDia+wthick*2,h],edgeR);
}
translate([-xy/2,strPosY+5,h/2-pcbZ+pzDia/2])rcube([pcbX,pcbY,pcbZ],0.1);
translate([-xy/2,strPosY+5,h/2-pcbZ+pzDia/2-2])rcube([pcbX,4,pcbZ],0.1);
translate([0,0,-5])rcube([slotXY+t,slotXY+t,h*2],0.1);
translate([xy/2,strPosY,h/2])rotate([0,-90,0])cylinder(d=pzDia,h=pzSink*2,center=true);
translate([0,0,h/2])rotate([-90,0,0])cylinder(d=m5Dia,h=xy);
hull(){
d=6;
translate([0,strPosY,h/2+pzDia/3.3])rotate([0,90,0])cylinder(d=d,h=xy*2,center=true);
translate([0,strPosY,h/2+pzDia/2-d/2])rotate([0,90,0])cylinder(d=d,h=xy*2,center=true);
}
}
}

module Pz2Str(){
    bridgeZ=4.5;
    pzDia=pzDia-1;
    bridgeD=m3NutD*1.5;
    baseZ=3.5;
    m4Dia=4.5;
    scrwD=3.3;
    nutD=m3NutD;
    scrwDst=12;//pzDia-bridgeD;
    cDia=4;
    difference([0,0,0]){
    union(){
    cylinder(d=pzDia,h=baseZ);
    translate([0,0,8])difference(){
    hull(){
        translate([0,scrwDst/2,0])cylinder(d=bridgeD,h=bridgeZ);
        translate([0,-scrwDst/2,0])cylinder(d=bridgeD,h=bridgeZ);
    }
    translate([0,scrwDst/2,-1.5])cylinder(d=nutD,h=bridgeZ,$fn=6);
    translate([0,-scrwDst/2,-1.5])cylinder(d=nutD,h=bridgeZ,$fn=6);
    translate([0,0,0])rotate([90,0,0])scale([1,0.6,1]){
    rotate_extrude(convexity = 10)
    translate([(bridgeD)/2+cDia/2, 0, 0])
    union(){
    circle(r = cDia/2, $fn = 100);
    translate([0,-cDia/2,0])square([cDia*6,cDia]);
    }
    }
}

}
    

    translate([0,scrwDst/2,1])cylinder(d=scrwD,h=20);
    translate([0,-scrwDst/2,1])cylinder(d=scrwD,h=20);
}
}
module bridge(){
    
xy=slotXY+wthick*2;
h=bH;

difference(){
hull(){
rcube([xy,xy,h],edgeR);
translate([0,strPosY,0])rcube([xy,pzDia+wthick*2,h],edgeR);
translate([0,strPosY,0])rcube([xy,pzDia+wthick*2,h],edgeR);
}
translate([0,0,h/2])rotate([-90,0,0])cylinder(d=m5Dia,h=xy);
translate([0,0,-5])rcube([slotXY+t,slotXY+t,h*2],0.1);
translate([xy/2+1,strPosY,h*0.945])rotate([0,-120,0])cylinder(d=strDia+0.3,h=xy*2);
translate([xy/2+5,strPosY,h*0.575])rotate([0,-90,0])cylinder(d=4.8,h=xy);
}

}

module piezoramp(){
piezodia=27.5;
plate_height=8;
screwdia=5.8;
screwsink=6;
ramp_balldia=16;
$fn=32;
piezosupport=0;
piezosink=pzSink;
screwsink=5;
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

}



module tuner(){
$fn=32;
tDia=tuner_tDia;
bDi=tuner_bDi; //inner bearing dia
bDo=tuner_bDo;
zB=tuner_bZ;
rThick=tuner_rThick;
leverZ=tuner_leverZ;
zPos=tuner_zPos;
leverY=tuner_leverY;
wthick=3.5;
xA=22;
y=slotXY+wthick*2;
z=slotXY*2+wthick*2;
scrwDia=4.6;
nutDia=8;
nutZ=3.6;
strHDia=3;
sltAxDst=25;
tClr=3;   
t=0.2;
tB=2;
edgeR=3;
railSink=12;
railDia=12;
topBtmH=8;
wheel();

    difference(){
        t=0.2;
        union(){
        translate([0,0,-topBtmH-tB])rcube([slotXY+wthick*2,slotXY+wthick*2,tDia+tB*2+topBtmH*2],edgeR);
        translate([0,-slotXY,-topBtmH-tB])rcube([slotXY+wthick*2,slotXY+wthick*2,tDia+tB*2+topBtmH*2],edgeR);
        translate([-slotXY,0,tDia+tB])rcube([slotXY+wthick*4,slotXY+wthick*2,topBtmH],edgeR); 
        translate([-slotXY/2+slotXY/4-slotXY-wthick*1.5,-slotXY+wthick,tDia+tB-topBtmH])rcube([slotXY/2+wthick,slotXY+wthick,topBtmH*2],edgeR);
        hull(){
        translate([-slotXY,0,tDia+tB-topBtmH])rcube([slotXY+wthick*4,slotXY+wthick*2,topBtmH],edgeR);  
        translate([-slotXY/2,0,-tB-topBtmH])rcube([wthick,slotXY+wthick*2,topBtmH],edgeR);  
        } 
           
        }
        translate([0,0,-tB-topBtmH-1])rcube([slotXY+t,slotXY+t,tDia*2],0.1);
        translate([0,-slotXY,-tB])rcube([slotXY*2,zB+t*2,tDia+tB*2],0.1);
        translate([-slotXY/2+slotXY/4-slotXY-wthick*1.5,strPosY,-topBtmH-tB])cylinder(d=scrwDia,h=tDia+tB*2+topBtmH*4);
        hull(){
        translate([-slotXY/2+slotXY/4-slotXY-wthick*1.5,strPosY,tDia-nutZ/2])cylinder(d=nutDia,h=nutZ,$fn=6);
        translate([-slotXY/2+slotXY/4-slotXY-wthick*1.5-slotXY,strPosY,tDia-nutZ/2])cylinder(d=nutDia,h=nutZ,$fn=6);
        }
        translate([0,0,tDia/2])rotate([90,0,0])cylinder(d=bDi,h=slotXY*3);
        
        translate([0,0,tDia])rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY*3);
        translate([0,0,0])rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY*3);
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

module string(){
translate([strPosX,strPosY,0])cylinder(d=strDia,h=1000);
}

module slide(){
bDiaI=5.3; //inner bearing diameter
bDiaO=20.5; //outer bearing diameter
bZ=11; //height of the bearing
zA=4.5; //Thickness of the carrier plates
xDst=slotXY+bDiaO; //distance between the one and the two bearings
yDst=45; //distance between the two bearings
cpDst=slide_cpDst; // distance between carrier plate and profile
zB=cpDst+(slotXY-bZ)/2; //height of the spacer
adjL=6; //adjustment lenngth to tight bearing
nutDia=9.2;
nutSp=1.5;
bStrDiaO=11;
adjDst=7;
bDist=20;
bcDist=2; //distance bearing and carrier
rollDia=bStrDiaO+5;
printSp=0.3;
z=zA*2+bZ+bcDist*2;
    
translate([0,0,0])rotate([90,180,0])cPlate();


translate([0,0,0])rotate([0,0,-90])slideB();
//difference(){
//translate([0,0,0])cylinder(d=bDiaI*1.6,h=zB);
//translate([0,0,0])cylinder(d=bDiaI*1,h=zB+zA+1);
//}

module slideB(){
strLvl=20;
railLvl=0;
bDiaO=bStrDiaO;
bDiaI=5;
bZ=5;
zCp=zA;
zA=3;
zB=bZ+bcDist*2;
adjDst=7;
rollDia=bDiaO+5;
z=zA*2+bZ+bcDist*2;
adjScrwD=m4Dia;
buDO=21;
sbYPos=zA/2-strPosY+bZ/2+bcDist;


    
//translate([0,0,0])rotate([90,0,-90])cPlate();
//translate([0,0,0])rotate([0,0,180]){
translate([0,strPosX,0]){
$fn=16;
difference(){
union(){
    translate([0,-strPosX,0])rotate([90,0,-90])cPlate();
hull()rotate([180,0,0]){
translate([sbYPos,0,0]){
translate([0,-rollDia/2-adjDst/2,0])rotate([0,90,0])cylinder(d=bDiaO,h=zA,center=true);
translate([0,rollDia/2,bDist/2])rotate([0,90,0])cylinder(d=bDiaO,h=zA,center=true);
translate([0,rollDia/2,-bDist/2])rotate([0,90,0])cylinder(d=bDiaO,h=zA,center=true);
}
}
}
rotate([180,0,0]){
hull(){
translate([sbYPos,-rollDia/2+adjDst/2,0])rotate([0,90,0])cylinder(d=bDiaI,h=z*2,center=true);
translate([sbYPos,-rollDia/2-adjDst/2,0])rotate([0,90,0])cylinder(d=bDiaI,h=z*2,center=true);
}
hull(){
translate([slotXY/2+cpDst-nutSp,-rollDia/2+adjDst/2,0])rotate([30,0,0])rotate([0,90,0])cylinder(d=nutDia,h=zCp,$fn=6);
translate([slotXY/2+cpDst-nutSp,-rollDia/2-adjDst/2,0])rotate([30,0,0])rotate([0,90,0])cylinder(d=nutDia,h=zCp,$fn=6);
}

translate([sbYPos,rollDia/2,bDist/2])rotate([0,90,0])cylinder(d=bDiaI,h=z*2,center=true);
translate([sbYPos,rollDia/2,-bDist/2])rotate([0,90,0])cylinder(d=bDiaI,h=z*2,center=true);

translate([slotXY/2+cpDst-nutSp,rollDia/2,bDist/2])rotate([0,90,0])cylinder(d=nutDia,h=zCp,$fn=6);
translate([slotXY/2+cpDst-nutSp,rollDia/2,-bDist/2])rotate([0,90,0])cylinder(d=nutDia,h=zCp,$fn=6);
}

}
rotate([180,0,0]){
translate([-strPosY,-rollDia/2,0])strRoller();
translate([-strPosY,rollDia/2,bDist/2])strRoller();
translate([-strPosY,rollDia/2,-bDist/2])strRoller();
}

}
module strRoller(){
$fn=64;
rotate([0,90,0]){
difference(){
union(){
cylinder(d=rollDia,h=bZ,center=true);
}
translate([0,0,0]){
rotate_extrude(convexity = 10)
translate([rollDia/2+strDia/3, 0, 0])
circle(d = strDia, $fn = 100);
}
cylinder(d=bDiaO,h=bZ+1,center=true);
}
difference(){
translate([0,0,bZ/2-0.2])cylinder(d=bDiaI+3,h=bcDist);
translate([0,0,bZ/2-0.2])cylinder(d=bDiaI,h=bcDist+1);
}
difference(){
translate([0,0,-(-strPosY-slotXY/2-zCp-cpDst)+0.1])cylinder(d=bDiaI+3,h=-strPosY-slotXY/2-zCp-cpDst-bZ/2);
translate([0,0,-(-strPosY-slotXY/2-zCp-cpDst)+0.1])cylinder(d=bDiaI,h=bcDist+1);
}
}
}  
}

module cPlate(){
difference(){
union(){
hull(){
    translate([xDst/2+adjL/2,0,-slotXY/2-zA-cpDst])cylinder(d=bDiaI*3,h=zA);
    translate([-xDst/2,yDst/2,-slotXY/2-zA-cpDst])cylinder(d=bDiaI*3,h=zA);
    translate([-xDst/2,-yDst/2,-slotXY/2-zA-cpDst])cylinder(d=bDiaI*3,h=zA);
    
    //translate([-(gearXPos-bearGearD/2),rackScrD/2,-slotXY/2-zA-cpDst])cylinder(d=bDiaI*3,h=zA);
    translate([-(gearXPos-bearGearD/2),0,-slotXY/2-zA-cpDst])cylinder(d=bDiaI*3,h=zA);
}
//translate([-xDst/2,-yDst/2,0])cylinder(d=bDiaO,h=zA);
//   hull(){ 
//    translate([xDst/2-adjL/2,0,-slotXY/2-cpDst])cylinder(d=bDiaI*1.6,h=zB);
//    translate([xDst/2+adjL/2,0,-slotXY/2-cpDst])cylinder(d=bDiaI*1.6,h=zB);
//   }
    translate([-xDst/2,yDst/2,-slotXY/2-cpDst])cylinder(d=bDiaI*1.6,h=zB);
    translate([-xDst/2,-yDst/2,-slotXY/2-cpDst])cylinder(d=bDiaI*1.6,h=zB);
    
    //uncomment to for spacers
    //translate([xDst/2,yDst/2,-slotXY/2-cpDst])cylinder(d=bDiaI*1.6,h=zB);

   }
hull(){ 
    translate([xDst/2+adjL/2,0,-slotXY/2-cpDst-nutSp+printSp])cylinder(d=bDiaI*1,h=zB+zA+1);
    translate([xDst/2-adjL/2,0,-slotXY/2-cpDst-nutSp+printSp])cylinder(d=bDiaI*1,h=zB+zA+1);
   }
    hull(){ 
    translate([xDst/2+adjL/2,0,-slotXY/2-cpDst-zA-0.5])cylinder(d=nutDia,h=zA-nutSp+0.5,$fn=6);
    translate([xDst/2-adjL/2,0,-slotXY/2-cpDst-zA-0.5])cylinder(d=nutDia,h=zA-nutSp+0.5,$fn=6);
   }
    translate([-xDst/2,yDst/2,-slotXY/2-cpDst-nutSp+printSp])cylinder(d=bDiaI*1,h=zB+zA+1);
    translate([xDst/2,yDst/2,-slotXY/2-cpDst-nutSp+printSp])cylinder(d=bDiaI*1,h=zB+zA+1);
    translate([-xDst/2,yDst/2,-slotXY/2-cpDst-zA-0.5])cylinder(d=nutDia,h=zA-nutSp+0.5,$fn=6);
   
    translate([-xDst/2,-yDst/2,-slotXY/2-cpDst-nutSp+printSp])cylinder(d=bDiaI*1,h=zB+zA+1);
    translate([-xDst/2,-yDst/2,-slotXY/2-cpDst-zA-0.5])cylinder(d=nutDia,h=zA-nutSp+0.5,$fn=6);
   
    translate([-slide_rackPosX,0,-slotXY/2-cpDst-zA-0.5])cylinder(d=m4Dia,h=zB+zA+1);
}
}
}
module stpprMnt(){
stepperAXY=42;
stepperASdist=31;
stepperScrwDia=3.3;
stepperH=40;
stepperAMY=8;
stepperADia=28;
stepperAYoff=5;

bDiaI=8.3;
bDiaO=22;
bD=60; //distance between the two bearings
bOff=0; // z position offset of the bearingsoffse
bZ=7;
adjD=10;
t=0.2;

edgeR=4;
wthick=4;

difference(){
translate([0,stepperAMY/2-wthick/2+(mntGrD-slotXY/2-stepperAMY/2)/2,gearZPos-stepperAXY/2])rotate([0,0,0])rcube([slotXY+wthick*2,slotXY+wthick+stepperAMY+(mntGrD-slotXY/2-stepperAMY/2),stepperAXY],edgeR);
translate([0,0,gearZPos-stepperAXY/2-1])rotate([0,0,0])rcube([slotXY+t,slotXY+t*2,stepperAXY+2],0.1);
    translate([0,0,gearZPos])rotate([0,-90,0])cylinder(d=m5Dia,h=slotXY*2);
}
translate([0,-gearYPos,gearZPos])rotate([0,0,-90]){
    //translate([-stepperH-mntGrD-stepperAMY/2,gearXPos,0])rotate([0,90,0])Nema17(MotorHeight=stepperH,MotorWidth=stepperAXY,ShaftDiameter=5,ShaftLength=28,FixingHolesInteraxis=stepperASdist);


    
translate([stepperAMY/2-mntGrD,0,0]){
rotate([-90,0,90]){
difference(){
union(){
//translate([0,0,0])rcube([stepperAXY,stepperAXY,stepperAMY],edgeR);
//translate([bearGearD,bOff,0])rcube([adjD+bDiaI*2,bD+bDiaI+wthick*2,stepperAMY],edgeR);
  hull(){  
translate([slotXY/2,0,0])rcube([slotXY,stepperAXY,stepperAMY],edgeR);
translate([gearXPos,0,0])rcube([stepperAXY,stepperAXY,stepperAMY],edgeR);
  }
translate([gearXPos-bearGearD,bOff,0])rcube([adjD+bDiaI*2,bD+bDiaI+wthick*2,stepperAMY],edgeR); 
}  

translate([gearXPos,0,-0.5])cylinder(d=stepperADia, h=stepperAMY+1);
translate([gearXPos+stepperASdist/2,-stepperASdist/2,-0.5])cylinder(d=stepperScrwDia, h=stepperAMY+1);
translate([gearXPos-stepperASdist/2,-stepperASdist/2,-0.5])cylinder(d=stepperScrwDia, h=stepperAMY+1);
translate([gearXPos-stepperASdist/2,stepperASdist/2,-0.5])cylinder(d=stepperScrwDia, h=stepperAMY+1);
translate([gearXPos+stepperASdist/2,stepperASdist/2,-0.5])cylinder(d=stepperScrwDia, h=stepperAMY+1);

hull(){
translate([gearXPos-bearGearD+adjD/2,bD/2+bOff,-0.5])cylinder(d=bDiaI, h=stepperAMY+1);
translate([gearXPos-bearGearD-adjD/2,bD/2+bOff,-0.5])cylinder(d=bDiaI, h=stepperAMY+1);
}

hull(){
translate([gearXPos-bearGearD+adjD/2,-bD/2+bOff,-0.5])cylinder(d=bDiaI, h=stepperAMY+1);
translate([gearXPos-bearGearD-adjD/2,-bD/2+bOff,-0.5])cylinder(d=bDiaI, h=stepperAMY+1);
}

    }
//translate([bearGearD,bD/2+bOff,-mntGrD+stepperAMY/2-bZ/2])cylinder(d=bDiaO, h=bZ);
//translate([bearGearD,-bD/2+bOff,-mntGrD+stepperAMY/2-bZ/2])cylinder(d=bDiaO, h=bZ);

}
}
}


translate([gearXPos,-gearYPos,gearZPos])rotate([0,0,-90]){
translate([stepperAMY/2-mntGrD,0,0])rotate([-90,0,90])difference(){
translate([bearGearD,bD/2+bOff,-(mntGrD-stepperAMY/2-bZ/2)])cylinder(d=bDiaI+4, h=mntGrD-stepperAMY/2-bZ/2);
translate([bearGearD,bD/2+bOff,-(mntGrD-stepperAMY/2-bZ/2)])cylinder(d=bDiaI, h=mntGrD-stepperAMY/2-bZ/2);

}
}
//translate([stepperAMY/2+gearXPos-mntGrD,-slotXY,strScale/2])rotate([0,-90,0]){
//difference(){
//rcube([slotXY+wthick*2,slotXY+wthick*2,stepperAMY*5],edgeR);
//rcube([slotXY,slotXY,stepperAMY*6],edgeR);
//translate([0,0,stepperAMY*2.5])rotate([-90,0,0])cylinder(d=m5Dia,h=slotXY*2);
//}
//}
}
module rcube(size,radius){
linear_extrude(height=size[2])
if(radius>0){
hull()
{
    // place 4 circles in the corners, with the given radius
    translate([(-size[0]/2)+(radius), (-size[1]/2)+(radius), 0])
    circle(r=radius);

    translate([(size[0]/2)-(radius), (-size[1]/2)+(radius), 0])
    circle(r=radius);

    translate([(-size[0]/2)+(radius), (size[1]/2)-(radius), 0])
    circle(r=radius);

    translate([(size[0]/2)-(radius), (size[1]/2)-(radius), 0])
    circle(r=radius);
}
}
if(radius==0){
translate([0,0,size[2]/2])cube(size,center=true);
}
}