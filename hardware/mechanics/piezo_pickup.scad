//include <configuration.scad>;
//include <bolt_nut.scad>;

piezodia=27.5;
piezosupport=2;
piezosink=2;
plate_height=8;
screwdia=5.8;
screwsink=6;
ramp_balldia=16;
$fn=32;

//piezoPickup(1);

module piezoplate(){

difference(){
hull(){
    cylinder(d=piezodia/2,h=1);
    translate([0,0,plate_height-piezosink])cylinder(d=piezodia+piezosupport*2,h=piezosink);
}
translate([0,0,plate_height-piezosink]){
cylinder(d=piezodia,h=plate_height);}
translate([0,0,-plate_height+screwsink]){
cylinder(d=screwdia,h=plate_height);}
}
}

module piezoramp(){

piezosupport=2;
piezosink=2;
screwsink=5;
width=10;
spread=10;

scale([1,1,0.7]){
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


module piezoPickup(orientation){

if(orientation==1){    
translate([0,stringroddist/2-plate_height-ramp_balldia/2,0]){
rotate([90,0,0]){
//color(actcolor)piezoplate();
translate([0,0,plate_height]){
rotate([0,0,90]){
color(basecolor)piezoramp();
    }}}}
}

if(orientation==2){    

translate([0,40,0])color(actcolor)piezoplate();
translate([30,40,0])rotate([0,0,90])color(basecolor)piezoramp();


}

}
//piezo_pickup(1);