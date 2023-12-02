dO=7;
dI=3.3;
h=3;
$fn=16;
difference(){
  cylinder(d=dO,h=h);
  cylinder(d=dI,h=h*3, center=true);
}