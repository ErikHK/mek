//include <roundCornersCube.scad>


include <inc/constants.scad>
nRF24L01_hole = [15.2+3,33+3, 1.6+3];

nRF24L01pos = [26.67, 24.13];

$fn=20;

vccpos = [-39.37, 29.21];
vccw = 2.54;
vcch = 5.08;

motorpos = [-22.86, 7.62];
motorw = 7.62;
motorh = 5.08;

vinpos = [-17.78,-1.27];
vinw = 2.54;
vinh = 5.08;

/*
screw_dist();
translate([0,33.02,0])
screw_dist();

translate([-33.02,8.89,0])
screw_dist();
*/

module screw_dist(height=5)
{
difference()
{
cylinder(r=3, h=height);
cylinder(r=1.5, h=height);
}

}

/*
//holes
translate(vccpos)
cube([vccw,vcch,3]);

translate(motorpos)
cube([motorw,motorh,3]);

translate(vinpos)
cube([vinw,vinh,3]);
*/


module pcb()
{
color([1,1,1,.2])
linear_extrude(height=1.6)
polygon(points=[[0,0],[0,40.64],[-46.99,40.64],[-46.99,17.78],[-29.21,0]]);


}

module distances(height=6.5, bottom_thickness=2)
{
translate([-3.81,3.81,0])
{
screw_dist(height-.8);
translate([0,33.02,0])
screw_dist(height-.8);

translate([-33.02,8.89,0])
screw_dist(height-.8);
}
}


module bottom_box(height=6.5, bottom_thickness=2)
{

translate([-3.81,3.81,bottom_thickness])
{
screw_dist(height-.8);
translate([0,33.02,0])
screw_dist(height-.8);

translate([-33.02,8.89,0])
screw_dist(height-.8);

//distances();

}

difference()
{
minkowski()
{
//cylinder(r=2.5,h=height);
cylinder(r=4.5,h=height);
pcb();
}


translate([0,0,bottom_thickness])
color("red")
pcb_minkowski(height);
}
}


difference()
{
translate([3.81,-3.81,0])
{
translate([0,0,0])
bottom_box();
}

//holes
translate([0,0,-2])
{
translate(vccpos)
cube([vccw,vcch,5]);

translate(motorpos)
cube([motorw,motorh,5]);

translate(vinpos)
cube([vinw,vinh,5]);
}
}

module fastener(width=dhx, thickness=4)
{
//HOLES FOR FASTENING
translate([0,4,0])
{
difference()
{
union()
{
translate([(hr*2+3),0,-bottom_thickness])
cylinder(r=hr+thickness, h=4);

translate([6,5,0])
cube([15,hr+width,4]);

translate([(hr*2+3),hr*2+width,-bottom_thickness])
cylinder(r=hr+thickness, h=4);
}

translate([(hr*2+3),hr*2+width,-bottom_thickness])
cylinder(r=hr+pgive, h=6, $fn=6);

translate([(hr*2+3),0,0])
cylinder(r=hr+pgive, h=6, $fn=6);
}
}

}

translate([2,0,0])
fastener(dhy);


module pcb_minkowski(height=5)
{
minkowski(){
pcb();
translate([0,0])
//cube([2,2,3]);
cylinder(r=1.5,h=height);
}

}

/*
translate([3.81,-3.81,3])
color("red")
pcb_minkowski();
*/


module top_box()
{



difference()
{
mirror([1,0,0])
bottom_box(height=6);

translate(nRF24L01pos-nRF24L01_hole)
translate([0,0,-.1])
cube(nRF24L01_hole);


translate([3.81, 3.81,-2])
cylinder(r=1.5,h=30);


translate([3.81, 3.81,-2])
cylinder(r=1.5,h=30);


translate([3.81,33.02+3.81,-2])
cylinder(r=1.5,h=30);


translate([33.02+3.81,3.81+8.89,-2])
cylinder(r=1.5,h=30);

}
}

translate([70,0,0])
top_box();


/*
translate([40,0,0])
cylinder(r=28.5/2, h=2);
*/





//cube(nRF24L01_hole);