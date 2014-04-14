include <involute_gears.scad>

hr = 3;
dh = 6;
give = .2;

cylinder(r=2,h=10, $fn=8);
gear(number_of_teeth=8,diametral_pitch=1, pressure_angle=30, flat=true);


translate([8+give,0,0]){
rotate([0,0,22])
gear(number_of_teeth=8,diametral_pitch=1, pressure_angle=30, flat=true);
cylinder(r=2, h=10, $fn=16);
}

//plate(3,2);