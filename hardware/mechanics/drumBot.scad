slotWH=20;
slotAH=500;
slotBH=250;
drmDia=375;
drmH=120;
slotADist=200;

cylinder(d=drmDia, h=drmH);

//translate([slotADist/2,-slotAH/2,-slotWH/2])rotate([-90,0,0])rcube([slotWH,slotWH,slotAH],1);
//translate([-slotADist/2,-slotAH/2,-slotWH/2])rotate([-90,0,0])rcube([slotWH,slotWH,slotAH],1);
//translate([slotADist/2,-slotAH/2,slotWH/2+drmH])rotate([-90,0,0])rcube([slotWH,slotWH,slotAH],1);
//translate([-slotADist/2,-slotAH/2,slotWH/2+drmH])rotate([-90,0,0])rcube([slotWH,slotWH,slotAH],1);
//
//translate([slotBH/2,(drmDia/2+slotWH/2+5),-slotWH/2+drmH])rotate([0,-90,0])rcube([slotWH,slotWH,slotBH],1);
//translate([slotBH/2,-(drmDia/2+slotWH/2+5),-slotWH/2+drmH])rotate([0,-90,0])rcube([slotWH,slotWH,slotBH],1);

translate([0,-slotAH/2,slotWH/2+drmH+10])rotate([-90,0,0])rcube([slotWH,slotWH,slotAH],1);

translate([0,0,200])drmClmp();

module drmClmp(){
    $fa = 3;
    w=120;
    d=45;
    hA=40;
    hB=5;
    doW=250;
    angle=50;
    ovrSnr=10;
    
    difference(){
        //translate([0,-d/2, 0])rcube([w,d,hA],5);
        translate([0,0, 0])rotate([0,0,-angle/2])rotate_extrude(angle=angle)translate([doW/2,0, 0])square([hA,hA]);
        translate([0,0, hA])rotate_extrude()translate([doW/2-hA+20,0, 0])circle(d=hA*2);
    }
    translate([0,0, hA])rotate([0,0,-angle/2])rotate_extrude(angle=angle)translate([doW/2-ovrSnr,0, 0])square([hA+ovrSnr,hB]);
}

module rcube(size,radius){
  $fn=16;
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