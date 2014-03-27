use <involute_gears.scad>
use <polyScrewThread_r1.scad>
pi=3.1415;
$fn=80;
//hole radius
hr = 6;

//distance between holes
dh = 12;

//give between two gears
giveg = .5;

//give
give=.4;

//shaft give
sgive = .6;

//plug give
pgive = .14;


pitch=.2;


module plate(width=5, height=5)
{
  difference()
  {
  translate([-hr*2-dh/2,-hr*2-dh/2,0])
  cube([(width)*2*hr+(width)*dh+hr*2, (height)*2*hr+(height)*dh+hr*2, 4]);

  translate([0,0,-5])
  for (i=[0:width-1])
  {
    for(j=[0:height-1])
    {
      translate([dh*i+2*hr*i,j*(dh+2*hr),0])
      cylinder(r=hr+pgive*2, h=15);
    }
  }
  }


}


module gear1(teeth=10, pitch=.25)
{
  difference()
  {
  linear_extrude(height=3)
  gear(number_of_teeth=teeth, diametral_pitch=pitch, flat=true);

  translate([0,0,-5])
  //cube([12/1.42,12/1.42,24],center=true);
  cylinder(r=hr+pgive*2, h=24, $fn=4);
  }

}

module plug()
{
//base
cylinder(r=hr+1, h=8);
//plug
translate([0,0,8])
cylinder(r=hr-give, h=15,$fn=4);

}

module plug_cap()
{
difference()
{
cylinder(r=hr+pgive+1, h=8);
translate([0,0,2])
cylinder(r=hr+pgive, h=7,$fn=4);
}

}

module shaft(length=dh, width=hr*2)
{
  //outer width
  ow = 3+pgive*2;

difference()
{
  hull()
  {
  cylinder(r=width/2+ow,h=4);
  translate([length+hr*2,0,0])
  cylinder(r=width/2+ow,h=4);
  }

  union(){
  //round hole on other end
  translate([length+hr*2,0,-1])
  cylinder(r=hr+pgive*2,h=10);

  //square hole
  translate([0,0,-1])
  cylinder(r=hr+pgive*2,h=10, $fn=4);
  }
}




}



/*
translate([0,0,4])
//gear(number_of_teeth=10, diametral_pitch=true,  circular_pitch=dh*2*180/(pi*pi), flat=true);
//gear(number_of_teeth=80, diametral_pitch=5, flat=true);


gear(number_of_teeth=(hr+dh/2)/2, diametral_pitch=.25, flat=true);
*/

/*
 //[1,0] || [0,1]
translate([dh+hr*2,0,4])
rotate([0,0,20])
gear(number_of_teeth=10, diametral_pitch=.5, flat=true);
*/


/*
//[1,1]
translate([dh+hr*2,dh+hr*2,4])
rotate([0,0,20])
gear(number_of_teeth=((hr+dh/2)*sqrt(2)*2-(hr+dh/2))/2, diametral_pitch=.25, gear_thickness=2, hub_thickness=0, rim_thickness=2, bore_diameter=2);
*/

/*
//[2,1]
translate([dh+hr*2,2*(dh+hr*2),4])
rotate([0,0,20])
gear(number_of_teeth=10*sqrt(5)*2-10, diametral_pitch=.5, flat=true);
*/

/*
//[0,2]
translate([2*(dh+hr*2),0,4])
rotate([0,0,20])
gear(number_of_teeth=((hr+dh/2)*4-hr-dh/2)/2, diametral_pitch=.5/2, flat=true);
*/

translate([-70,80,0])
gear1( floor(((hr+dh/2)*4-hr-dh/2)/2) );

//translate([2*(dh+2*hr),0,20])
//rotate([0,0,30])
//gear(number_of_teeth=30, circular_pitch=dh*2*180/(pi*pi), flat=true);



//cylinder(r=5, h=100);
//plate(3,2);

translate([90,0,0])
//translate([0,0,10])
gear1((hr+dh/2)/2,.25);


//translate([dh+hr*2,dh+hr*2,20])
/*
translate([100,100,0])
//rotate([0,0,7])
gear1(floor(((hr+dh/2)*sqrt(2)*2-(hr+dh/2))/2),.25);
*/

//translate([100,50,0])
//translate([0,0,30])
//plug();


//translate([0,0,60])
//translate([0,80,0])
//plug_cap();

/*
translate([-70,0,0])
shaft();
*/


translate([-100,30,0])
{
hex_screw((hr*2)/sqrt(2),4,55,15,1.5,2,14,4,12,0);
translate([0,0,4])
cylinder(r=6, h=12, $fn=4);
translate([-25,0,0])
hex_nut(14,8,4,55,(hr*2)/sqrt(2)+.5,0.5);
}
