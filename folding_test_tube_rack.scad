module BulbJointMale(n=8, thickness=THICKNESS, wide=false) {
    circle_ratio = 0.6;
    x_additional_scale = 1.3;
    scale([2, 1, 1])
    for ( i = [0 : n-1] ) {
        hull() {
            if (wide == true) {
                translate([i*(3*r_bulb)+r_bulb, r_bulb, 0])
                    scale([x_additional_scale, 1, 1])
                        cylinder(r=r_bulb, h=thickness, $fn=RESOLUTION);
            } else {
                translate([i*(3*r_bulb)+r_bulb, r_bulb, 0])
                    cylinder(r=r_bulb, h=thickness, $fn=RESOLUTION);

            }
            translate([i*(3*r_bulb)+r_bulb, 0, 0])
                cylinder(r=circle_ratio*r_bulb, h=thickness, $fn=RESOLUTION);
        }
    }
}


module FoldPlate1() {
    difference() {
        cube([x_endplate, y_plate, THICKNESS]);

        // folding grooves
        translate([x_endplate-1, r_testtube+y_margin+r_testtube_foot+5, 0])
            cube([1, y_plate, THICKNESS]);
        translate([x_endplate-1, r_testtube+y_margin-r_testtube_foot-5, 0])
            mirror([0, 1, 0])
                cube([1, y_plate, THICKNESS]);

        // logo
        translate([8, r_testtube-y_margin, 0])
            BioClubLogo(fontsize);

        // socket for BottomPlate
        translate([2, y_plate/2, 0])
            cube([1, 7, 10], center=true);
    }
}


module FoldPlate2(with_pin=true, with_ear=false) {
    difference() {
        union() {
            cube([x_plate, y_plate, THICKNESS]);

            if (with_ear) {
                translate([x_plate, 0, 0])
                    cube([8, y_plate/2-r_testtube_foot, THICKNESS]);
                translate([x_plate, y_plate/2+r_testtube_foot, 0])
                    cube([8, y_plate/2-r_testtube_foot, THICKNESS]);
            }
        }

        translate([x_plate, r_testtube+y_margin, 0])
            cylinder(r=r_testtube_foot, h=THICKNESS);

        // folding grooves
        translate([0, r_testtube+y_margin+r_testtube_foot+5, 0])
            cube([1, y_plate, THICKNESS]);
        translate([0, r_testtube+y_margin-r_testtube_foot-5, 0])
            mirror([0, 1, 0])
                cube([1, y_plate, THICKNESS]);
        translate([x_plate-1, r_testtube+y_margin+r_testtube_foot+5, 0])
            cube([1, y_plate, THICKNESS]);
        translate([x_plate-1, r_testtube+y_margin-r_testtube_foot-5, 0])
            mirror([0, 1, 0])
                cube([1, y_plate, THICKNESS]);

        // pin
        if (with_pin) {
            rotate([0, 0, 270])
                translate([-y_plate/2-2*r_bulb, r_bulb/2, 0]) {
                    difference() {
                        BulbJointMale(1, wide=false);
                        translate([0.8, -0.2, 0])
                            scale([0.8, 0.9, 1])
                                BulbJointMale(1, wide=false);
                    }
                }
        }
    }
}


module FoldPlate3(with_pin=false, with_ear=false) {
    difference() {
        union() {
            cube([x_plate, y_plate, THICKNESS]);

            if (with_ear) {
                translate([x_plate, 0, 0])
                    cube([8, y_plate/2-r_testtube_foot, THICKNESS]);
                translate([x_plate, y_plate/2+r_testtube_foot, 0])
                    cube([8, y_plate/2-r_testtube_foot, THICKNESS]);
            }
        }
        translate([0, r_testtube+y_margin, 0])
            cylinder(r=r_testtube_foot, h=THICKNESS);

        // folding grooves
        translate([0, r_testtube+y_margin+r_testtube_foot+5, 0])
            cube([1, y_plate, THICKNESS]);
        translate([0, r_testtube+y_margin-r_testtube_foot-5, 0])
            mirror([0, 1, 0])
                cube([1, y_plate, THICKNESS]);
        translate([x_plate-1, r_testtube+y_margin+r_testtube_foot+5, 0])
            cube([1, y_plate, THICKNESS]);
        translate([x_plate-1, r_testtube+y_margin-r_testtube_foot-5, 0])
            mirror([0, 1, 0])
                cube([1, y_plate, THICKNESS]);

    }

    // pin
    if (with_pin) {
        rotate([0, 0, 270])
            translate([-y_plate/2-2*r_bulb, x_plate+r_bulb/2, 0]) {
                translate([0.8, -0.2, 0])
                    scale([0.8, 0.9, 1])
                        BulbJointMale(1, wide=false);
            }
    }
}


module FoldPlate4() {
    difference() {
        cube([x_endplate, y_plate, THICKNESS]);

        // folding grooves
        translate([0, r_testtube+y_margin+r_testtube_foot+5, 0])
            cube([1, y_plate, THICKNESS]);
        translate([0, r_testtube+y_margin-r_testtube_foot-5, 0])
            mirror([0, 1, 0])
                cube([1, y_plate, THICKNESS]);

        // pin
        rotate([0, 0, 270])
            translate([-y_plate/2-2*r_bulb, r_bulb/2, 0]) {
                difference() {
                    BulbJointMale(1, wide=false);
                    translate([0.8, -0.2, 0])
                        scale([0.8, 0.9, 1])
                            BulbJointMale(1, wide=false);
                }
            }

        // logo
        translate([8, r_testtube-y_margin, 0])
            BioClubLogo(fontsize);

        // socket for BottomPlate
        translate([x_endplate-2, y_plate/2, 0])
            cube([1, 7, 10], center=true);
    }
}


module OrigamiFoot(odd=false) {
    angle = 180-104.3;
    l_foot = 26.93;
    l_base = x_plate+l_foot*cos(angle);
    h = l_foot*sin(angle);

    if (odd == false) {

        mirror([1, 0, 0]) mirror([0, 1, 0]) {
            difference() {
                union() {
                    linear_extrude(height=THICKNESS)
                        polygon(points=[[0, 0], [x_plate, 0], [l_base, h]], paths=[[0, 1 ,2]]);

                    // joint
                    rotate([0, 0, atan(h/l_base)])
                        translate([20, 0, 0])
                            BulbJointMale(5, wide=true);
                }

                // folding groove
                for ( i = [0 : 10] ) {
                    translate([i*(5+12), -9, 0])
                        cube([12, 10, 10]);
                }

                // joint
                rotate([0, 0, atan(h/l_base)])
                        translate([20+6, 0, 0])
                            mirror([0, 1, 0])
                                BulbJointMale(4);
            }
        }

    } else {

        mirror([0, 1, 0]) {
            difference() {
                union() {
                    linear_extrude(height=THICKNESS)
                        polygon(points=[[0, 0], [x_plate, 0], [l_base, h]], paths=[[0, 1 ,2]]);

                    // joint
                    rotate([0, 0, atan(h/l_base)])
                        translate([20+6, 0, 0])
                            BulbJointMale(4, wide=true);
                }

                // folding groove
                for ( i = [0 : 10] ) {
                    translate([i*(5+12), -9, 0])
                        cube([12, 10, 10]);
                }

                // joint
                rotate([0, 0, atan(h/l_base)])
                        translate([20, 0, 0])
                            mirror([0, 1, 0])
                                BulbJointMale(5);
            }
        }

    }
}


module LegBand() {
    angle = 77.9;
    l_base = 56.76;
    h = 23.79 * sin(angle);

    mirror([1, 0, 0]) {
        difference() {
            union() {
                linear_extrude(height=THICKNESS)
                    polygon(points=[[0, 0], [l_base, 0], [l_base, h]], paths=[[0, 1 ,2]]);
                // joint
                rotate([0, 0, atan(h/l_base)])
                    translate([13, 0, 0])
                        BulbJointMale(4);
            }
            // folding groove
            for ( i = [0 : 4] ) {
                translate([i*(5+12), -9, 0])
                    cube([12, 10, 10]);
            }
        }
    }
}


module TopPlate(n) {
    x_offset = 5;
    l = n*interval_holes + 2 * x_offset;

    difference() {
        cube([l, y_plate, THICKNESS]);

        translate([x_offset, y_plate/2, 0])
            cube([1, 5.5, 2*THICKNESS], center=true);
        for ( i = [0 : n] ) {
            translate([x_offset + interval_holes/2 + i*interval_holes, y_plate/2, 0])
                cylinder(r=r_testtube, h=THICKNESS, $fn=RESOLUTION);

            translate([x_offset + i*interval_holes, y_plate/2, 0])
                cube([1, 5.5, 2*THICKNESS], center=true);
        }

    }
}


module BOTTOMPlate(n) {
    x = interval_holes * (n+1);
    cube([x, y_plate, THICKNESS]);
    rotate([0, 0, 90])
        translate([y_plate/2-2*r_bulb, r_bulb/2, 0])
            BulbJointMale(1, wide=false);
    rotate([0, 0, 270])
        translate([-y_plate/2-2*r_bulb, x+r_bulb/2, 0])
            BulbJointMale(1, wide=false);
}


module BioClubLogo(size) {
    difference() {
        linear_extrude(height=THICKNESS)
            text("BioClub", font="Liberation Sans:style=Bold", size=size);
        translate([0, -2, 0]) {
            translate([size*0.29, 0, 0])
                cube([3, y_plate, THICKNESS]);
            translate([size*1.65, 0, 0])
                cube([3, y_plate, THICKNESS]);
            translate([size*4.65, 0, 0])
                cube([3, y_plate, THICKNESS]);
        }
        translate([0, size*0.2, 0])
            cube([x_plate, 2, THICKNESS]);
    }
}



module AllModels() {

    translate([320, 30, 0])
        rotate([0, 0, 90])
            TopPlate(5);

    translate([280, 30, 0])
        rotate([0, 0, 90])
            BOTTOMPlate(5);

    translate([10, 30, 0]) {
        y_row_offset = 40;
        for ( i = [0 : n_row] ) {
            if (i%2 == 0) {
                if (i == 0) {
                    translate([0, i*(y_plate+y_row_offset), 0]) {
                        FoldPlate1();
                        translate([x_endplate, 0, 0])
                            OrigamiFoot();
                        translate([x_endplate, y_plate, 0])
                            LegBand();
                    }
                    translate([x_endplate, i*(y_plate+y_row_offset), 0]) {
                        difference() {
                            FoldPlate2();
                            // holes for LegBand
                            translate([9.5, 0, 0])
                                for ( i = [0 : 3] ) {
                                    translate([2*(i*(3*r_bulb)+r_bulb), y_plate-2, 0])
                                        cube([7, 1, 10]);
                            }
                        }
                        OrigamiFoot(odd=true);
                    }
                    translate([x_endplate+x_plate, i*(y_plate+y_row_offset), 0]) {
                        FoldPlate3(with_pin=true, with_ear=true);
                        mirror([0, 1, 0])
                            translate([x_plate, -y_plate, 0])
                                OrigamiFoot();
                        mirror([0, 1, 0])
                            translate([x_plate, 0, 0])
                                LegBand();
                    }
                } else {
                    translate([0, i*(y_plate+y_row_offset), 0]) {
                        FoldPlate3();
                        translate([x_plate, 0, 0])
                            OrigamiFoot();
                        translate([x_plate, y_plate, 0])
                            LegBand();
                    }
                    translate([x_plate, i*(y_plate+y_row_offset), 0]) {
                        difference() {
                            FoldPlate2();
                            // holes for LegBand
                            translate([9.5, 0, 0])
                                for ( i = [0 : 3] ) {
                                    translate([2*(i*(3*r_bulb)+r_bulb), y_plate-2, 0])
                                        cube([7, 1, 10]);
                            }
                        }
                        OrigamiFoot(odd=true);
                    }
                    translate([2*x_plate, i*(y_plate+y_row_offset), 0]) {
                        FoldPlate3(with_pin=true, with_ear=true);
                        mirror([0, 1, 0])
                            translate([x_plate, -y_plate, 0])
                                OrigamiFoot();
                        mirror([0, 1, 0])
                            translate([x_plate, 0, 0])
                                LegBand();
                    }
                }

            } else {

                translate([0, i*(y_plate+y_row_offset), 0]) {
                    difference() {
                        FoldPlate2(with_pin=false);
                        // holes for LegBand
                        translate([5.5, 0, 0])
                            for ( i = [0 : 3] ) {
                                translate([2*(i*(3*r_bulb)+r_bulb), 1, 0])
                                    cube([7, 1, 10]);
                        }
                    }
                    mirror([0, 1, 0])
                        translate([0, -y_plate, 0])
                            OrigamiFoot(odd=true);
                }
                translate([x_plate, i*(y_plate+y_row_offset), 0]) {
                    FoldPlate3();
                    translate([x_plate, 0, 0])
                        OrigamiFoot();
                    translate([x_plate, y_plate, 0])
                        LegBand();
                }
                if (i == n_row) {
                    translate([2*x_plate, i*(y_plate+y_row_offset), 0]) {
                        difference() {
                            FoldPlate4();
                            // holes for LegBand
                            translate([9.5, 0, 0])
                                for ( i = [0 : 3] ) {
                                    translate([2*(i*(3*r_bulb)+r_bulb), y_plate-2, 0])
                                        cube([7, 1, 10]);
                            }
                        }
                        OrigamiFoot(odd=true);
                    }
                } else {
                    translate([2*x_plate, i*(y_plate+y_row_offset), 0]) {
                        difference() {
                            FoldPlate2(, with_ear=true);
                            // holes for LegBand
                            translate([9.5, 0, 0])
                                for ( i = [0 : 3] ) {
                                    translate([2*(i*(3*r_bulb)+r_bulb), y_plate-2, 0])
                                        cube([7, 1, 10]);
                            }
                        }
                        OrigamiFoot(odd=true);
                    }
                }

            }
        } // for

    } // translate

}


r_testtube = 10;
r_testtube_foot = 7;
h_rack = 70;
y_margin = 3;
n_row = 3; // must be odd number

interval_holes = 10 + 2*r_testtube;
x_plate = sqrt(pow(interval_holes/2, 2) + pow(h_rack, 2));
y_plate = 2 * (y_margin + r_testtube);
x_endplate = x_plate * 1.14289705266;
fontsize = min(x_plate/2, y_plate/2);

THICKNESS = 1;
r_bulb = 2;
RESOLUTION = 100;


// a4 size
%cube([297, 210, 1]);

projection(cut=false)
    AllModels();
