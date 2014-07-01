// Stand for a phone
// Rounded corners
// Accounts for phone thickness, width, & center of mass
// Default values are for the Nexus S: 
// 11.3mm wide end, 9mm narrow end, but 11.3mm works for both

lscreen=100;
angle=10;
tstand=7;
hstand=20;
lphone=150;
wphone=68;
function cg(tphone)=(wphone/2+tstand+tphone/2*sin(angle))*sin(angle);
lfoot=50;

stand(11.3);
//stand(9);

module phone(tphone){
	rotate([0,angle,0]) translate([0,0,wphone/2+tstand+tphone/2*sin(angle)]) cube([tphone,lphone,wphone],center=true);
}

module vertical(tphone){
	lvertical=2*tstand+tphone;
	hcutout=lvertical/2*sin(angle);
	difference(){
		rotate([0,angle,0]){
			translate([tphone/2,0]) cylinder(r=tstand,h=hstand);
			translate([-tphone/2,0]) cylinder(r=tstand,h=hstand);
			translate([tphone/2,0,hstand]) sphere(r=tstand);
			translate([-tphone/2,0,hstand]) sphere(r=tstand);
			translate([0,0,hstand/2]) cube([tphone,2*tstand,hstand],center=true);
		}
		translate([0,0,-hcutout/2]) cube([2*lvertical,tstand*2+1,hcutout],center=true);
	}
}

module foot(tphone){
	translate([cg(tphone),0]) difference(){
		union(){
			rotate([0,90,0]){
				cylinder(r=tstand,h=lfoot,center=true);
				translate([0,0,lfoot/2]) sphere(r=tstand);
				translate([0,0,-lfoot/2]) sphere(r=tstand);
			}
		}
		translate([0,0,-tstand/2-1]) cube([lfoot+2*tstand+1,2*tstand+1,tstand+2],center=true);
	}
}

module stand(tphone){
	difference(){
		union(){
			vertical(tphone);
			foot(tphone);
		}
		phone(tphone);
	}
}


