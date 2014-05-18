include <inc/constants.scad>
//$fn = 10;
//outer radius
or = 30;

//inner radius
ir = hr+ggive+2;

//wall thickness
wth = 1;

//total height
th = 16;

//number of flanges
nf = 10;

//number of flanges
angle = 360/nf;
//extra angle
ea = 90;

p = ea-asin(ir*sin(180-ea)/or);

x = sin(p)*ir/(sin(ea-p));


module waterwheel()
{

difference()
{
union()
{
//outer walls
rotate([0,0,p])
{
cylinder(r=or, h=wth, $fn=nf);
translate([0,0,th-wth])
cylinder(r=or, h=wth, $fn=nf);
}

//inner cylinder
cylinder(r=ir, h=th);
}
cylinder(r=hr+ggive, h=th+1, $fn=6);


}




//flanges
for(i=[0:nf])
{
translate([cos(i*angle)*ir,sin(i*angle)*ir,0])
rotate([0,0,i*angle+ea])
cube([x,1,th]);
}

}




waterwheel();