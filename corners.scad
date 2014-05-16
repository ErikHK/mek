include <inc/constants.scad>
use <plate_ny.scad>

twidth=2*(dhx+2*hr)+dhx;

/*
plate(4,2);


translate([0,0,twidth])
rotate([0,-90,0])
mirror([1,0,0])
plate(2,2);
*/


//translate([-4,60,0])
//rotate([90,0,0])
difference()
{
translate([0,0,0])
linear_extrude(height=4)
polygon(points=[[0,0], [twidth/2,0], [0, twidth/2]]);

translate([dhx/2+hr+4-fw/2,0,-.1])
cube([fw,fh,5]);

translate([0,dhx/2+fw/2,-.1])
cube([fh,fw,5]);
}