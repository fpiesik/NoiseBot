include <../libs/rcube.scad>;
include <../parameter.scad>;

//moFret();
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
            rotate([0,0,0])hook();
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