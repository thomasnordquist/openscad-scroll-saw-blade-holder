anchorWidth = 16;
anchorLength = 16;
anchorScrewDiameter = 5.2;
anchorThickness = 5;
screwOffset = 10;

$fn=32;

module anchorPlate() {
  difference() {
    cube([anchorLength, anchorWidth, anchorThickness]);
    translate([screwOffset, anchorWidth/2, -0.1]) cylinder(r=anchorScrewDiameter/2, h=anchorThickness+0.2);
  };
};

module hexNutM3(tolerance=0.15) {
 e = 6.01+tolerance;
 m = 2.3;
 cylinder(r=e/2, h=m, $fn=6);
}

module hexNutM4(tolerance=0.15) {
 e = 7+tolerance;
 m = 3.2;
 cylinder(r=e/2, h=m, $fn=6);
}


mountWidth = 20;
mountLength = 22;
mountHeight = 10;
mountMinThickness = 3;
flexCutoutDiameter = mountWidth-4-2*mountMinThickness;
bladeOffset = 8.6;

tensionGap = 3.5;
tensionerScrew = 4.15;

module bladeMount() {
  tensionScrewOffset = (mountLength - (mountMinThickness + flexCutoutDiameter)) / 2 + (mountMinThickness + flexCutoutDiameter)-1;

  difference() {
    cube([mountLength, mountWidth, mountHeight]);
    
    translate([-2, 0]) {
       // Flex cutout (round)
      translate([mountWidth/2, mountWidth/2, -0.1]) cylinder(r=flexCutoutDiameter/2, h=mountHeight+0.2);
    
      // Tension gap
      translate([flexCutoutDiameter, mountWidth/2-0.5*tensionGap, -0.1]) cube([mountLength, tensionGap, mountHeight+0.2]);
    }
 
    // Tension screw
    translate([tensionScrewOffset, -0.1, 0.5*mountHeight]) rotate([270, 0, 0]) union() {
      cylinder(r=tensionerScrew/2, h=mountWidth+0.2);
      hexNutM4();
    }

  }
}

anchorPlate();
translate([anchorLength, -(mountWidth-anchorWidth)/2, anchorThickness-mountHeight]) bladeMount();