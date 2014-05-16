use <involute_gears.scad>

pitch = .346;
//hole diam
hd = 1.5;
//bore give
bg = .1;


gear(number_of_teeth=8, diametral_pitch=pitch, gear_thickness=4, rim_thickness=4, hub_thickness=4, bore_diameter=hd+bg);