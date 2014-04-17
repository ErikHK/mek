include <inc/constants.scad>

//al=15;

module arrow(base_width=al/2, base_length=al/2, head_width=.8*al, head_length=al/2, thickness=al/3, peg=true)
{

  module half_arrow()
  {
  linear_extrude(height=al/3)
  polygon(points=[[0,0],[-base_width/2,0],[-base_width/2,base_length],[-head_width/2,base_length], [0,base_length+head_length]]);
  }
union()
{
half_arrow();

mirror([1,0,0])
half_arrow();

if(peg)
  translate([0,2*al/3,al/3])
  cylinder(r=ghr, h=3);

}
}

//arrow(peg=false);