include <inc/constants.scad>
use <shaft.scad>
use <gear1.scad>
use <../scad/block-120713.scad>


//translate([])
//rotate([90,0,0])
block(2,5,1,axle_hole=false,reinforcement=true);

//inner radius
//ir = 13;
ir = 7.5+.2;

//outer thickness
ot = 3.5;

//holder height
hh = 30;

//roof thickness
rt = 1;

//fastener width
fw = 3;

//nut hole radius
nhr = 9.5/2;

//nut hole depth
nhd = 2;

//screw hole radius
shr = 2.1;


module holder_housing(vertical=true)
{
module nut_hole()
{
translate([ir-.6,0,hh/2])
rotate([0,90,0])
cylinder(r=nhr, h=nhd+.6, $fn=6);

translate([ir-.6,0,hh/2])
rotate([0,90,0])
cylinder(r=shr, h=ot*2);
}

translate([(dhx/2+hr)*(fw-1),0,0])
{
//roof

translate([0,0,hh])
{
difference()
{
cylinder(r=ir+ot, h=rt);
translate([-ir-ot,-ir/2,-.1])
cube([2*(ir+ot),ir,rt+1]);
}
}


difference()
{
union()
{
//outer housing
cylinder(r=ir+ot, h=hh);

translate([-ir-ot,0,0])
cube([(ir+ot)*2, ir+ot, hh]);

if(vertical)
{
translate([-hr*6,ir+ot,hh/2])
rotate([90,0,0])
fastener();
}
else
{
fastener();
}
}


//nut holes

rotate([0,0,0])
{
nut_hole();

translate([0,0,0])
rotate([0,0,180])
nut_hole();

translate([0,0,0])
rotate([0,0,90])
nut_hole();


translate([0,0,0])
rotate([0,0,-90])
nut_hole();
}

}

}
}

module fastener()
{
bar(length=fw-1, one_hole=false, holes=[true,false,false,true]);
}

module motor_holder(vertical=false)
{
difference()
{
union()
{
holder_housing(vertical);

/*
if(vertical)
{
translate([0,ir+ot,hh/2])
rotate([90,0,0])
fastener();
}
else
{
fastener();
}
*/

}
translate([(dhx/2+hr)*(fw-1),0,-.1])
cylinder(r=ir, h=hh+.2);

}

}
//translate([0,0,(ir+ot)/2])
//rotate([-90,0,0])
//motor_holder(vertical=true);

//holder_housing();

/*
translate([30,40,0])
{
gear1(teeth=8, pitch=.346);

translate([-1.6,-2,0])
cube([.5,10,4]);

difference()
{
cylinder(r=8, h=4);

cylinder(r=1.5+.13,h=5);
}
}
*/