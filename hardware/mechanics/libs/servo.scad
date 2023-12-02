width=20;
length=40.5;
height=38;
mountH=2.5;
mountL=54;
mountZ=27;
axOff=10.4;

servo();

module servo(){
    cube([width,length,height],center=true);
    translate([0,0,-height/2+mountH/2+mountZ])cube([width,mountL,mountH],center=true);
    translate([0,length/2-axOff,height/2])cylinder(d=9,h=6+2.3);
    translate([0,length/2-axOff,-height/2])cylinder(d=15,h=39.5);
    translate([0,length/2-axOff,6+height/2])cylinder(d=21,h=2.3);
}