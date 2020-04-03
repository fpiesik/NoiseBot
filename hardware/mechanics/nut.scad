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