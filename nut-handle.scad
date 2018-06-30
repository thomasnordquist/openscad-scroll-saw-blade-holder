dialDiameter = 20;
dialWidth = 8;
nibbleCount = 10;

circumferance = PI * dialDiameter;
nibbleDiameter = circumferance / nibbleCount;

module hexNutM4(tolerance=0.15) {
 e = 7+tolerance;
 m = 3.2;
 cylinder(r=e/2, h=m, $fn=6);
}

module handle() {
  difference() {
    for(i=[1:1:nibbleCount]) {
      degree = 360/nibbleCount;
      rotate([0, 0, degree*i]) translate([dialDiameter/2, 0, 0]) circle(r=nibbleDiameter/2);
    }
    for(i=[1:1:nibbleCount]) {
      degree = 360/nibbleCount;
      rotate(degree/2) rotate([0, 0, degree*i]) translate([dialDiameter/2, 0, 0]) circle(r=nibbleDiameter/4);
    }
  }

}

module shape() {
  circle(r = dialDiameter/2);
  handle();
}

module handleWithBevel() {
  $fn=12;
  bevelFactor = 1.15;
  linear_extrude(height=dialWidth/4, scale=bevelFactor) scale([1/bevelFactor, 1/bevelFactor]) shape();
  translate([0, 0, 1/4*dialWidth]) linear_extrude(height=dialWidth/2) shape();
  translate([0, 0, 3/4*dialWidth]) linear_extrude(height=dialWidth/4, scale=1/bevelFactor) shape();
}

module handleWithCutout() {
  translate([0, 0, dialWidth]) mirror([0, 0, 1]) difference() {
    handleWithBevel();
    translate([0, 0, -0.01]) hexNutM4();
    translate([0, 0, -0.01]) cylinder(r=2.1, h=10, $fn=24);
  }
}

handleWithCutout();

