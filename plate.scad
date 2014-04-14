use <involute_gears.scad>
use <polyScrewThread_r1.scad>

include <inc/constants.scad>

module plate(width=5, height=5)
{
  

  //total plate width
  //tpw = (width)*2*hr+(width)*dh+hr*2;
  tpw = (width)*2*hr+(width)*dh;

  //total plate height
  tph = (height)*2*hr+(height)*dh;


  difference()
  {
  translate([-hr-dh/2,-hr-dh/2,0])
  cube([tpw, tph, 4]);

  union()
  {
  translate([0,0,-5])
  for (i=[0:width-1])
  {
    for(j=[0:height-1])
    {
      translate([dh*i+2*hr*i-fh/2,j*(dh+2*hr)+fh/2,0])
      cylinder(r=hr+pgive, h=15);
    }
  }
  }
  
  union()
  {
  //side fastener holes
  translate([hr+hr*2*(width-1)+dh*(width-1)+dh/2,-hr,0]){
    for(i = [0:height-1])
    {
      translate([0,i*(dh+hr*2),0])
      fastener(fgive);
    }
  }



  //top fastener holes
  translate([-fw,-hr-dh/2,0]){
    for(i = [0:width-1])
    {
      translate([i*(dh+hr*2),0,0])
      rotate([0,0,-90])
      fastener(fgive);
    }
  }
  }

  }


  //fasteners
  module fastener(give=0)
  {
  rotate([0,0,90])
  {
  translate([-0,0,0])
  linear_extrude(height=4)
  polygon(points=[[0,0],[0,notchh-give],[-notchw-give,notchh-give],[-notchw-give,fh+notchh+give],[fw/2+give,fh+notchh+give], [fw/2+give,0]]);

  translate([fw,0,0])
  mirror([1,0,0])
  linear_extrude(height=4)
  polygon(points=[[0,0],[0,notchh-give],[-notchw-give,notchh-give],[-notchw-give,fh+notchh+give],[fw/2+give,fh+notchh+give], [fw/2+give,0]]);
  }
  }

  //side fasteners
  translate([-hr-dh/2,-hr,0]){
    for(i = [0:height-1])
    {
      translate([0,i*(dh+hr*2),0])
      fastener();
    }
  }

  //top fasteners
  translate([-fw,hr+hr*2*(height-1)+dh*(height-1)+dh/2,0]){
    for(i = [0:width-1])
    {
      translate([i*(dh+hr*2),0,0])
      rotate([0,0,-90])
      fastener();
    }
  }


}

plate(2,2);