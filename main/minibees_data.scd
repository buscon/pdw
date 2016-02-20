(
var speedxyz1 = SensorData.new, speedxyz2 = SensorData.new, speedxyz3 = SensorData.new, speedxyz4 = SensorData.new, cook_minibees, changePos = 0, stlen= 5, ltlen = 50, debug = 0, oscar_there = 1, val = 0, data_sel, hyper_data_sel, group,
//minibee4 = 0,

//minibee1 = 5, minibee2 = 1,

//minibee1 = 9, minibee2 = 6,
//minibee1 = 7, minibee2 = 12,
//minibee1 = 0, minibee2 = 0,
//minibee4 = 8,

//minibee3 = 0,minibee4 = 0,

//minibee3 = 1,minibee4 = 8,


// runthrough: 3,7 - 1,8 -
sensitive = 0,
setup;
//~minibee1 = 0; ~minibee2 = 0;
//~minibee1 = 9; ~minibee2 = 6;
~oscar = NetAddr("192.168.1.7", 8000);
group = Group.basicNew(s,1);
//~minibee3 = 0; ~minibee1 = 0; ~minibee4 = 0; ~minibee2 = 0;

		//~sig1[0] = ~ibeat;

~val1 =0; ~val2 = 0; ~val3 =0; ~val4 = 0;

("/Users/marcello/Music/Supercollider/pdw/minibees/cook_minibees.scd").load;

("/Users/marcello/Music/Supercollider/pdw/minibees/data_selection.scd").load;

		OSCdef( \minibeeRouter, { |msg|
	var res;
	//~data_sel.value(((~val1 + ~val2 + ~val4)/3), 0, 8);

	res = case
	{ msg[1] == 1} {
		var data;
		data = ~cook_minibees.value(msg, speedxyz1, ~oscar, oscar_there, debug, stlen, ltlen );
		~data_sel.value(data[0], data[1], ~minibee1, group );
		~val1 = data[0];

	}
	{ msg[1] == 2} {
		var data;

		data = ~cook_minibees.value(msg, speedxyz2, ~oscar, oscar_there, debug, stlen, ltlen);
		~data_sel.value(data[0], data[1], ~minibee2, group );
		~val2 = data[0];

	}
	{ msg[1] == 3} {
		var data;

		data = ~cook_minibees.value(msg, speedxyz3, ~oscar, oscar_there, debug, stlen, ltlen);

		~data_sel.value(data[0], data[1], ~minibee3, group );
		~val3 = data[0];
	}
	{ msg[1] == 4} {
		var data;


		data = ~cook_minibees.value(msg, speedxyz4, ~oscar, oscar_there, debug, stlen, ltlen);

		~data_sel.value(data[0], data[1], ~minibee4, group );
				~val4 = data[0];


	};
	~medVal1 = (~val3 + ~val4)/2;
	~expVal1 = (pow(~val3,2) + pow(~val4,2)).sqrt;


}, "/minibee/data" ).permanent_(false);
)
