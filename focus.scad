

include <libraries/NopSCADlib-e5a38b37b3bf3278dea1beb750950f22401af77d/lib.scad>
include <libraries/gears/gears.scad>

NEMA17SB = ["NEMA17S", 42.3, 20, 53.6/2, 25, 11, 2, 5, 20, 31, [8, 8], 3, false, false, 0, 0];

module bosses(){
    //translate([27,20,0])
        //children();
    translate([-27,20,0])
        children();
    translate([27,-35,0])
        children();
}

module screws(){
    translate([0,0,30]){
        bosses(){
            screw(M5_cs_cap_screw, 30);
            translate([0,0,-30])
                scale([1,1,.5])
                    nut(M5_nut);
        }
    }
}

module screws_clearance(){
    translate([0,0,30]){
        bosses(){
            translate([0,0,-.1])
                screw_countersink(M5_cs_cap_screw, drilled = false);
            translate([0,0,.1])
                screw_countersink(M5_cs_cap_screw, drilled = false);
            translate([0,0,-32])
                cylinder(35,2.55,2.55);
            translate([0,0,-31.5])
                    nut(M5_nut);
        }
    }
}

t=4;
module outside(){
    union(){
        bosses(){
            cylinder(1, 7, 7, false);
        }
        hull(){
            cylinder(1, 30+t, 30+t, false);
            translate([0,-34.9,0]){
                cylinder(1, 12+t, 12+t, false);
                rotate([0,0,180])
                    NEMA_screw_positions(NEMA17SB, n = 2)
                        cylinder(1,7,7);
            }
        }
    }
}

module inside(){
    union(){
       cylinder(1, 29.5, 29.5, false);
        translate([0,-34.9,0])
            cylinder(1, 14, 14, false);
    }
}


module base(){
    difference(){
        scale([1,1,6.5])
            outside();

        translate([0,0,-1]){
            cylinder(3.5, 49/2, 49/2, false);
            for ( a = [0, 120, 240] )
                rotate([0,0,a])
                    translate([-20,0,0])
                        cylinder(50, 2,2, true);
            cylinder(50, 25/2,25/2, true);
        }

        screws_clearance();
        
        translate([0,-34.9,0-1]){
            cylinder(50, 3, 3, true);
        }
    }
}

module shell(){
    difference(){
        translate([0,0,6.5])
            scale([1,1,19])
                outside();
        
        scale([1,1,27])
            inside();
        
        screws_clearance();
    }
}

module top(){
    difference(){
        translate([0,0,25.5]){
            difference(){
                union(){
                    scale([1,1,4.5])
                        outside();
                    translate([0,0,-1])
                        inside();
                }
                translate([0,-34.9,4.5]){
                    rotate([0,180,0]){
                        NEMA(NEMA17SB);
                        cylinder(10,NEMA_big_hole(NEMA17SB)+.1,NEMA_big_hole(NEMA17SB)+.1);
                        NEMA_screw_positions(NEMA17SB, n = 4)
                            cylinder(5,1.7,1.7);
                        translate([0,0,3])
                            NEMA_screw_positions(NEMA17SB, n = 4)
                                cylinder(5,4,4);
                    }
                }
                translate([0,0,-2])
                    cylinder(20,11,11);
            }
        }
        screws_clearance();
    }
}

module hardware(){
    translate([0,0,25.5])
        translate([0,-34.9,4.5])
            rotate([0,180,180])
                NEMA(NEMA17S);
    screws();
    color("#b5a642"){
        union(){
            cylinder(12.5, 22.5/2, 22.5/2, false);
            cylinder(20, 19.5/2, 19.5/2, false);
        }
    }
}




module gears(){
    ha = 20;
    mod = 1.525;
    translate([0,0,12.5]){
        spur_gear (modul=mod, tooth_number=35, width=8, bore=19.5, pressure_angle=20, helix_angle=ha, optimized=false);
    }


    translate([0,-34.9,8.5]){
        rotate([0,0,16.5])
        spur_gear (modul=mod, tooth_number=11, width=15, bore=5, pressure_angle=20, helix_angle=-ha, optimized=false);
    }
}

*hardware();

*gears();

base();
color("cyan", .5){
    shell();
}
color("green", .5){
     top();
}



//pcb(ArduinoNano);