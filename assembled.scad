use <nut-handle.scad>
use <blade-mount.scad>

module nut() {
  color("silver") difference() {
    cylinder(r=7.9/2, h=3, $fn=6);
    translate([0, 0, -0.01]) cylinder(r=4/2+0.1, h=4, $fn=16);
  }
}

module washer() {
  color("silver") difference() {
    cylinder(r=10/2, h=1, $fn=32);
    translate([0, 0, -0.01]) cylinder(r=4/2+0.1, h=4, $fn=16);
  }
}

module screw() {
  color("silver") {
    cylinder(r=4/2, h=28, $fn=16);
    cylinder(r=7.9/2, h=3, $fn=6);
  }
}

module assembled() {
  color("LightSlateGray") bladeMount();
  color("beige") translate([32, 19, 0]) rotate([270, 0 ,0]) handleWithCutout();

  translate([32, -2.3]) rotate([270, 0, 0]) screw();
  translate([32, 24.5]) rotate([270, 0, 0]) nut();
  translate([32, 6.3]) rotate([270, 0, 0]) washer();
  translate([32, 8.7]) rotate([270, 0, 0]) washer();
  translate([32, 18]) rotate([270, 0, 0]) washer();
}

module blade() {
  color("silver") linear_extrude(height=110, twist=10000) square([0.2, 0.6]);
}

mirror([0, 0, 1]) assembled();
translate([0, 16, 100]) rotate([180, 0, 0]) mirror([0, 0, 1]) assembled();
translate([35, 6.3+1.7, -5]) blade();
