/* todo
- lag the volume of most of the sounds with Lag2UD


- couple of sounds:
Szene1  5 ligeti with preset 3 oscar (granular like) /soundA 2
/soundA 3 => other kind of granular
Szene2a oder übergang 3-4 7 pad with wind /soundB 3
Szene2b 1 ibeat with?
Szene3 6 beat, 9 drC
Szene4 solo 8
übergang? 3 granular with bass oscar, /soundA 1
Szene5 solo 12

- 7, 8:
*pan the sounds!
*make them more different

*/

// 7,8

Synth(\droneCymbal, [ \lowPassFreq , rrand(100, 8000).postln, \lowPassQ, rrand(1,2).postln, \freq_scale, rrand(0.5, 1.2), \volume, rrand(0.2, 0.5), \pan, -1]);

~pad.set(\scale_freq, (Scale.bartok.ratios.choose * 0.5).postln);
~stranga.set(\pitch, (Scale.bartok.ratios.choose * 0.3).postln);
~pad.set(\pan,-1);
~fw.set(\pan, 1);
~fw.set(\scale_val, 1;);
Synth(\padS, [\volume, 0.5, \pan, 1]);

("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").openTextFile;
("/Users/marcello/Music/Supercollider/pdw/minibees/cook_minibees.scd").openTextFile;
("/Users/marcello/Music/Supercollider/PdW/beat/irregular_beat.scd").openTextFile
("/Users/marcello/Music/Supercollider/pdw/pad/1.scd").openTextFile;
("/Users/marcello/Music/Supercollider/PdW/drones/droneCymbal.scd").openTextFile;


(
("/Users/marcello/Music/Supercollider/pdw/main/reverb.scd").load;
("/Users/marcello/Music/Supercollider/pdw/main/synths.scd").load;
// 1 ibeat, 2, trigDrones, 3 gran1, 4 gran2, 5 ligeti, 6 \complexB, 7 ~pad, 8 ~stranga

("/Users/marcello/Music/Supercollider/PdW/beat/irregular_beat.scd").load;

("/Users/marcello/Music/Supercollider/PdW/drones/triggering_drones_minibees.scd").load;
("/Users/marcello/Music/Supercollider/PdW/granular/granulator.scd").load;
("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").load;
("/Users/marcello/Music/Supercollider/pdw/ligeti/main.scd").load;
("/Users/marcello/Music/Supercollider/pdw/pad/1.scd").load;
("/Users/marcello/Music/Supercollider/PdW/drones/droneCymbal.scd").load;

("/Users/marcello/Music/Supercollider/pdw/beat/glitch_coplexB.scd").load;
("/Users/marcello/Music/Supercollider/pdw/strings/1_new.scd").load;

("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;

)
("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;

Scale.bartok.ratios * 0.7
~string.set(\freq_dev, 0.5);
var ratef; ratef =   rrand(0.2, 2);Synth(\granS, [\bufNum, ~b[~sample_id].bufnum, \volume, rrand(1.5, 2.25), \rate, ratef.postln, \dur, rrand(0.2, 0.5), \pan, -1, \pos, ~samples_data[~sample_id][8].choose.postln, \cutoff, ratef.linlin(0.2, 2, 500, 3000)]);

~trigDrones.set(\octave, rrand(0.5,1.5).postln);
~minibee2 = 5; //

~gran1.set(\rate, (Scale.bartok.ratios.choose * 0.7).postln);
(
~minibee3 = 5; ~minibee1 = 1; ~minibee4 = 0;
("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;
// 1: more variations, especially by command line. more little sounds at the beginning
// 5: longer release of the sound (not sensitive)
)
~fw.set(\scale_val, (Scale.bartok.ratios.choose * 1.2).postln)

(
~minibee3 = 0; ~minibee1 = 0;
~minibee3 = 6; ~minibee1 = 9;
("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;
// 6: pops (or maybe 9?), with hyper
// 9: more volume, 2 volumes

)
(
~minibee3 = 0; ~minibee1 = 0;

~minibee3 = 7; ~minibee1 = 0; // Oscar wind sound => for Martina
("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;
)
~string.set(\freq_scale, (Scale.bartok.ratios.choose * 0.8).postln);
~pad.set(\scale_freq, (Scale.bartok.ratios.choose * 0.5).postln);

(
~minibee3 = 0; ~minibee1 = 0; ~minibee4 = 8;
("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;
// 8: longer release when volume goes to 0 => lag beim volume
)
(
~minibee1 = 12; ~minibee2 = 0; ~minibee4 = 0;
("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;
)
(
/* coppie:
3/4 con 7,
Szene 1: 5 martina 1 rebekka
Szene 2: 6 martina 9 rebekka
Szene 3: 12 martina, 7 rebekka
Szene 4: Johanna solo, 8 Johanna
Szene 5: all 3 together

8 solo o con un basso di oscar o con 6,
6 con 9 o 12 oppure 9 con 12

*/

var speedxyz1 = SensorData.new, speedxyz2 = SensorData.new, speedxyz3 = SensorData.new, speedxyz4 = SensorData.new, cook_minibees, changePos = 0, stlen= 5, ltlen = 50, debug = 0, oscar_there = 1, val = 0, data_sel, hyper_data_sel, group
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


(
	m = SWPlotterMonitor.new( {
    //data to plot
    [
    [ ~val1, ~val2, ~val3, ~val4], // view the two streams superimposed

 //   [ ~val3, ~val4, ~medVal1, ~expVal1], // view the two streams superimposed
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