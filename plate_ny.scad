include <inc/constants.scad>


module plate(width=2, height=2, holes=true)
{
//total width (sans holders)
twidth = width*dhx+width*2*hr;
theight = height*dhy+height*2*hr;

difference()
{
cube([twidth, theight,4]);


  union()
  {
  //translate fastener height
  //for more even-ness
  translate([-fh/2,fh/2,0])
  translate([dhx/2+hr,hr+dhy/2,-1])
  for(i=[0:width-1])
  {
    for(j=[0:height-1])
    {
		if(holes)
      {
      translate([i*hr*2+dhx*i,j*hr*2+j*dhy,0])
      cylinder(r=hr+pgive, h=10);
      }
      
    }
  }

  //fastener holes, bottom
  fasteners();

  //fastener holes, side
  translate([twidth,0,0])
  rotate([0,0,90])
  fasteners(dist=dhy, w=false);
  }
}

module fasteners(dist=dhx, w=true)
{

if(w)
{
for(i=[0:width-1])
{
translate([dist/2+hr-fw/2+i*dist+i*hr*2,0,0])
cube([fw,fh,4]);
}
}
else
{
for(i=[0:height-1])
{
translate([dist/2+hr-fw/2+i*dist+i*hr*2,0,0])
cube([fw,fh,4]);
}
}

}

//top fasteners
translate([0,theight,0])
fasteners();

//side fasteners
rotate([0,0,90])
fasteners(dist=dhy, w=false);



}

plate(4,4);