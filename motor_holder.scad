include <inc/constants.scad>
use <shaft.scad>

//inner radius
ir = 12;

//outer thickness
ot = 4;

//holder height
hh = 35;

//roof thickness
rt = 1;

//fastener width
fw = 3;

//nut hole radius
nhr = 3;

//nut hole depth
nhd = 2;

//screw hole radius
shr = 1.5;


module holder_housing()
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
//outer housing
cylinder(r=ir+ot, h=hh);


//nut holes

nut_hole();

translate([0,0,-2])
rotate([0,0,180])
nut_hole();

translate([0,0,-2])
rotate([0,0,90])
nut_hole();


translate([0,0,-2])
rotate([0,0,-90])
nut_hole();

}

}
}

module fastener()
{
bar(length=fw-1, one_hole=false);
}

module motor_holder()
{
difference()
{
union()
{
holder_housing();
fastener();
}
translate([(dhx/2+hr)*(fw-1),0,-.1])
cylinder(r=ir, h=hh+.2);

}

}

motor_holder();