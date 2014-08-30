include <inc/constants.scad>
$fn=40;
//hole radius
//height
h=8;

//hole wall thickness
hwth = 2;

module blade(th=2, length=20)
{
linear_extrude(height=h, twist=65, convexity=200, $fn=100)
square([length,th]);

}


module prop(blades=4)
{
  difference()
  {
    union()
    {
      for(i=[0:blades])
        rotate([0,0,360*i/blades])
        blade();
      cylinder(r=hr+hwth+ggive, h=h);
    }

    translate([0,0,-.1])
    cylinder(r=hr+ggive, h=h+.2, $fn=6);
  }
}

prop(4);