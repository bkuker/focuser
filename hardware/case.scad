
module electronics(){
    translate([0,0,1.4]){
        color("green")
            cube([31,70,2]);
            translate([2.3,70-43-2.5,13])
        color("blue")
            cube([18,43,1.5]);
        color("gray"){
            translate([2.3+18/2-8/2,60,14.5]){
                cube([8,10,4]);
            }
        }
    }
}

*electronics();

    t = 2;
    s=.5;

module case(){
        

    union(){
        difference(){
            translate([-(t+s),-(t+s),-t]){
                cube([33.5+2*s+t*2,70+2*s+t*2,24+t*2]);
            }
            translate([-s,-s,0])
            cube([33.5+2*s,70+2*s,24]);
            
            translate([2.3+18/2-11/2-.25,60,1.5+14.5-5/2-.5]){
                cube([11.5,20,10]);
            }
            
            translate([27, 80, 15])
                rotate([90,0,0])
                    cylinder(20,11.5/2,11.5/2);
            
            translate([(33.5+2*s+t*2)/2-(t+s),0,15])
                cube([12.5,20,6],true);
        }
        
        difference(){
            union(){
                translate([-s,-s,0])
                    cube([2,70,5]);
                translate([30-s*2,0,0])
                    cube([5,70,5]);
            }
            electronics();
        }
        
    }
}

intersection(){
    case();
    cube([100,100,100], true);
}

translate([0,20,0])
    difference(){
        case();
        cube([100,100,100], true);
    }

!translate([(33.5+2*s+t*2)/2-(t+s),-t-s-10,15]){
    difference(){
        rotate([90,0,0])
            cylinder(3,10,11.5/2);
        translate([0,0,-12])
            cube([5,10,20],true);
    }
}
    
    
    
    
    