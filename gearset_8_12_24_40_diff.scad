include <gear1.scad>
ghr=1;

//.2 clearance on 12/24 teeth
//pitch = 0.341325083143933;
//more dist between 8 and 12
pitch = .342;

gear1(teeth=8, pitch=pitch);

translate([40,0,0])
gear1(teeth=12, pitch=pitch);

translate([70,-40,0])
gear1(teeth=16, pitch=pitch);


translate([0,-65,0])
gear1(teeth=24, pitch=pitch);

/*
//40 tooth  x3  ~59.6 mm
translate([120,-65,0])
gear1(teeth=40, pitch=pitch);
*/