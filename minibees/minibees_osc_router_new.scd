// todo

/*
- couple of sounds:
- \trigDrones with Oscar organic pdw1.wav
*/
("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").openTextFile;
(
("/Users/marcello/Music/Supercollider/PdW/beat/irregular_beat.scd").load;


("/Users/marcello/Music/Supercollider/PdW/drones/triggering_drones_minibees.scd").load;
("/Users/marcello/Music/Supercollider/PdW/granular/granulator.scd").load;
("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").load;
("/Users/marcello/Music/Supercollider/pdw/pad/1.scd").load;
)


(
var speedxyz1 = SensorData.new, speedxyz2 = SensorData.new, speedxyz3 = SensorData.new, speedxyz4 = SensorData.new, cook_minibees, changePos = 0, oscar, stlen= 5, ltlen = 50, debug = 0, oscar_there = 0, val = 0, data_sel, hyper_data_sel,
minibee1 = 6, minibee2 =5 , minibee3 = 0, minibee4 = 0,
sensitive = 0,
setup;

oscar = NetAddr("192.168.1.7", 8000);



		//~sig1[0] = ~ibeat;

~val1 =0; ~val2 = 0; ~val3 =0; ~val4 = 0;
("/Users/marcello/Music/Supercollider/pdw/minibees/cook_minibees.scd").load;

("/Users/marcello/Music/Supercollider/pdw/minibees/data_selection.scd").load;

		OSCdef( \minibeeRouter, { |msg|
	var res;
	res = case
	{ msg[1] == 1} {
		var data;
		data = ~cook_minibees.value(msg, speedxyz1, oscar, oscar_there, debug, stlen, ltlen );
		~data_sel.value(data[0], data[1], minibee1 );
		~val1 = data[0];

	}
	{ msg[1] == 2} {
		var data;

		data = ~cook_minibees.value(msg, speedxyz2, oscar, oscar_there, debug, stlen, ltlen);
		~data_sel.value(data[0], data[1], minibee2 );
		~val2 = data[0];

	}
	{ msg[1] == 3} {
		var data;

		data = ~cook_minibees.value(msg, speedxyz3, oscar, oscar_there, debug, stlen, ltlen);

		~data_sel.value(data[0], data[1], minibee3 );
		~val3 = data[0];
	}
	{ msg[1] == 4} {
		var data;


		data = ~cook_minibees.value(msg, speedxyz4, oscar, oscar_there, debug, stlen, ltlen);

		~data_sel.value(data[0], data[1], minibee4 );
				~val4 = data[0];


	};

	}, "/minibee/data" );
)


(
	m = SWPlotterMonitor.new( {
    //data to plot
    [
    [ ~val1, ~val2, ~val3, ~val4], // view the two streams superimposed
//    [e, f], // view the two streams superimposed

    //[~e - ~f], // view their differene
    //[(~e- ~f).sign] // view sign of difference
    ]},
    200, //nr of points to plot
    4, // channels
    0.25, // plot dtime
    1 // write every n data points
    ).start;
)
m.stop
Scale.rast.ratios
pentatonic.ratios
1.0.bilinrand
1.0.gauss
		"pos: ".post;~gran1.set( \pos, ~samples_data[~sample_id][8].choose.postln);
		~gran1.set( \rate, rrand(0.2, 0.8).postln);
		~gran1.set( \rate, rrand(1.4, 1.7).postln);