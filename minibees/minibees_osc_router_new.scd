// todo

/*
- couple of sounds:
- \trigDrones with Oscar organic pdw1.wav
*/
("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").openTextFile;
(
// 1 ibeat, 2, trigDrones, 3 gran1, 4 gran2, 5 ligeti, 6 \complexB, 7 ~pad, 8 ~stranga

("/Users/marcello/Music/Supercollider/PdW/beat/irregular_beat.scd").load;

("/Users/marcello/Music/Supercollider/PdW/drones/triggering_drones_minibees.scd").load;
("/Users/marcello/Music/Supercollider/PdW/granular/granulator.scd").load;
//("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").load;
("/Users/marcello/Music/Supercollider/pdw/ligeti/main.scd").load;
("/Users/marcello/Music/Supercollider/pdw/pad/1.scd").load;
("/Users/marcello/Music/Supercollider/pdw/beat/glitch_coplexB.scd").load;
("/Users/marcello/Music/Supercollider/pdw/strings/1_new.scd").load;
)
Scale.bartok.ratios * 0.7
var ratef; ratef =   rrand(0.2, 2);Synth(\granS, [\bufNum, ~b[~sample_id].bufnum, \volume, rrand(1.5, 2.25), \rate, ratef.postln, \dur, rrand(0.2, 0.5), \pan, -1, \pos, ~samples_data[~sample_id][8].choose.postln, \cutoff, ratef.linlin(0.2, 2, 500, 3000)]);

~trigDrones.set(\octave, rrand(0.5,1.5).postln);
(
var speedxyz1 = SensorData.new, speedxyz2 = SensorData.new, speedxyz3 = SensorData.new, speedxyz4 = SensorData.new, cook_minibees, changePos = 0, oscar, stlen= 5, ltlen = 50, debug = 0, oscar_there = 0, val = 0, data_sel, hyper_data_sel,
minibee1 = 3, minibee2 =0 , minibee3 = 0, minibee4 = 4,
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

}, "/minibee/data" ).permanent_(false);
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