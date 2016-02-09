//("/Users/marcello/Music/Supercollider/PdW/drones/triggering_drones_minibees.scd").openTextFile;
/*
sensitive:
- also pitch based, like the other sounds
- quieter

arms:
- more range of pitch
*/
("/Users/marcello/Music/Supercollider/PdW/drones/triggering_drones_minibees.scd").load;
("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").load;

("/Users/marcello/Music/Supercollider/PdW/drones/droneCymbal.scd").load;
("/Users/marcello/Music/Supercollider/PdW/ligeti/main.scd").load;

(
var  sensitive = 0, aS, pS, stS,
data_sel, hyper_data_sel, which_data = 1,
which_osc = 'actN', port = 9000, now;
t = Main.elapsedTime.asInt;
now = (t.asInt)-0.1;

aS = Scale.bartok.ratios * 0.7;	// array of the pitches of the timpani
//aS = [50,70,90,Prand(aS),120,100, 150];
pS = Pxrand(aS, inf);				// make the Pattern
stS = pS.asStream;




OSCdef( \actN1, { |msg|
	var val = msg[1], res;

	res = case
	{ which_data == 1} {
		~string.set( \volume, val.linlin(0, 0.0001 , 0, 0.5));
		~string.set( \sustain, val.linlin(0, 1 , 5, 0.1));

		~string.set( \mx, val.linlin(0, 1, 0, 40));
	};
	res;

	}, "/activityNormal1",
nil, port);
OSCdef( \actN2, { |msg|
	var val = msg[1], res;
	res = case
	{ which_data == 1} {
		~string2.set( \volume, val.linlin(0, 0.0001 , 0, 0.5));
		~string2.set( \sustain, val.linlin(0, 1 , 5, 0.1));

		~string2.set( \mx, val.linlin(0, 1, 0, 40));
	};
	res;

	}, "/activityNormal2",
nil, port);

OSCdef( \aSR, { |msg|
	var val = msg[1], res;
		res = case
	{ which_data == 1} {
		~string.set( \freq, val.linlin(0, 1, 211, 250));

		~string.set( \freq2, val.linlin(0, 1, 0, 100));
		~string.set( \freq_dev, val.linlin(0, 1, 0.2, 1));
	};
	res;

	}, "/armSideRight",
nil, port);
OSCdef( \aSL, { |msg|
	var val = msg[1], res;
		res = case
	{ which_data == 1} {
		~string2.set( \freq, val.linlin(0.5, 1, 211/2, 250/2));

		~string2.set( \freq2, val.linlin(0.8, 1, 0, 100));
			~string2.set( \freq_dev, val.linlin(0, 1, 0.2, 1));

	};
	res;

	}, "/armSideLeft",
nil, port);

)
(
var which =1;
OSCdef( \sensitive1, { |msg|
	var res, val = msg[1].postln;

	res = case
		{ which == 0} {

	}
	{ which == 1} {
		val.postln;
	Synth(\stringS);
	};
	res;
	}, "/activitySensitive1",
nil, 9000);
OSCdef( \sensitive2, { |msg|
	var res, val = msg[1].postln;

	res = case
		{ which == 0} {

	}
	{ which == 1} {
		val.postln;
	Synth(\stringS);
	};
	res;
	}, "/activitySensitive2",
nil, 9000);
)
FreqScope.new
