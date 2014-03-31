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

//shaft give
sgive = .6;

//plug give
pgive = .15;

//fastener give (holes)
fgive = .13;

pitch=.2;


////fastener sizes
//notch width
notchw = 0;

//notch height
notchh = 0;

//fastener height
fh = 4;

//fastener width (sans notch)
fw = hr;


//gear hole radius
ghr = 1.4;

//arrow length
al = 8;


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
      cylinder(r=hr+pgive*2, h=15);
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


module gear1(teeth=10, pitch=.25)
{
  difference()
  {
  linear_extrude(height=3)
  gear(number_of_teeth=teeth, diametral_pitch=pitch, flat=true);

  union()
  {
  translate([0,0,-5])
  //cube([12/1.42,12/1.42,24],center=true);
  cylinder(r=hr+pgive*2, h=24, $fn=4);
  translate([teeth*2,0,-1])
  cylinder(r=ghr+pgive*2,h=6);
  }
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

module shaft(length=dh, width=hr*2, square1=false, square2=false)
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
  if(square1)
    cylinder(r=hr+pgive*2,h=10, $fn=4);
  else
    cylinder(r=hr+pgive*2,h=10);
  }
}

}

module shaft_test(length=1, square1=false, square2=false, hole=true)
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
  if(hole && length>1)
  hull()
  {
  translate([2*hr+th,0,-1])
  cylinder(r=hr+pgive*2, h=10);

  translate([len-pgive*4-th,0,-1])
  cylinder(r=hr+pgive*2, h=10);
  }


  //round hole on other end
  translate([len+hr*2,0,-1])
  if(square1)
    cylinder(r=hr+pgive*2,h=10, $fn=4);
  else
    cylinder(r=hr+pgive*2,h=10);

  //square hole
  translate([0,0,-1])
  if(square2)
    cylinder(r=hr+pgive*2,h=10, $fn=4);
  else
    cylinder(r=hr+pgive*2,h=10);
  }
}

}


translate([-fh/2,-30,0])
shaft_test(length=3, hole=true);



module spacer(height=4, )


module arrow()
{
  linear_extrude(height=al/3)
  polygon(points=[[0,0],[-al/4,0],[-al/4,al/2],[-al/2,al/2], [0,al]]);

mirror([1,0,0])
linear_extrude(height=al/3)
  polygon(points=[[0,0],[-al/4,0],[-al/4,al/2],[-al/2,al/2], [0,al]]);

translate([0,2*al/3,al/3])
cylinder(r=ghr, h=3);


}

translate([120,0,0])
arrow();


//handle for the shaft
module handle()
{
  difference()
  {
  union()
  {
  cylinder(r=hr+1, h=20);
  translate([0,0,20])
  cylinder(r1=hr+1, r2=hr, h=3);
  translate([0,0,23])
  cylinder(r=hr, h=3);

  translate([0,0,26])
  cylinder(r1=hr, r2=hr+1, h=3);
  translate([0,0,29])
  cylinder(r=hr+1, h=1);
  }

  translate([-hr-2,-1,20])
  cube([hr*2+4,2,40]);
  }


}

translate([100,0,0])
handle();


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

/*
translate([-70,80,0])
gear1( floor(((hr+dh/2)*4-hr-dh/2)/2) );
*/

//translate([2*(dh+2*hr),0,20])
//rotate([0,0,30])
//gear(number_of_teeth=30, circular_pitch=dh*2*180/(pi*pi), flat=true);



//cylinder(r=5, h=100);
plate(4,2);

/*
translate([0,hr*4+dh*2,0])
plate(2,2);
translate([hr*4+dh*2,hr*4+dh*2,0])
plate(2,2);
*/

//SMALL GEAR 6 TEETH
translate([0,-60,0])
//translate([0,0,10])
gear1((hr+dh/2)/2,.25);


//translate([dh+hr*2,dh+hr*2,20])



/////MEDIUM GEAR 10 TEETH
//translate([100,100,0])
//rotate([0,0,7])
//gear1(floor(((hr+dh/2)*sqrt(2)*2-(hr+dh/2))/2),.25);


//translate([100,50,0])
//translate([0,0,30])
//plug();


//translate([0,0,60])
//translate([0,80,0])
//plug_cap();




/*
translate([-100,30,0])
{
hex_screw((hr*2)/sqrt(2),4,55,15,1.5,2,14,4,12,0);
translate([0,0,4])
cylinder(r=6, h=12, $fn=4);
translate([-25,0,0])
hex_nut(14,8,4,55,(hr*2)/sqrt(2)+.5,0.5);
}
*/