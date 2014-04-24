include <inc/constants.scad>


module pulley(rad=hr*3, thickness=10, flange_height=4, flange_width=4, square=false)
{
  difference()
  {
  union()
  {


    //thread holder
    translate([-1,-1.5,thickness/2+5])
    rotate([0,45,0])
    cube([10,3,10]);

    

  cylinder(r2=rad, r1=rad+flange_height, h=flange_width);
  translate([0,0,flange_width])
  cylinder(r=rad, h=thickness);
  translate([0,0,flange_width+thickness])
  cylinder(r1=rad, r2=rad+flange_height, h=flange_width);
  }


translate([rad+1.1,5,thickness/2+5])
    rotate([90,0,0])
    cylinder(r=1.5, h=10);


  translate([0,0,-1])
  if(square)
    cylinder(r=hr+ggive, h=thickness+flange_width*2+2, $fn=6);
  else
    cylinder(r=hr+pgive, h=thickness+flange_width*2+2);
}


}

pulley(square=true, rad=hr+2);