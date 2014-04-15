include <involute_gears.scad>
include <plate.scad>
include <inc/constants.scad>

//Diametral pitch, p_d 
//Ratio of the number of teeth to the pitch diameter. Could be measured in teeth per inch or teeth per centimeter.

//The pitch of a gear is the distance between equibvalent points on adjacent teeth. (See the diagram to the right) For two gears to mesh they must have the same pitch. The pitch circle of a gear is an imaginary circle which passes through the point where the teeth touch when one gear meshes with another. The pitch diameter is the diameter of the pitch circle.




hr = 6;
dh = 12;

dist = hr*2+dh;

give = .2;

pitch = 0.335664335779307;

cylinder(r=2,h=10, $fn=8);
gear(number_of_teeth=8,diametral_pitch=pitch, pressure_angle=30, flat=true);


/*
translate([6+12+6+give,0,0]){
rotate([0,0,0])
gear(number_of_teeth=6,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}
*/



translate([0,dist*2,0]){
rotate([0,0,30])
gear(number_of_teeth=24, diametral_pitch=pitch, flat=true);
cylinder(r=2, h=10, $fn=16);
}

translate([fh/2, fh/2,4])
color("red")
plate(4,4);


translate([24*2+24,24*2+24*2,0]){
rotate([0,0,15])
gear(number_of_teeth=8*5,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}

/*
translate([6+12+6+give,24*2+24,0]){
rotate([0,0,22])
gear(number_of_teeth=8,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}
*/


translate([24*2+24,24,0]){
rotate([0,0,0])
gear(number_of_teeth=8,diametral_pitch=pitch, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}
