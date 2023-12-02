include <../libs/rcube.scad>;
include <../parameter.scad>;

//stand_multi();

hA=3;
hB=3;
armL=120;
armOff=15;
wT=3;
edgeR=5;
h=slotXY*2/3+hA+hB;

t=0.2;


module stand_single(){
difference(){
    for (i = [0:3]) {
        hull(){
            cylinder(d=slotXY*1.55,h=slotXY);
            rotate([0,0,45+i*90])translate([armL,0,0])cylinder(d=slotXY/2,h=3);
        }    
    }
    translate([0,0,hA+hB])rcube([slotXY+t,slotXY+t,h],0.5);
    translate([0,0,hA+0.3])cylinder(d=5.4,h=slotXY,$fn=16);
    translate([0,0,-0.01])cylinder(d=15,h=hA,$fn=16);
}

        

}

//module stand_multi(nStr,strDist){
//difference(){
//  hull(){
//    translate([0,0,0])rcube([slotXY+t+10,slotXY+10,h],0.5);
//    translate([0,0,0])rcube([armL,armL,hA],0.5);
//  }
//
//    translate([0,0,hA+hB])rcube([slotXY+t,slotXY+t,h],0.5);
//    translate([0,0,hA+0.3])cylinder(d=5.4,h=slotXY,$fn=16);
//    translate([0,0,-0.01])cylinder(d=15,h=hA,$fn=16);
//}
//
//}


module stand_multi(nStr,strDist){
wAB=0;
wB=strDist*(nStr-1)+wT*3+slotXY;
difference(){
  hull(){
    translate([0,wB/2-slotXY/2-wT*1.5,0])rcube([slotXY+wT*2,wB,h],edgeR);
    translate([armOff,wB/2-slotXY/2-wT*1.5,0])rcube([armL,wB+wAB,hA],edgeR);
  }
  for (i = [0:nStr-1]) {
    translate([0,i*strDist,0]){
      translate([0,0,hA+hB])rcube([slotXY+t,slotXY+t,h],0.5);
      translate([0,0,hA+0.3])cylinder(d=5.4,h=slotXY,$fn=16);
      translate([0,0,-0.01])cylinder(d=15,h=hA,$fn=16);
    }
  }
}
}

module top_multi(nStr,strDist){
wB=strDist*(nStr-1)+wT*3+slotXY;
difference(){
  hull(){
    translate([0,wB/2-slotXY/2-wT*1.5,0])rcube([slotXY+wT*2,wB,h],edgeR);
    translate([0,wB/2-slotXY/2-wT*1.5,0])rcube([slotXY+wT*2,wB,h],edgeR);
  }
  for (i = [0:nStr-1]) {
    translate([0,i*strDist,0]){
      translate([0,0,hA+hB])rcube([slotXY+t,slotXY+t,h],0.5);
      translate([0,0,hA+0.3])cylinder(d=5.4,h=slotXY,$fn=16);
      translate([0,0,-0.01])cylinder(d=15,h=hA,$fn=16);
    }
  }
}
}