use <involute_gears.scad>
include <inc/constants.scad>
use <plate_ny.scad>
//include <gearset_8_12_24_40_diff.scad>
use <gear1.scad>
//translate([0,0,-4])
//gear1(teeth=16, pitch=.346);

echo(hr);

/*
bevel_gear(number_of_teeth=8,
cone_distance=110, face_width=8,outside_circular_pitch=180/.346, pressure_angle=28, hub_diameter=15);
*/


translate([0,-3*hr/2-fw,0])
{

//translate([0,0,16])
//gear1(teeth=8, pitch=.346);

bevel_gear_pair(gear1_teeth=8, gear2_teeth=24, outside_circular_pitch=180/.346);
}



/*
$fn=40;
color("green")
cylinder(r=hr, h=30, $fn=6);
*/



rotate([0,0,180])
translate([-3*hr/2,0,14])
{

plate();

rotate([90,0,0])
plate();

}




