// MOD: 1.25
// Pitch radius (in mm): 5.625
// Circumference (at pitch radius, in mm): 35.34291735288517
// Basic gear script, modify to make suitable and/or pretty
$fn=32;
gear_thickness=17;
pulley_b_ht=8;
pulley_b_dia=22;
motor_shaft=5.3;
rackZ=15;
bearingZ=7.5;
bearingSink=3;
wthick=3;
rack_bottom_height=bearingSink+5;
m3_dia=4.3;
scrwPosZ=5;
debug=0;

//gearRack(0);

module gearRack(type){
if(type==0)rotate([0,0,0]){
translate([0,0,0]){
translate([0,pulley_b_ht+rackZ/2,0])rotate([90,0,0]){
rotate([180,0,0]){
translate([0,0,-gear_thickness-pulley_b_ht])gear(number_of_teeth=8,circular_pitch=360,gear_thickness=gear_thickness);}
pulley();
}
translate([-10,0,0])rotate([90,0,-90])gear_rack(mod=2,number_of_teeth=80,rack_width=rackZ,rack_bottom_height=rack_bottom_height);
}
}

if(type==2)rotate([90,0,90]){
translate([0,0,-pulley_b_ht-gear_thickness/2]){
rotate([180,0,0]){
translate([0,0,-gear_thickness-pulley_b_ht])gear(number_of_teeth=8,circular_pitch=360,gear_thickness=gear_thickness);}
pulley();
}
}
if(type==1)translate([0,0,0])rotate([-90,0,0])gear_rack(mod=2,number_of_teeth=80,rack_width=rackZ,rack_bottom_height=rack_bottom_height);
}
//gearRack();

// Parametric Involute Bevel and Spur Gears by GregFrost
// It is licensed under the Creative Commons - GNU GPL license.
// © 2010 by GregFrost
// http://www.thingiverse.com/thing:3575

// Simple Test:
//gear (circular_pitch=700,
//	gear_thickness = 12,
//	rim_thickness = 15,
//	hub_thickness = 17,
//	circles=8);

//Complex Spur Gear Test:
//test_gears ();

// Meshing Double Helix:
//meshing_double_helix ();

// Demonstrate the backlash option for Spur gears.
//test_backlash ();

// Demonstrate how to make meshing bevel gears.
//bevel_gear_pair ();

pi=3.1415926535897932384626433832795;

//==================================================
// Bevel Gears:
// Two gears with the same cone distance, circular pitch (measured at the cone distance) 
// and pressure angle will mesh.




module gear (
	number_of_teeth=15,
	circular_pitch=false, diametral_pitch=false,
	pressure_angle=20,
	clearance = 0.2,
	gear_thickness=6,
	rim_thickness=6,
	rim_width=5,
	hub_thickness=7,
	hub_diameter=22,
	bore_diameter=motor_shaft,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0)
{
rim_thickness=gear_thickness;
hub_thickness=gear_thickness;
	if (circular_pitch==false && diametral_pitch==false) 
		echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;
	echo ("Teeth:", number_of_teeth, " Pitch radius:", pitch_radius);

	// Base Circle
	base_radius = pitch_radius*cos(pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / number_of_teeth - backlash_angle) / 4;

	// Variables controlling the rim.
	rim_radius = root_radius - rim_width;

	// Variables controlling the circular holes in the gear.
	circle_orbit_diameter=hub_diameter/2+rim_radius;
	circle_orbit_curcumference=pi*circle_orbit_diameter;

	// Limit the circle size to 90% of the gear face.
	circle_diameter=
		min (
			0.70*circle_orbit_curcumference/circles,
			(rim_radius-hub_diameter/2)*0.9);

	difference ()
	{
		union ()
		{
			difference ()
			{
				linear_extrude (height=rim_thickness, convexity=10, twist=twist)
				gear_shape (
					number_of_teeth,
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);

				if (gear_thickness < rim_thickness)
					translate ([0,0,gear_thickness])
					cylinder (r=rim_radius,h=rim_thickness-gear_thickness+1);
			}
			if (gear_thickness > rim_thickness)
				cylinder (r=rim_radius,h=gear_thickness);
			if (hub_thickness > gear_thickness)
				translate ([0,0,gear_thickness])
				cylinder (r=hub_diameter/2,h=hub_thickness-gear_thickness);
		}
		translate ([0,0,-1])
		cylinder (
			r=bore_diameter/2,
			h=2+max(rim_thickness,hub_thickness,gear_thickness));
		if (circles>0)
		{
			for(i=[0:circles-1])	
				rotate([0,0,i*360/circles])
				translate([circle_orbit_diameter/2,0,-1])
				cylinder(r=circle_diameter/2,h=max(gear_thickness,rim_thickness)+3);
		}
	}
}

module gear_shape (
	number_of_teeth,
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	union()
	{
		rotate (half_thick_angle) circle ($fn=number_of_teeth*2, r=root_radius);

		for (i = [1:number_of_teeth])
		{
			rotate ([0,0,i*360/number_of_teeth])
			{
				involute_gear_tooth (
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);
			}
		}
	}
}

module involute_gear_tooth (
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	min_radius = max (base_radius,root_radius);

	pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
	pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius, min_radius);
	stop_angle = involute_intersect_angle (base_radius, outer_radius);

	res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

	union ()
	{
		for (i=[1:res])
		assign (
			point1=involute (base_radius,start_angle+(stop_angle - start_angle)*(i-1)/res),
			point2=involute (base_radius,start_angle+(stop_angle - start_angle)*i/res))
		{
			assign (
				side1_point1=rotate_point (centre_angle, point1),
				side1_point2=rotate_point (centre_angle, point2),
				side2_point1=mirror_point (rotate_point (centre_angle, point1)),
				side2_point2=mirror_point (rotate_point (centre_angle, point2)))
			{
				polygon (
					points=[[0,0],side1_point1,side1_point2,side2_point2,side2_point1],
					paths=[[0,1,2,3,4,0]]);
			}
		}
	}
}


module pulley()
	{

motor_shaft = motor_shaft;	// NEMA17 motor shaft exact diameter = 5
m3_dia = 3.2;		// 3mm hole diameter
m3_nut_hex = 1;		// 1 for hex, 0 for square nut
m3_nut_flats = 5.7;	// normal M3 hex nut exact width = 5.5
m3_nut_depth = 2.7;	// normal M3 hex nut exact depth = 2.4, nyloc = 4

pulley_b_ht = pulley_b_ht;		// pulley base height, standard = 8. 

pulley_b_dia = pulley_b_dia;	// pulley base diameter, standard = 20
no_of_nuts = 3;		// number of captive nuts required, standard = 1
nut_angle = 120;		// angle between nuts, standard = 90
nut_shaft_distance = 1.2;	// distance between inner face of nut and shaft, can be negative.


// calculated constants

nut_elevation = pulley_b_ht/2;
m3_nut_points = 2*((m3_nut_flats/2)/cos(30)); // This is needed for the nut trap


gearHeight = 15;
	difference()
	 {	 
		union()
		{
			//base
	
			
				rotate_extrude($fn=pulley_b_dia*2)
				{
						square([pulley_b_dia/2-1,pulley_b_ht]);
						square([pulley_b_dia/2,pulley_b_ht-1]);
						translate([pulley_b_dia/2-1,pulley_b_ht-1]) circle(1);
				}
			
		}
	   
	
				
		
        //captive nut and grub screw holes
			for(j=[1:no_of_nuts]) rotate([0,0,j*nut_angle])
			translate([0,0,nut_elevation])rotate([90,0,0])
	
			union()
			{
				//entrance
				translate([0,-pulley_b_ht/4-0.5,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance]) cube([m3_nut_flats,pulley_b_ht/2+1,m3_nut_depth],center=true);
	
				//nut
				
						// hex nut
						translate([0,0.25,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance]) rotate([0,0,30]) cylinder(r=m3_nut_points/2,h=m3_nut_depth,center=true,$fn=6);
					
	
				//grub screw hole
				rotate([0,0,22.5])cylinder(r=m3_dia/2,h=pulley_b_dia/2+1,$fn=8);
			}
translate([0,0,-1])cylinder(r=motor_shaft/2,h=pulley_b_ht + gearHeight + 2);		
}
	 
	   
	}


module tooth(mod,width) {
	// see http://easycalculation.com/trigonometry/triangle-angles.php
	opposite_at_reference_pitch=mod / tan(70);
	if (debug) echo("Opposite at reference pitch: ", opposite_at_reference_pitch);
	// see http://www.metrication.com/engineering/gears.html
	// see section Circular Tooth Thickness
	// see also http://www.tech.plym.ac.uk/sme/desnotes/gears/nomen1.htm
	tooth_width_at_reference_pitch=(pi / 2) * mod;
	if (debug) echo("Tooth width at reference_pitch: ", tooth_width_at_reference_pitch);
	cube_width = tooth_width_at_reference_pitch - (2 * opposite_at_reference_pitch);
	if (debug) echo("Cube width: ", cube_width);
	// see http://www.metrication.com/engineering/gears.html
	// see section Whole Depth
	opposite_of_triangle = mod < 1.25 ? 2.4 * mod : 2.25 * mod;
	if (debug) echo("Opposite_of_triangle: ", opposite_of_triangle);
	// see http://easycalculation.com/trigonometry/triangle-angles.php
	adjacent_of_triangle = opposite_of_triangle / tan(70);
	if (debug) echo("Adjacent of triangle: ", adjacent_of_triangle);
	diagonal = sqrt((opposite_of_triangle + 0.05) * (opposite_of_triangle + 0.05) + (adjacent_of_triangle * adjacent_of_triangle));
	correct_angle = 90 - acos(adjacent_of_triangle / diagonal);
	if (debug) echo("Correct angle: ", correct_angle);
	adjacent_of_mini_triangle = 0.05 / tan(90 - correct_angle);
	if (debug) echo("Adjacent of mini triangle: ", adjacent_of_mini_triangle);
	adjacent_top_cube = (0.5 * mod) / tan(45);
	translate([0,adjacent_of_mini_triangle * -1, 0]) {
		difference() {
			union() {
				intersection() {
					cube([opposite_of_triangle + 0.05,adjacent_of_triangle, width]);
					rotate([0,0,correct_angle]) cube([diagonal,adjacent_of_triangle, width]);
				}
				translate([0,adjacent_of_triangle,0]) cube([opposite_of_triangle + 0.05,cube_width, width]);
				translate([0,(adjacent_of_triangle * 2) + cube_width,width]) {
					rotate([180,0,0]) {
						intersection() {
							cube([opposite_of_triangle + 0.05,adjacent_of_triangle, width]);
							rotate([0,0,correct_angle]) cube([diagonal,adjacent_of_triangle, width]);
						}
					}
				}
			}
			translate([-0.5 * mod,-1,-0.5 * mod])cube([1 * mod + 0.05, 1+ adjacent_of_mini_triangle, width + (1 * mod)]);
			translate([-0.5 * mod,(adjacent_of_triangle * 2) + cube_width - adjacent_of_mini_triangle,-0.5 * mod]) cube([1 * mod + 0.05, 1, width + (1 * mod)]);
			translate([opposite_of_triangle + 0.05 * mod,adjacent_of_triangle - adjacent_top_cube,-0.25 * mod]) {
				rotate([0,0,45]) cube([1 * mod, 0.5 * mod,width + (2 * mod)]);
			}
			translate([opposite_of_triangle + 0.05 * mod,adjacent_of_triangle - adjacent_top_cube + cube_width + 0.3 * mod,-0.25 * mod]) {
				rotate([0,0,45]) cube([0.5 * mod, 1 * mod,width + (2 * mod)]);
			}
		}
	}
}

module teeth(mod,number_of_teeth,width) {
	union() {
		for (i= [0:number_of_teeth - 1]) {
			// see http://www.tech.plym.ac.uk/sme/desnotes/gears/nomen1.htm
			translate([-0.05,i * mod * pi,0]) {
				tooth(mod=mod,width=width);	
			}
		}
	}
}

module gear_rack(mod,number_of_teeth,rack_width,rack_bottom_height) {
	total_rack_length = number_of_teeth * pi * mod;
	rotate([0,90,0]) {
		translate([0,total_rack_length / 2 * -1,rack_width / 2 * -1]) {
			union() {
				teeth(mod=mod,number_of_teeth=number_of_teeth,width=rack_width);
				translate([rack_bottom_height * -1,0,0])
difference(){					
cube([rack_bottom_height, number_of_teeth * pi * mod, rack_width]);
translate([-rack_bottom_height+bearingSink,wthick+scrwPosZ+m3_dia/2,(rack_width-bearingZ)/2])cube([rack_bottom_height, number_of_teeth * pi * mod-wthick-scrwPosZ-m3_dia/2, bearingZ]);
translate([rack_bottom_height/2,scrwPosZ,0])cylinder(d=m3_dia,h=rackZ);
translate([rack_bottom_height/2,scrwPosZ+20,0])cylinder(d=m3_dia,h=rackZ);
}
			}
		}
	}
	echo("Total length of gear rack (in mm): ", total_rack_length);
}




// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / pi;

// Calculate the involute position for a given base radius and involute angle.

function rotated_involute (rotate, base_radius, involute_angle) = 
[
	cos (rotate) * involute (base_radius, involute_angle)[0] + sin (rotate) * involute (base_radius, involute_angle)[1],
	cos (rotate) * involute (base_radius, involute_angle)[1] - sin (rotate) * involute (base_radius, involute_angle)[0]
];

function mirror_point (coord) = 
[
	coord[0], 
	-coord[1]
];

function rotate_point (rotate, coord) =
[
	cos (rotate) * coord[0] + sin (rotate) * coord[1],
	cos (rotate) * coord[1] - sin (rotate) * coord[0]
];

function involute (base_radius, involute_angle) = 
[
	base_radius*(cos (involute_angle) + involute_angle*pi/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*pi/180*cos (involute_angle)),
];


// Test Cases
//===============

module test_gears()
{
	translate([17,-15])
	{
		gear (number_of_teeth=17,
			circular_pitch=500,
			circles=8);
	
		rotate ([0,0,360*4/17])
		translate ([39.088888,0,0])
		{
			gear (number_of_teeth=11,
				circular_pitch=500,
				hub_diameter=0,
				rim_width=65);
			translate ([0,0,8])
			{
				gear (number_of_teeth=6,
					circular_pitch=300,
					hub_diameter=0,
					rim_width=5,
					rim_thickness=6,
					pressure_angle=31);
				rotate ([0,0,360*5/6])
				translate ([22.5,0,1])
				gear (number_of_teeth=21,
					circular_pitch=300,
					bore_diameter=2,
					hub_diameter=4,
					rim_width=1,
					hub_thickness=4,
					rim_thickness=4,
					gear_thickness=3,
					pressure_angle=31);
			}
		}

		translate ([-61.1111111,0,0])
		{
			gear (number_of_teeth=27,
				circular_pitch=500,
				circles=5,
				hub_diameter=2*8.88888889);

			translate ([0,0,10])
			{
				gear (
					number_of_teeth=14,
					circular_pitch=200,
					pressure_angle=5,
					clearance = 0.2,
					gear_thickness = 10,
					rim_thickness = 10,
					rim_width = 15,
					bore_diameter=5,
					circles=0);
				translate ([13.8888888,0,1])
				gear (
					number_of_teeth=11,
					circular_pitch=200,
					pressure_angle=5,
					clearance = 0.2,
					gear_thickness = 10,
					rim_thickness = 10,
					rim_width = 15,
					hub_thickness = 20,
					hub_diameter=2*7.222222,
					bore_diameter=5,
					circles=0);
			}
		}
	
		rotate ([0,0,360*-5/17])
		translate ([44.444444444,0,0])
		gear (number_of_teeth=15,
			circular_pitch=500,
			hub_diameter=10,
			rim_width=5,
			rim_thickness=5,
			gear_thickness=4,
			hub_thickness=6,
			circles=9);
	
		rotate ([0,0,360*-1/17])
		translate ([30.5555555,0,-1])
		gear (number_of_teeth=5,
			circular_pitch=500,
			hub_diameter=0,
			rim_width=5,
			rim_thickness=10);
	}
}

module meshing_double_helix ()
{
	test_double_helix_gear ();
	
	mirror ([0,1,0])
	translate ([58.33333333,0,0])
	test_double_helix_gear (teeth=13,circles=6);
}

module test_double_helix_gear (
	teeth=17,
	circles=8)
{
	//double helical gear
	{
		twist=200;
		height=20;
		pressure_angle=30;

		gear (number_of_teeth=teeth,
			circular_pitch=700,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = height/2*0.5,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2*1.2,
			hub_diameter=15,
			bore_diameter=5,
			circles=circles,
			twist=twist/teeth);
		mirror([0,0,1])
		gear (number_of_teeth=teeth,
			circular_pitch=700,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = height/2,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2,
			hub_diameter=15,
			bore_diameter=5,
			circles=circles,
			twist=twist/teeth);
	}
}

module test_backlash ()
{
	backlash = 2;
	teeth = 15;

	translate ([-29.166666,0,0])
	{
		translate ([58.3333333,0,0])
		rotate ([0,0,-360/teeth/4])
		gear (
			number_of_teeth = teeth,
			circular_pitch=700,
			gear_thickness = 12,
			rim_thickness = 15,
			rim_width = 5,
			hub_thickness = 17,
			hub_diameter=15,
			bore_diameter=5,
			backlash = 2,
			circles=8);
		
		rotate ([0,0,360/teeth/4])
		gear (
			number_of_teeth = teeth,
			circular_pitch=700,
			gear_thickness = 12,
			rim_thickness = 15,
			rim_width = 5,
			hub_thickness = 17,
			hub_diameter=15,
			bore_diameter=5,
			backlash = 2,
			circles=8);
	}

	color([0,0,128,0.5])
	translate([0,0,-5])
	cylinder ($fn=20,r=backlash / 4,h=25);
}

