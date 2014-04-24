include <inc/constants.scad>
use <screws.scad>
use <shaft.scad>
use <gear1.scad>
use <plate_ny.scad>
use <gearset_8_12_24_40_diff.scad>
use <spacer.scad>
use <wheel.scad>

/*
/////SCREWS/////
screw();
translate([0,20,0])
screw(slanted_head=false);

translate([0,40,0])
screw(slanted_head=false, threaded_length=24);

translate([0,60,0])
thread();


/////NUTS/////
translate([-20,0,0])
{
nut();

translate([0,20,0])
nut(nut_width=16);


translate([0,40,0])
enlongated_nut();


}

*/


/////BARS/////
translate([20,0,0])
{
bar(square=[true,true]);


translate([0,25,0])
bar(square=[true, true], slanted=[true,false], mirrorslanted=[false,true]);

translate([0,50,0])
bar(length=3, one_hole=false, holes=true);

translate([0,75,0])
bar(length=3, one_hole=false, holes=true, square=[true,false,false,true]);

translate([0,100,0])
bar(length=4, one_hole=true, square=[true,false,false,true]);


}


/////PLATES/////

translate([140,0,0])
{
plate(2,2);

translate([0,65,0])
plate(4,4);

}


/////GEARS/////
pitch = .346;
translate([-60,0,0])
{

gear1(teeth=8, pitch=pitch);
translate([0,40,0])
12_teeth();
translate([0,90,0])
16_teeth();
translate([0,160,0])
24_teeth();

}


/////WHEELS/////

translate([-140,0,0])
{
wheel();
translate([0,70,0])
tire();



translate([0,130,0])
wheel(rad=3*hr, holes=0);
translate([0,175,0])
tire(rad=3*hr, rim_thickness=1, rim_height=1);


}