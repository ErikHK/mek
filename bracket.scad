use <shaft.scad>
use <plate_ny.scad>
include <inc/constants.scad>



module bracket(length=2, height=2, depth=1)
{


  module part()
  {
  difference()
  {
  union()
  {
  bar(length=length, one_hole=false, holes=[false,true,true, true]);

  translate([-4+hr,0,4+hr*4*height-hr])
  rotate([0,90,0])
  bar(length=height, one_hole=false, holes=[true,true,false]);

  }

  translate([0,-10,-20])
  cube([20,20,20]);

  translate([-20+2,-10,-1])
  cube([20,20,20]);


  }
  }

  for(i=[0:depth-1])
  {
  translate([0,0,i*(hr*4)])
  rotate([-90,0,0])
  
  part();
  }
  

}

bracket(length=1, height=1, depth=2);

/*
translate([0,70,0])
rotate([0,0,180])
plate(2,2);

translate([0,4,0])
rotate([-90,0,0])
plate(2,2);

*/