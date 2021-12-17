use <../_utils_v2/fillet.scad>
use <../_utils_v2/m3-m8.scad>

cmd="main/outer_3";

text="BP6";

thickness=2;
outer_thickness=[8,8,6];
top_thickness=[0,5];

block_dim=[16,16,12];
block_tr=[-block_dim.x/2,0,-block_dim.z-thickness];

ears_dim=[block_dim.x,block_dim.y,2];
ears_tr=[block_tr.x,block_tr.y,-thickness];
ears_size=[
	 [0,2]
	,[0,3+2]
	,[0,4,-1]
	,[0,4,-1]
];

throad_dim=[7+0.8,block_dim.z+thickness];
throad_tr=[-1.4,3.9,-block_dim.z-thickness*2];
throad_cut=[0.3,0.2];

throadfix_bottom=2;
throadfix_dim=[5,outer_thickness[2]-throadfix_bottom+0.01];
throadfix_dim_min=1;
throadfix_tr=[throad_tr.x,throad_tr.y,-block_dim.z-thickness*2-outer_thickness[2]+throadfix_bottom];
throadfix_cut=[0.3,0.2];

outer_cut_dim=[block_dim.x+thickness*2,block_dim.y+thickness*2,block_dim.z+thickness+ears_dim.z];
outer_cut_tr=[block_tr.x-thickness,-thickness,block_tr.z-thickness];

outer_dim=[outer_cut_dim.x+outer_thickness[0]*2,outer_cut_dim.y+outer_thickness[1]*2,outer_cut_dim.z+outer_thickness[2]];
outer_tr=[outer_cut_tr.x-outer_thickness[0],outer_cut_tr.y-outer_thickness[1],outer_cut_tr.z-outer_thickness[2]];

handle_screw_dim=[3.0,5.5,100];//[4.9,5.5,100];
handle_screw_tr=[0,block_dim.y/2,-block_dim.z-ears_dim.z+4];

screws_d=3;
screws_h=block_dim.y+thickness;
screws_tr=[
	 [0,0,-block_dim.z-thickness+8]
	,[0,0,-block_dim.z-thickness+2.5]
];
//screws_cut=[0.3,0.3];
screws_cut=[0.0,0.0];

heater_d=6;
heater_h=block_dim.x+thickness*2;
heater_tr=[-block_dim.x/2-thickness,block_dim.y-5.5,screws_tr[0].z];
//heater_cut=[0.3,0.3];
heater_cut=[0.0,0.0];

thermistor_d=3;
thermistor_h=heater_h;
thermistor_tr=[-block_dim.x/2-thickness,block_dim.y-3,screws_tr[1].z];
//thermistor_cut=[0.3,0.3];
thermistor_cut=[0.0,0.0];

top_down=1;
top_tr=[outer_tr.x-top_thickness[0],outer_tr.y-top_thickness[0],-top_down];
top_dim=[outer_dim.x+top_thickness[0]*2,outer_dim.y+top_thickness[0]*2,top_thickness[1]];

top_cut_offs=[0.3,0.2];
top_cut_dim=[outer_dim.x+top_cut_offs[0]*2,outer_dim.y+top_cut_offs[0]*2,outer_dim.z+top_cut_offs[1]];
top_cut_tr=[outer_tr.x-top_cut_offs[0],outer_tr.y-top_cut_offs[0],outer_tr.z+top_cut_offs[1]];

outer_screws=[
	 [
		 [outer_tr.x+3
		  ,outer_tr.y
		  ,outer_tr.z+outer_thickness[2]+(outer_dim.z-outer_thickness[2])/2]
		,[-90,90,0]
		, 12
	 ]
	,[
		 [outer_tr.x+3
		  ,outer_tr.y+outer_dim.y
		  ,outer_tr.z+outer_thickness[2]+(outer_dim.z-outer_thickness[2])/2]
		,[90,-90,0]
		, 12
	 ]
	,[
		 [outer_tr.x+outer_dim.x-3
		  ,outer_tr.y
		  ,outer_tr.z+outer_thickness[2]+(outer_dim.z-outer_thickness[2])/2]
		,[-90,-90,0]
		, 12
	 ]
	,[
		 [outer_tr.x+outer_dim.x-3
		  ,outer_tr.y+outer_dim.y
		  ,outer_tr.z+outer_thickness[2]+(outer_dim.z-outer_thickness[2])/2]
		,[90,90,0]
		, 12
	 ]
	 //bottom
	,[
		 [outer_tr.x+outer_dim.x/2
		  ,outer_tr.y+3
		  ,outer_tr.z]
		,[0,0,180]
		, 12
	 ]
	,[
		 [outer_tr.x+outer_dim.x/2
		  ,outer_tr.y+outer_dim.y-3
		  ,outer_tr.z]
		,[0,0,0]
		, 12
	 ]
	,[
		 [outer_tr.x+3
		  ,outer_tr.y+outer_dim.y/2
		  ,outer_tr.z]
		,[0,0,90]
		, 12
	 ]
	,[
		 [outer_tr.x+outer_dim.x-3
		  ,outer_tr.y+outer_dim.y/2
		  ,outer_tr.z]
		,[0,0,-90]
		, 12
	 ]
	 //top
	,[
		 [outer_tr.x+outer_dim.x/2
		  ,outer_tr.y+3
		  ,outer_tr.z+outer_dim.z+top_thickness[1]]
		,[180,0,0]
		, 12
	 ]
	,[
		 [outer_tr.x+outer_dim.x/2
		  ,outer_tr.y+outer_dim.y-3
		  ,outer_tr.z+outer_dim.z+top_thickness[1]]
		,[180,0,180]
		, 12
	 ]
	,[
		 [outer_tr.x+3
		  ,outer_tr.y+outer_dim.y/2
		  ,outer_tr.z+outer_dim.z+top_thickness[1]]
		,[180,0,-90]
		, 12
	 ]
	,[
		 [outer_tr.x+outer_dim.x-3
		  ,outer_tr.y+outer_dim.y/2
		  ,outer_tr.z+outer_dim.z+top_thickness[1]]
		,[180,0,90]
		, 12
	 ]
];

module symbol()
{
	w=3;
	h=2;
	l=2;
	rotate ([90,0,0])
	translate ([0,0,-l/2])
	linear_extrude(l)
	polygon([
		 [0,-h]
		,[w,h]
		,[-w,h]
	]);
}

module inner(thermo="")
{
	difference()
	{
		union()
		{
			translate (block_tr)
				cube (block_dim);
	
			translate (throad_tr)
				cylinder (d=throad_dim.x,h=throad_dim.y,$fn=80);
			translate (throadfix_tr)
				cylinder (d1=throadfix_dim_min,d2=throadfix_dim.x,h=throadfix_dim.y,$fn=80);
			difference()
			{
				translate (ears_tr)
					cube (ears_dim);
				difference()
				{
					union()
					{
						union()
						{
							ea=ears_size[0];
							translate (ears_tr)
							translate ([ea[0],0,0])
								cube ([ears_dim.x-ea[0]*2,ea[1],ears_dim.z+0.01]);
						}
		
						union()
						{
							ea=ears_size[1];
							translate (ears_tr)
							translate ([ea[0],ears_dim.y-ea[1],0])
								cube ([ears_dim.x-ea[0]*2,ea[1],ears_dim.z+0.01]);
						}
						union()
						{
							ea=ears_size[2];
							translate (ears_tr)
							translate ([0,ea[0]+ea[2],0])
								cube ([ea[1],ears_dim.y-ea[0]*2,ears_dim.z+0.01]);
						}
						union()
						{
							ea=ears_size[3];
							translate (ears_tr)
							translate ([ears_dim.x-ea[1],ea[0]+ea[2],0])
								cube ([ea[1],ears_dim.y-ea[0]*2,ears_dim.z+0.01]);
						}
					}
					translate ([throad_tr.x,throad_tr.y,ears_tr.z-0.1])
						cylinder (d=throad_dim.x,h=throad_dim.y,$fn=80);
				}
			}
			
			for (tr=screws_tr)
				translate (tr)
				rotate ([-90,0,0])
					cylinder (d=screws_d,h=screws_h,$fn=40);
					
			if (thermo=="left")
			{
				translate (heater_tr)
				rotate ([0,90,0])
					cylinder (d=heater_d,h=heater_h/2,$fn=40);
				
				translate (thermistor_tr)
				rotate ([0,90,0])
					cylinder (d=thermistor_d,h=thermistor_h/2,$fn=40);			
			}
			else
			if (thermo=="right")
			{
				translate (heater_tr)
				rotate ([0,90,0])
				translate ([0,0,heater_h/2])
					cylinder (d=heater_d,h=heater_h/2,$fn=40);
				
				translate (thermistor_tr)
				rotate ([0,90,0])
				translate ([0,0,thermistor_h/2])
					cylinder (d=thermistor_d,h=thermistor_h/2,$fn=40);
			}
			else
			{
				translate (heater_tr)
				rotate ([0,90,0])
					cylinder (d=heater_d,h=heater_h,$fn=40);
				
				translate (thermistor_tr)
				rotate ([0,90,0])
					cylinder (d=thermistor_d,h=thermistor_h,$fn=40);
			}
		}
		
		translate (handle_screw_tr)
		rotate ([0,0,0])
			cylinder (d=handle_screw_dim.x,h=handle_screw_dim[2],$fn=40);
	}
}

module outer()
{
	difference()
	{
		translate (outer_tr)
			cube (outer_dim);
		
		translate (outer_tr)
		translate ([10,0,outer_dim.z/2])
			symbol();
		//888888888
		translate (outer_cut_tr)
		{
			cube (outer_cut_dim);
			
			translate ([outer_cut_dim.x/2,0.01,outer_cut_dim.z/2])
			rotate ([90,0,0])
			linear_extrude(0.8)
				text (text=text
					,halign="center"
					,valign="center"
					,size=8
					,font="Chilanka"
				);
		}
		translate (throad_tr)
		translate ([0,0,-throad_cut[1]])
			cylinder (d=throad_dim.x+throad_cut[0]*2,h=throad_dim.y+throad_cut[1],$fn=80);
		translate (throadfix_tr)
		translate ([0,0,-throadfix_cut[1]])
			cylinder (d1=throadfix_dim_min+throadfix_cut[0]*2
					,d2=throadfix_dim.x+throadfix_cut[0]*2
					,h=throadfix_dim.y+throadfix_cut[1],$fn=80);
		
	
		for (tr=screws_tr)
			translate (tr)
			rotate ([-90,0,0])
			hull()
			{
				cylinder (d=screws_d+screws_cut[0]*2,h=screws_h+screws_cut[1],$fn=40);
				translate ([0,-20,0])
					cylinder (d=screws_d+screws_cut[0]*2,h=screws_h+screws_cut[1],$fn=40);
			}
		translate (heater_tr)
		rotate ([0,90,0])
		translate([0,0,-heater_cut[1]])
		hull()
		{
			cylinder (d=heater_d+heater_cut[0]*2,h=heater_h+heater_cut[1]*2,$fn=40);
			translate ([-20,0,0])
				cylinder (d=heater_d+heater_cut[0]*2,h=heater_h+heater_cut[1]*2,$fn=40);
		}
		translate (thermistor_tr)
		rotate ([0,90,0])
		translate([0,0,-thermistor_cut[1]])
		hull()
		{
			cylinder (d=thermistor_d+thermistor_cut[0]*2,h=thermistor_h+thermistor_cut[1]*2,$fn=40);
			translate ([-20,0,0])
				cylinder (d=thermistor_d+thermistor_cut[0]*2,h=thermistor_h+thermistor_cut[1]*2,$fn=40);
		}
	}
}

module outer_bottom_cut(offs=0)
{
	translate ([outer_tr.x,outer_tr.y,outer_cut_tr.z+offs])
		cube(outer_dim);
}

module outer1_cut(offs=0)
{
	translate ([outer_tr.x+outer_cut_dim.x+outer_thickness[0],outer_tr.y+outer_thickness[1]+offs,outer_cut_tr.z+offs])
		cube([outer_dim.x,outer_dim.y-outer_thickness[1]*2-offs*2,outer_dim.z]);
}

module outer2_cut(offs=0)
{
	translate ([outer_tr.x-outer_cut_dim.x-outer_thickness[0],outer_tr.y+outer_thickness[1]+offs,outer_cut_tr.z+offs])
		cube([outer_dim.x,outer_dim.y-outer_thickness[1]*2-offs*2,outer_dim.z]);
}

module outer3_cut(offs=0)
{
	translate ([outer_tr.x,outer_tr.y+outer_dim.y/2,outer_cut_tr.z+offs])
		cube([outer_dim.x,outer_dim.y,outer_dim.z]);
}

module outer_bottom()
{
	difference()
	{
		outer();
		outer_bottom_cut();
		outer_fix();
	}
}

module outer_1()
{
	difference()
	{
		intersection()
		{
			outer();
			outer_bottom_cut(offs=0.1);
			outer1_cut(offs=0.1);
		}
		outer_fix();
	}
}

module outer_2()
{
	difference()
	{
		intersection()
		{
			outer();
			outer_bottom_cut(offs=0.1);
			outer2_cut(offs=0.1);
		}
		outer_fix();
	}
}

module outer_3()
{
	difference()
	{
		intersection()
		{
			outer();
			outer_bottom_cut(offs=0.1);
		}
		outer1_cut();
		outer2_cut();
		outer3_cut();
		outer_fix();
	}
}

module outer_4()
{
	difference()
	{
		intersection()
		{
			outer();
			outer_bottom_cut(offs=0.1);
			outer3_cut(offs=0.1);
		}
		outer1_cut();
		outer2_cut();
		outer_fix();
	}
}

module outer_fix()
{
	for (s=outer_screws)
		translate (s[0])
		rotate (s[1])
		{
			m3_screw(h=s[2]);
			translate ([0,0,s[2]-2])
				m3_square_nut();
		}
}

module top()
{
	difference()
	{
		translate (top_tr)
			cube (top_dim);
		translate (top_cut_tr)
			cube (top_cut_dim);
		translate (handle_screw_tr)
		rotate ([0,0,0])
			cylinder (d=handle_screw_dim.y,h=handle_screw_dim[2],$fn=40);
		outer_fix();
	}
}

module list(s)
{
	echo(str("list:",s));
}

if (cmd=="list")
{
	list("main/outer_bottom");
	list("main/outer_1");
	list("main/outer_2");
	list("main/outer_3");
	list("main/outer_4");
	list("main/top");
	list("main/inner");
	list("main/inner_right");
	list("main/inner_left");
}
if (cmd=="main/outer_bottom")
{
	rotate ([0,0,0])
		outer_bottom();
}
if (cmd=="main/outer_1")
{
	rotate ([0,-90,0])
		outer_1();
}
if (cmd=="main/outer_2")
{
	rotate ([0,90,0])
		outer_2();
}
if (cmd=="main/outer_3")
{
	rotate ([-90,0,0])
		outer_3();
}
if (cmd=="main/outer_4")
{
	rotate ([90,0,0])
		outer_4();
}
if (cmd=="main/top")
{
	rotate ([180,0,0])
		top();
}
if (cmd=="main/inner")
{
	rotate ([180,0,0])
		inner();
}
if (cmd=="main/inner_right")
{
	rotate ([180,0,0])
		inner(thermo="right");
}
if (cmd=="main/inner_left")
{
	rotate ([180,0,0])
		inner(thermo="left");
}
if (cmd=="")
{
	//inner(thermo="left");
	//outer();
	if (1)
	{
		//outer_1();
		//outer_2();
		outer_3();
		//outer_4();
		//outer_bottom();
	}	
	//top();
}
