include <inc/constants.scad>

//extra radius
slant = 2;


module bar(length=1, square=false, one_hole=true, slanted=false, holes=false)
{
  th=3;
  width=hr*2;
  len = length*(dh)+hr*2*(length-1);
  
  //outer width
  ow = th+pgive*2;

  


difference()
{
  hull()
  {
  cylinder(r=width/2+ow,h=4);
  translate([len+hr*2,0,0])
  cylinder(r=width/2+ow,h=4);
  }

  union(){
  //hole in the middle
  if(one_hole && length>1)
  hull()
  {
  translate([2*hr+th,0,-1])
  cylinder(r=hr+pgive, h=10);

  translate([len-pgive*4-th,0,-1])
  cylinder(r=hr+pgive, h=10);
  }
  else if(holes)
  {
    for(i=[1:length-1])
  {
  translate([i*dh+i*hr*2,0,0])
  if(square[i])
  {
    if(slanted[i])
      cylinder(r1=hr+ggive, r2=hr+pgive+slant, h=4, $fn=6);
    else
      cylinder(r=hr+ggive, h=4, $fn=6);

  }
  else
  {
    if(slanted[i])
      cylinder(r1=hr+pgive, r2=hr+pgive+slant, h=4);
    else
      cylinder(r=hr+pgive, h=4);

  }
  
  }

  }

  
  //hole on other end
  translate([len+hr*2,0,0])
  if(square[length])
  {
    if(slanted[length])
      cylinder(r1=hr+ggive,r2=hr+ggive+slant, h=4, $fn=6);
    else
      cylinder(r=hr+ggive,h=4, $fn=6);
    
  }
  else
  {
    if(slanted[length])
      cylinder(r1=hr+pgive, r2=hr+pgive+slant, h=4);
    else
      cylinder(r=hr+pgive,h=4);
  }

  //first hole
  translate([0,0,0])
  if(square[0])
  {
    if(slanted[0])
      cylinder(r1=hr+ggive, r2=hr+pgive+slant, h=4, $fn=6);
    else
      cylinder(r=hr+ggive,h=4, $fn=6);
  }

  else
  {
    if(slanted[0])
      cylinder(r1=hr+pgive, r2=hr+ggive+slant,h=4);
    else
      cylinder(r=hr+pgive,h=4);
  }

  }
}

}

bar(length=3, one_hole=false, holes=true, square=[true,false,false,false], slanted=[true,true,false,true]);