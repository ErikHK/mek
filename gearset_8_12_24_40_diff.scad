include <gear1.scad>
include <arrow.scad>
ghr=1;



arrow_depth=1;

//.2 clearance on 12/24 teeth
//pitch = 0.341325083143933;
//more dist between 8 and 12
//pitch = .342;
//more dist between 8 and 16
pitch = .346;

al=10;

gear1(teeth=8, pitch=pitch);

translate([40,0,0])
{
difference()
{
  gear1(teeth=12, pitch=pitch);

color("red")
translate([(16/(pitch*2)-hr)/2-1,0,4-arrow_depth])
rotate([0,0,-90])
scale(12/16)
arrow(peg=false);

}
}

//16 teeth
al=10;
translate([70,-40,0])
{

difference()
{
gear1(teeth=16, pitch=pitch);
color("red")
translate([(16/(pitch*2)-hr)/2,0,4-arrow_depth])
rotate([0,0,-90])
arrow(peg=false);
}
}

//24 teeth
translate([0,-65,0])
{
difference()
{
gear1(teeth=24, pitch=pitch);

color("red")
translate([(16/(pitch*2))/2,0,4-arrow_depth])
rotate([0,0,-90])
scale(24/16)
arrow(peg=false);

}
}

/*
//40 tooth  x3  ~59.6 mm
translate([120,-65,0])
gear1(teeth=40, pitch=pitch);
*/

