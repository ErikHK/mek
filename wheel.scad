include <inc/constants.scad>

pi = 3.14;

thickness=8;
wheelrad = 3*(hr+pgive)+2*hr;


module wheel(rad=wheelrad, holes=6)
{

  interv = 360/holes;

  dist = (hr+pgive)*2+hr;
  
  difference()
  {
  cylinder(r=rad, h=thickness);

  

  
  //holes
  translate([0,0,-2])
  {
    cylinder(r=hr+pgive, h=thickness+4, $fn=6);
   
    for(i=[1:holes])
    {
      translate([dist*cos(i*interv), dist*sin(i*interv),1])
      cylinder(r=hr+pgive, h=thickness+2);


    }
  }

}

}


//print this in an elastic filament for best result
//rim thickness means extra width besides thickness
module tire(rim_thickness=1.5,give=1, rim_height=1.2, tire_thickness=1)
{

r1 = wheelrad+give-tire_thickness-rim_height;
r2=wheelrad+give-tire_thickness;

difference()
{
cylinder(r=wheelrad+tire_thickness+give, h=rim_thickness*4+thickness);

translate([0,0,-1])
cylinder(r=wheelrad+give-rim_height-tire_thickness, h=rim_thickness*4+thickness+2);

translate([0,0,rim_thickness])
{

cylinder(r1=r1, r2=r2, h=rim_thickness);

translate([0,0,rim_thickness])
cylinder(r=r2, h=thickness);
translate([0,0,thickness+rim_thickness])
cylinder(r2=r1, r1=r2, h=rim_thickness);

}
//cylinder(r=wheelrad-tire_thickness, h=thickness);

}


}

wheel();
translate([50,50,0])
tire();