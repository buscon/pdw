/* TODO
- sensitive are needed
- refine the sounds:
- glitch_sound!
*/
FreqScope.new
("/Users/marcello/Music/Supercollider/PdW/drones/triggering_drones_minibees.scd").load;
("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").load;

("/Users/marcello/Music/Supercollider/PdW/drones/droneCymbal.scd").load;
("/Users/marcello/Music/Supercollider/PdW/ligeti/main.scd").load;
("/Users/marcello/Music/Supercollider/pdw/glitch/glitch_drone.scd").load;
(
m = NetAddr("127.0.0.1", 9000);
m.sendMsg("/centerX1", 0.7);
)
(
var  sensitive = 0, aS, pS, stS, debug = 1,
data_sel, hyper_data_sel, which_data = 6,
which_osc = 'actN', port = 9000, now;
t = Main.elapsedTime.asInt;
now = (t.asInt)-0.1;

aS = Scale.bartok.ratios * 0.7;	// array of the pitches of the timpani
//aS = [50,70,90,Prand(aS),120,100, 150];
pS = Pxrand(aS, inf);				// make the Pattern
stS = pS.asStream;



a = OSCdef( \actN, { |msg|
	var val = msg[1];
	var res;
	if(debug == 1, { (msg[0]++": "++val).postln; });
	res = case
		{ which_data == 0} {

	}
	{ which_data == 1} {
			// trig Drones
	Ndef(\trigDrones).set(\volume, val.linlin(0, 0.03, 0, 1.5));
	Ndef(\trigDrones).set(\volume2, val.linlin(0.1, 1, 1, 1.5));
	Ndef(\trigDrones).set(\speed, (val.linlin(0, 0.6, 2, 20) ));

	Ndef(\trigDrones).set(\rate, (val.linlin(0.85, 1, 1, 1.25) ));
	Ndef(\trigDrones).set(\lpfFreq, (val.linexp(0.1, 0.8, 600, 4000) ));

//	Ndef(\trigDrones).set(\sensitive, (val.linlin(0.01, 0.04, 0, 1) ));
		t = Main.elapsedTime.asInt;

		if( (val > 0.99) && (now < t),
			{

				"octave: ".post;
				Ndef(\trigDrones).set(\octave, ([1, (5/4), 3/2].wchoose([0.4,0.3,0.3]) ).postln );
				now = (t.asInt)+1;
				"now: ".post;now.postln;
				"time: ".post;t.postln;
			"=======".postln

		} );
	}
	{ which_data == 2 } {

			// strings
		~string.set( \volume, val.linlin(0, 0.0001 , 0, 0.3));
		~string.set( \volume2, val.linlin(0.4, 1 , 1, 2));

		~string.set( \sustain, val.linlin(0, 1 , 5, 0.1));
		~string.set( \freq, val.linexp(0.5, 1, 211, 250));
		~string.set( \lpfF, val.linexp(0.5, 1, 1000, 6000));

			//"dev: ".post;
			~string.set(\freq_dev, (val.linlin(0.4, 0.9, 0.1, 10) ));
			~string.set(\fdecay, (val.linexp(0.5, 1, 0.01, 3) ));
		~string.set( \freq2, val.linexp(0.8, 1, 0, 20));
		~string.set( \mx, val.linlin(0, 1, 0, 30));

	}
	{ which_data == 3 } {
/* todo:
	- sensitive with tail, release sound

		*/

		~drC.set(\volume, val.linlin(0.05, 0.15, 0, 2));
		//env = ControlSpec(100, 8000, 4); ~drC.set(\lowPassFreq, env.map(~expMa.linlin(0.1, touch_thres, 0, 1)).postln); env2 = ControlSpec(2, 1, 4); ~drC.set(\lowPassQ, env.map(~expMa.linlin(0.1, touch_thres, 0, 1)));
		~drC.set(\lowPassFreq, val.linexp(0.1, 0.8, 100, 8000)); ~drC.set(\lowPassQ, val.linlin(0.1, 1, 2, 1));


	}
	{ which_data == 4 } {

				~fw.set(\amp, val.linlin(0.05, 0.15, 0, 0.4));
							~fw.set(\amp2, val.linlin(0.6, 1, 1, 1.6));

			~fw.set(\step, val.linlin(0.1, 1, 0.3, 1));
			//~fw.set(\rate, val.linlin(0.5, 1, 10, 100));
			~fw.set(\scale_tones, val.linlin(0.3, 0.8, 1, 1.5));
			~fw.set(\deviation, val.linlin(0.1, 0.7, 20, 200));
	}

			{ which_data == 5 } {

				Ndef(\complexB).set(\volume, val.linlin(0, 0.05, 0, 0.5));
				Ndef(\complexB).set(\volume2, val.linlin(0.5, 1, 1, 2));
				Ndef(\complexB).set(\lpfFreq, val.linlin(0.05, 0.7, 50, 20000));
				Ndef(\complexB).set(\hpfFreq, val.linexp(0.8, 1, 10, 5000));

				Ndef(\complexB).set(\speed, val.linlin(0, 0.2, 2, 1.5));
			Ndef(\complexB).set(\speed2, val.linlin(0.85, 1, 0, -1.45));
	}
			{ which_data == 6 } {

			~glitch_drones.set(\volume, val.linlin(0, 0.05, 0, 0.01));
			~glitch_drones.set(\volume2, val.linlin(0.5, 1, 1, 2));

			~glitch_drones.set(\modAmp1, val.linlin(0.1, 1, 1, 10));

			~glitch_drones.set(\modF, val.linlin(0.1, 1, 0, 1));
			~glitch_drones.set(\modN, val.linlin(0.1, 1, 0, 1));
	};
	res;
	}, "/activityNormal1",
nil, port).permanent_(true);

OSCdef( \centerX, { |msg|
	var res, val = msg[1];
	if(debug == 1, { (msg[0]++": "++val).postln; });

	res = case
		{ which_data == 0} {

	}
	{ which_data == 1} {
			var list = Scale.bartok.ratios;

			Ndef(\trigDrones).set(\select, list[(val.linlin(0.1, 0.9, 1, list.size).round(1); )];);
	}
		{ which_data == 2} {
				~string.set( \freq_scale, val.linlin(0.01, 0.99 , 0.8, 1.2).round(0.2));
	}
		{ which_data == 3} {
					~drC.set(\freq_scale, val.linlin(0.1, 0.9, 0.5, 1.5).round(0.1));
	}
				{ which_data == 4} {

~fw.set(\scale_val, Scale.rast.ratios.choose.linlin(1, 1.9, 0.2, 0.7));
		}
				{ which_data == 5} {
	}
				{ which_data == 6} {
			//~glitch_drones.set(\modAmp1, val.linlin(0.1, 1, 1, 50));

			~glitch_drones.set(\modAmp2, val.linlin(0.1, 1, 1, 50));
			~glitch_drones.set(\modAmp3, val.linlin(0.1, 1, 1, 40));
			~glitch_drones.set(\gpos, val.linlin(0.1, 1, 0.1, 0.9));
			~glitch_drones.set(\modN, val.linlin(0.1, 1, 0.1, 0.9));

	};

	}, "/centerX1",
	nil, port).permanent_(true);
OSCdef( \height, { |msg|
	var val = msg[1];
		if(debug == 1, { (msg[0]++": "++val).postln; });

			Ndef(\trigDrones).set(\select, (val.linlin(0.1, 0.9, 0, 1).round(0.1) ));
		}, "/height",
nil, port).permanent_(true);



OSCdef( \sensitive, { |msg|
	var res, val = msg[1];
		if(debug == 1, { (msg[0]++": "++val).postln; });


	res = case
		{ which_data == 0} {

	}
	{ which_data == 1} {
		Synth(\trigDrones, [\volume, 1.5, \sensitive, 1, \rate, Scale.whole.ratios.choose, \lpfFreq, rrand(1000, 4000), \octave, 1.5 ]);

	}
		{ which_data == 2} {
			   Synth(\stringS, [\amp, 0.1]);sensitive = 1;

	}
	{ which_data == 3} {

	};
	res;
	}, "/activitySensitive1",
nil, port).permanent_(true);

//a.permanent_(true);

)
Ndef(\trigDrones).set(\decaytime, 0.5);
	Synth(\trigDrones, [\volume, 0.5, \sensitive, 1, \rate, rrand(1, 2, \lpfFreq, rrand(1000, 4000)) ]);
FreqScope.new
Ndef(\trigDrones).set(\octave, 1);
