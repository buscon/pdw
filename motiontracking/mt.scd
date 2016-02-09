
("/Users/marcello/Music/Supercollider/PdW/drones/triggering_drones_minibees.scd").load;
("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").load;

("/Users/marcello/Music/Supercollider/PdW/drones/droneCymbal.scd").loa
("/Users/marcello/Music/Supercollider/PdW/ligeti/main.scd").load;

(
var  sensitive = 0, aS, pS, stS,
data_sel, hyper_data_sel, which_data = 4,
which_osc = 'actN', port = 9000, now;
t = Main.elapsedTime.asInt;
now = (t.asInt)-0.1;

aS = Scale.bartok.ratios * 0.7;	// array of the pitches of the timpani
//aS = [50,70,90,Prand(aS),120,100, 150];
pS = Pxrand(aS, inf);				// make the Pattern
stS = pS.asStream;

data_sel = { arg val, which, which_osc;

	var res;
	res = case
		{ which == 0} {

	}
	{ which == 1} {
			// trig Drones
		var resu;
		resu = case
		{ which_osc == 'actN1'}
		{
			Ndef(\trigDrones).set(\volume, val.linlin(0, 0.06, 0, 1));
	Ndef(\trigDrones).set(\volume2, val.linlin(0.1, 1, 1, 2));
	Ndef(\trigDrones).set(\speed, (val.linlin(0.06, 0.8, 0, 15) ));
	Ndef(\trigDrones).set(\rate, (val.linlin(0.85, 1, 1, 1.25) ));

	Ndef(\trigDrones).set(\sensitive, (val.linlin(0.05, 0.06, 0, 1) ));
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
		{ which_osc == 'centerX1'}
		{
	Ndef(\trigDrones).set(\select, (val.linlin(0.1, 0.9, 0, 1) ).postln);
		};
		resu;
	}
	{ which == 2 } {

			// strings
		var resu;

		resu = case
		{ which_osc == 'actN1'}
		{

		~string.set( \amp, val.linlin(0, 0.0001 , 0, 1));
		~string.set( \sustain, val.linlin(0, 1 , 5, 0.1));
		~string.set( \freq, val.linexp(0.5, 1, 211, 250));

		~string.set( \freq2, val.linexp(0.8, 1, 0, 100));
		~string.set( \mx, val.linlin(0, 1, 0, 40));

		if((sensitive == 0) && (val > 0.04), {   Synth(\stringS);sensitive = 1;});
		if((val < 0.04), { sensitive = 0; });

		}
		{ which_osc == 'centerX1'}
		{
			~string.set( \freq_scale, val.linlin(0.01, 0.99 , 0.8, 1.2).round(0.2).postln);
		};
		resu;

	}
	{ which == 3 } {
				var resu;

		resu = case
		{ which_osc == 'actN1'}
		{
		~drC.set(\volume, val.linlin(0.05, 0.15, 0, 0.7));
		//env = ControlSpec(100, 8000, 4); ~drC.set(\lowPassFreq, env.map(~expMa.linlin(0.1, touch_thres, 0, 1)).postln); env2 = ControlSpec(2, 1, 4); ~drC.set(\lowPassQ, env.map(~expMa.linlin(0.1, touch_thres, 0, 1)));
		~drC.set(\lowPassFreq, val.linexp(0.1, 0.8, 100, 5000)); ~drC.set(\lowPassQ, val.linlin(0.1, 1, 2, 1));
	}
		{ which_osc == 'centerX1'}
		{
			~drC.set(\freq_scale, Scale.rast.ratios.choose.linlin(1, 1.9, 0.2, 1.5).postln);
		};
		resu;
	}
	{ which == 4 } {
						var resu;

		resu = case
		{ which_osc == 'actN1'}
		{
				~fw.set(\amp, val.linlin(0.05, 0.15, 0, 0.4));
							~fw.set(\amp2, val.linlin(0.6, 1, 1, 1.6));

			~fw.set(\step, val.linlin(0.1, 1, 1, 0.3));
			//~fw.set(\rate, val.linlin(0.5, 1, 10, 100));
			~fw.set(\scale_tones, val.linlin(0.8, 1, 1, 1.5));
			~fw.set(\deviation, val.linlin(0.2, 1, 20, 200));
	}
		{ which_osc == 'centerX1'}
		{
~fw.set(\scale_val, Scale.rast.ratios.choose.linlin(1, 1.9, 0.2, 0.7).postln);
		};
		resu;

	};
	res;

};



OSCdef( \actN, { |msg|
	var val = msg[1];
	data_sel.value(val, which_data, 'actN1');

	}, "/activityNormal1",
nil, port);

OSCdef( \centerX, { |msg|

	var val = msg[1];
	data_sel.value(val, which_data, 'centerX1');

	}, "/centerX1",
nil, port);

)
FreqScope.new
