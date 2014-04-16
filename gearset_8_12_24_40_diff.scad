include <gear1.scad>
ghr=1;

//pitch = 0.335664335779307;
//.2 clearance on 12/24 teeth
//pitch = 0.341325083143933;
//more dist between 8 and 12
pitch = .342;

//8 tooth  x1  12 mm
gear1(teeth=8, pitch=pitch);

//12 tooth  x4  ~18 mm
translate([40,0,0])
gear1(teeth=12, pitch=pitch);

//24 tooth  x2  35.75 mm
translate([0,-65,0])
gear1(teeth=24, pitch=pitch);

/*
//40 tooth  x3  ~59.6 mm
translate([120,-65,0])
gear1(teeth=40, pitch=pitch);
*/