use <involute_gears.scad>
use <polyScrewThread_r1.scad>
include <inc/constants.scad>


module gear1(teeth=10, pitch=.25)
{
  difference()
  {
  linear_extrude(height=4)
  gear(number_of_teeth=teeth, diametral_pitch=pitch, flat=true);

  union()
  {
  translate([0,0,-5])
  //cube([12/1.42,12/1.42,24],center=true);
  cylinder(r=hr+ggive, h=24, $fn=6);
  translate([teeth*2,0,-1])
  cylinder(r=ghr+pgive,h=6);
  }
  }


}

gear1(6);