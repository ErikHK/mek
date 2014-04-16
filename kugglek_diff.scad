include <involute_gears.scad>
include <plate_diff.scad>
include <inc/constants.scad>

//Diametral pitch, p_d 
//Ratio of the number of teeth to the pitch diameter. Could be measured in teeth per inch or teeth per centimeter.

//The pitch of a gear is the distance between equibvalent points on adjacent teeth. (See the diagram to the right) For two gears to mesh they must have the same pitch. The pitch circle of a gear is an imaginary circle which passes through the point where the teeth touch when one gear meshes with another. The pitch diameter is the diameter of the pitch circle.




hr = 6;
dh = 12;

dist = hr*2+dh;

give = .2;

//pitch = 0.335664335779307;
//pitch = .3413;
pitch = .346;

/*
translate([6+12+6+give,0,0]){
rotate([0,0,0])
gear(number_of_teeth=6,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}
*/

translate([fh/2, -fh/2,4])
color("red")
plate(8,4);




translate([0,0,0]){
rotate([0,0,22])
gear(number_of_teeth=8,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}


translate([24,0,0]){
rotate([0,0,0])
gear(number_of_teeth=8,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}


translate([24*2,26.4,0]){
rotate([0,0,0])
gear(number_of_teeth=16,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}


translate([24*3,0,0]){
rotate([0,0,0])
gear(number_of_teeth=8,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}



translate([24*5,0,0]){
rotate([0,0,7])
gear(number_of_teeth=24,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}


translate([24*5,26.4*2,0]){
rotate([0,0,-10])
gear(number_of_teeth=12,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}


translate([24*5,26.4*2,-1]){
color("green")
rotate([0,0,-0])
gear(number_of_teeth=8,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}


translate([24*4,26.4*3,-1]){
color("green")
rotate([0,0,-0])
gear(number_of_teeth=16,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}



translate([24*4,26.4*3,-2]){
rotate([0,0,-0])
gear(number_of_teeth=8,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}

translate([24*6,26.4*3,-2]){
rotate([0,0,-0])
gear(number_of_teeth=8,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}


translate([24*1,26.4*3,-2]){
rotate([0,0,-23])
gear(number_of_teeth=40,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}


