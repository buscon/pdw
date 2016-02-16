/* TODO
- sensitive are needed
- refine the sounds:
- glitch_sound!
*/

("/Users/marcello/Music/Supercollider/PdW/drones/droneCymbal.scd").openTextFile;
(

("/Users/marcello/Music/Supercollider/pdw/main/synths.scd").load;
// 1 ibeat, 2, trigDrones, 3 gran1, 4 gran2, 5 ligeti, 6 \complexB, 7 ~pad, 8 ~stranga, 9 ~drC, 10 ~glitch_drones, 12 ~string

("/Users/marcello/Music/Supercollider/PdW/beat/irregular_beat.scd").load;

("/Users/marcello/Music/Supercollider/PdW/drones/triggering_drones_minibees.scd").load;
("/Users/marcello/Music/Supercollider/PdW/granular/granulator.scd").load;
//("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").load;
("/Users/marcello/Music/Supercollider/pdw/ligeti/main.scd").load;
("/Users/marcello/Music/Supercollider/pdw/pad/1.scd").load;
("/Users/marcello/Music/Supercollider/pdw/beat/glitch_coplexB.scd").load;
("/Users/marcello/Music/Supercollider/pdw/strings/1_new.scd").load;
("/Users/marcello/Music/Supercollider/PdW/drones/droneCymbal.scd").load;
("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").load;
("/Users/marcello/Music/Supercollider/pdw/glitch/glitch_drone.scd").load;
("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;

)

("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;
// coppie: 3/4 con 7, 5 con 1, 8 solo o con un basso di oscar o con 6, 6 con 9 o 12 oppure 9 con 12
(
var  sensitive = 0, aS, pS, stS, debug = 1,
data_sel, hyper_data_sel,
//which = 8, which2 =6,
which = 5, which2 =1,

which_osc = 'actN', port = 9000, now;
t = Main.elapsedTime.asInt;
now = (t.asInt)-0.1;

aS = Scale.bartok.ratios * 0.7;	// array of the pitches of the timpani
//aS = [50,70,90,Prand(aS),120,100, 150];
pS = Pxrand(aS, inf);				// make the Pattern
stS = pS.asStream;

		~sample_id1 = 2;
		~sample_id2 = 1;
("/Users/marcello/Music/Supercollider/pdw/motiontracking/sens_sel.scd").load;
("/Users/marcello/Music/Supercollider/pdw/motiontracking/centerx_sel.scd").load;
("/Users/marcello/Music/Supercollider/pdw/motiontracking/act_select.scd").load;
a = OSCdef( \actN, { |msg|
	var val = msg[1];
	var res;
	if(debug == 1, { (msg[0]++": "++val).postln; });
	~act_sel.value(val, which);
	}, "/activityNormal1",
nil, port);

a = OSCdef( \actN2, { |msg|
	var val = msg[1];
	var res;
	if(debug == 1, { (msg[0]++": "++val).postln; });
	~act_sel.value(val, which2);
	}, "/activityNormal2",
nil, port);

OSCdef( \centerX1, { |msg|
	var res, val = msg[1];
	if(debug == 1, { (msg[0]++": "++val).postln; });
	~cx_sel.value(val, which);

	}, "/centerX1",
	nil, port);

OSCdef( \centerX2, { |msg|
	var res, val = msg[1];
	if(debug == 1, { (msg[0]++": "++val).postln; });
	~cx_sel.value(val, which2);

	}, "/centerX2",
	nil, port);

OSCdef( \height, { |msg|
	var val = msg[1];
		if(debug == 1, { (msg[0]++": "++val).postln; });

			Ndef(\trigDrones).set(\select, (val.linlin(0.1, 0.9, 0, 1).round(0.1) ));
		}, "/height",
nil, port).permanent_(true);



OSCdef( \sensitive, { |msg|
	var res, val = msg[1];
		if(debug == 1, { (msg[0]++": "++val).postln; });

	~sens_sel.value(val, which);

	}, "/activitySensitive1",
nil, port).permanent_(true);

//a.permanent_(true);

)
Ndef(\trigDrones).set(\decaytime, 0.5);
	Synth(\trigDrones, [\volume, 0.5, \sensitive, 1, \rate, rrand(1, 2, \lpfFreq, rrand(1000, 4000)) ]);
FreqScope.new
Ndef(\trigDrones).set(\octave, 1);
