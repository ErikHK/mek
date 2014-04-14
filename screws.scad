include <inc/constants.scad>
use <polyScrewThread_r1.scad>

nut_give = .8;

slant=2;

//head width
hw = 12;

//head height
hh = 4;

//threaded length
tl = 15;

//screwable width
sw = hr*2/sqrt(2);

//pitch
p = 4;

//angle
ang = 55;

//non-threaded length
nsl = 8;




module screw(head_width=14, head_height=4, threaded_length=15, threaded_width=hr*2/sqrt(2), pitch=4, angle=55, non_threaded_length=8, slanted_head=true)
{

if(slanted_head)
{
  translate([0,0,head_height])
  hex_screw(threaded_width,pitch,angle,threaded_length,1.5,2,head_width,0,non_threaded_length,0);
  cylinder(r1=hr+slant, r2=hr, h=4, $fn=6);
}
else
  hex_screw(threaded_width,pitch,angle,threaded_length,1.5,2,head_width,head_height,non_threaded_length,0);


translate([0,0,head_height])
cylinder(r=hr, h=non_threaded_length, $fn=6);

}


module nut(nut_width=12, nut_height=6, pitch=4, angle=55)
{
hex_nut(nut_width,nut_height,pitch,angle,hr*2/sqrt(2)+nut_give, 1.5);

}





/*
translate([-50,30,0])
{
hex_screw((hr*2)/sqrt(2),4,55,15,1.5,2,14,4,12,0);
translate([0,0,4])
cylinder(r=6, h=12, $fn=6);
translate([-25,0,0])
hex_nut(14,8,4,55,(hr*2)/sqrt(2)+.5+.3,0.5);
}




translate([-50,-30,0])
{
hex_screw((hr*2)/sqrt(2),4,55,15,1.5,2,12,2,3,0);
translate([0,0,4])
//cylinder(r=6, h=12, $fn=6);
translate([-25,0,0])
hex_nut(12,6,4,55,(hr*2)/sqrt(2)+.5+.3,0.5);
}


//SPECIALIZED SCREW!
translate([-150,-30,0])
{
hex_screw((hr*2)/sqrt(2),4,55,15,1.5,2,12,0,3,0);
translate([0,0,4])
//cylinder(r=6, h=12, $fn=6);
translate([-25,0,0])
hex_nut(12,6,4,55,(hr*2)/sqrt(2)+.5+.3,0.5);

translate([0,0,0])
cylinder(r1=8, r2=5, h=4, $fn=6);

translate([0,0,4])
cylinder(r=5, h=4, $fn=6);

translate([0,-20,0])
shaft_test_spec(square1=true);
}
*/

//hex_screw(sw,p,ang,tl,1.5,2,hw,hh,nsl,0);

screw(non_threaded_length=8, slanted_head=false);

translate([-20,0,0])
nut();