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