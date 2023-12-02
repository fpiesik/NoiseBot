include <parameter.scad>
strSpanB=10;
bodySlotX=100;

kickup(3);

module kickup(orient){
$fn=32;

spacing=strSpanB;//52;
echo (spacing);
diameter=15;
wall=2;
coilZ=15;
bottomZ=2;
t=0.3;
ySpacing=12;

bX = slotXY;
bY=12;
bZ=coilZ+bottomZ+t;

tX = bX;
tY=bY;
hub=3;
magZ=3.1;
tbottomZ=3;
tZ=hub+magZ+tbottomZ;
tDia=6.7;//6.5;
screwTdia=4.3;

conMntX=2.54;
conMntY=6.3;
conMntZ=12;
conWt=1.5;

screwMdia=4.3;

mntTh=4.5;
mX=bX+slotXY+mntTh;


module mnt(){
difference(){
    union(){
        translate([-mX/2+bX/2,0,-mntTh])rcube([mX,bY,mntTh],3);
        translate([-mX+bX/2+mntTh/2,0,-mntTh])rcube([mntTh,bY,bZ+mntTh+tZ],0.1);
    }
    hull(){
    translate([-bX/2-slotXY,0,slotXY/2])rotate([0,-90,0])cylinder(d=m5Dia,h=bZ,center=true);
    translate([-bX/2-slotXY,0,(bZ+tZ)-m5Dia*1.5])rotate([0,-90,0])cylinder(d=m5Dia,h=bZ,center=true);
    }
    
    
    translate([0,0,-mntTh-1])cylinder(d=screwMdia,h=bZ);
}
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




module coil(){
$fn=32;
magholedia=4;
wallthick=0.5;
loweridlerZ=2;
upperidlerZ=1.8;
rampBZ=0.2;
rampTZ=0.2;
coildia=14;
rampdia=coildia;
threaddepth=5;
roofZ=0; //loweridlerZ;
conD=2.54;
conMDia=7;
conR=coildia/2-1;

difference(){
union(){
cylinder(d=magholedia+wallthick*2,h=coilZ);
translate([0,conR,0])cylinder(d=conMDia,h=loweridlerZ);   
translate([0,0,loweridlerZ])cylinder(d1=rampdia,d2=magholedia+wallthick*2,h=rampBZ,$fn=6);
translate([0,0,coilZ-upperidlerZ-rampTZ])cylinder(d2=rampdia/100*100,d1=magholedia+wallthick*2,h=rampTZ,$fn=6);
translate([0,0,coilZ-upperidlerZ])cylinder(d=coildia/100*100,h=upperidlerZ,,$fn=6);
//Ccube([coildia,coildia,upperidlerZ],[0,0,1]);
translate([0,0,0]){
//Ccube([coildia,coildia,loweridlerZ],[0,0,1]);
cylinder(d=coildia,h=loweridlerZ,$fn=6);

}
}

translate([conD/2,conR+1.5,0])cylinder(d=1,h=loweridlerZ*2,center=true);  
translate([-conD/2,conR+1.5,0])cylinder(d=1,h=loweridlerZ*2,center=true); 

translate([0,0,-roofZ])cylinder(d=magholedia,h=coilZ);
//cylinder(d=coilthreaddia,h=coilZ+1);
}}



translate([0,0,-bZ-tZ]){
//rotate([00,0,0])mnt();
translate([0,tY+0,0])rotate([90,0,0])rotate([0,90,0])coil();
}
}

