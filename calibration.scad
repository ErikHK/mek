include <inc/constants.scad>
use <screws.scad>
use <plate_ny.scad>
use <shaft.scad>


//adjust nut_give
screw(threaded_length=6, head_height=4, non_threaded_length=4);

translate([20,0,0])
nut();

//adjust fgive for fasteners
//adjust pgive for holes, should not have a lot of room for minimal friction
translate([-10,10,0])
plate(1,1);
translate([-10,45,0])
plate(1,1);

//adjust ggive for hole, head_height in screw to make it flush
translate([25,20,0])
bar(length=0, one_hole=true, holes=false, square=[true,true], slanted=[true,false], mirrorslanted=[true, true]);

