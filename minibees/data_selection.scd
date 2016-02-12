/*
todo:
4.
- fix the sensitives!
*/
(
~data_sel = { arg val, longval, which;
	var res, sensitive = 0, time, now;

	time = Main.elapsedTime.asInt;
	now = (time.asInt)-0.1;

	res = case
		{ which == 0} {

	}
	{ which == 1} {


		~ibeat.set(\volume, val.linlin(0, 0.02, 0, 0.5));

		~ibeat.set(\speed, ((val + val + longval)/3).linlin(0, 1, 0, 4));

		~ibeat.set(\scale_freq, val.linlin(0.6, 1, 1, 3));

		~ibeat.set(\which, val.linlin(0.6, 1, 0, 0.5));
		~ibeat.set(\pitch, val.linlin(0.4, 0.8, 0, 1));
		~ibeat.set(\pitchDispertion, val.linlin(0.5, 0.8, 0, 0.2));
	~ibeat.set(\timeDispertion, val.linlin(0.6, 1, 0, 0.2));

		if( (val > 0.99) && (now < time),
			{
				Synth(\ibeat, [\scale_freq, exprand(0.2, 2.0), \which, 0.5, \pitchRatio, 1.0.rand, \pitchDispertion, 3.0.rand, \timeDispertion, 3.0.rand, \volume, 1]);
				} );
	}
	{ which == 2 } {
		~trigDrones.set(\volume, val.linlin(0, 0.2, 0, 1.2));
		~trigDrones.set(\volume2, val.linlin(0.3, 1, 1, 3));
		~trigDrones.set(\speed, (val.linlin(0.15, 1, 0, 35) ));
		~trigDrones.set(\rate, (val.linlin(0.9, 0.95, 1, 1.25) ));
		~trigDrones.set(\lpfFreq, (val.linlin(0.2, 0.8, 3000, 8000) ));

		~trigDrones.set(\sensitive, (val.linlin(0.02, 0.04, 0, 1) ));
	}
	{ which == 3 } {
		//granulator
		//~gran1.set( \frate, val.linlin(0.7, 1.0, 1, 1.5));
		//~gran1.set( \dur, val.linlin(0.8, 1.0, 0.2, 2));
		//~gran1 = Synth(\gran);

		~sample_id = 2;

		~gran1.set(\bufNum, ~b[~sample_id].bufnum, \amtRnd, 0, \amFreq, 1000, \master_vol, 2, \dur, 0.25, \pos, 1.0.rand, \volume,1);
		//~gran2.set(\bufNum, ~b[1].bufnum, \amVol, 0, \amFreq, 1000, \master_vol, 0.5, \dur, 0.25, \pos, 1.0.rand, \volume,1);


		~gran1.set(\bufNum, ~b[~sample_id].bufnum);


		~gran1.set( \volume, val.linlin(0.001, 0.1 , 0, ~samples_data[~sample_id][2]));
		~gran1.set( \volume2, val.linlin(0.1, 0.7, 1, ~samples_data[~sample_id][3]));
		~gran1.set( \volume3, val.linlin(0.7, 1, 1, ~samples_data[~sample_id][4]));

		~gran1.set( \trigRate1, val.linexp(0.01, 0.5, 2, ~samples_data[~sample_id][5])); // mean or val?
		~gran1.set( \trigRate2, val.linlin(0.5, 1, 0, ~samples_data[~sample_id][6]));

		~gran1.set( \amtRnd, val.linlin(0.5, 1, 0.001, ~samples_data[~sample_id][7]));
	}
	{ which == 4 } {
			// strings


		~string.set( \volume, val.linlin(0, 0.0001 , 0, 0.3).postln);
		~string.set( \volume2, val.linlin(0.4, 1 , 1, 2));

		~string.set( \sustain, val.linlin(0, 1 , 5, 0.1));
		~string.set( \freq, val.linexp(0.5, 1, 211, 250));
		~string.set( \lpfF, val.linexp(0.3, 1, 1000, 6000));

			//"dev: ".post;
		~string.set(\freq_dev, (val.linlin(0.4, 0.8, 0.1, 10) ));
		~string.set(\sdecay, (val.linexp(0.5, 1, 1, 0.1) ));
		~string.set( \freq2, val.linexp(0.8, 1, 0, 50));
		~string.set( \mx, val.linlin(0, 0.8, 0, 20));




//		if((sensitive == 0) && (val > 0.04), {   Synth(\stringS, [\freq2, 50.0.rand, \freq_dev, 5.0.rand]);sensitive = 1;}); if((val < 0.04), { sensitive = 0; });


		//sensitive.postln;
		//~string.set(\sensitive, val.linlin(0.02, 0.04, 0, 1 ));
	}

		{ which == 5 } {
			Ndef(\complexB).set(\volume, val.linlin(0, 0.1, 0, 0.5));

			Ndef(\complexB).set(\volume2, val.linlin(0.5, 1, 1, 2));
			Ndef(\complexB).set(\lpfFreq, val.linexp(0.1, 0.6, 50, 20000));

			Ndef(\complexB).set(\hpfFreq, val.linlin(0.7, 1, 10, 7000));



			Ndef(\complexB).set(\speed, val.linlin(0, 0.2, 2, 1.5));

			Ndef(\complexB).set(\speed2, val.linlin(0.7, 0.9, 0, -1.45));
	}
	{ which == 6 } {
		//val.postln;
		~pad.set(\volume, val.linlin(0, 0.2, 0.000001, 0.25));
			//filter_mod = MouseX.kr(0.1, 4.5, 1); rq_mod = MouseY.kr(0.1, 2.0);
		~pad.set(\volume2, val.linexp(0.2, 1, 1, 1.25));

		~pad.set(\filter_mod, val.linexp(0.2, 1, 0.1, 3.5).postln);
		~pad.set(\rq_mod, val.linlin(0.2, 0.7, 0.1, 0.3));

};
	res;

};

~hyper_data_sel = { arg val, which;
	var res;
	/*
	~ibeat.stop;
	~sig1.stop;
	~gran1.free;
	~string.stop;
*/
	res = case
		{ which == 0} {

	}
	{ which == 1} {


		//Synth(\kick, [\volume, 0.25]); Synth(\snare, [\volume, 0.01]);
	}
	{ which == 2} {
		~sig1.set(\select, 1.0.rand );
		"octave: ".post;~sig1.set(\octave, ([1, (5/4), 3/2].wchoose([0.4,0.3,0.3]) * [1, 1/4, 1/6, 1/8, 1.5, 2].wchoose([0.1, 0.2, 0.2, 0.2, 0.15, 0.15]) * 0.45) );
	}
		{ which == 3} {
		"pos: ".post;~gran1.set( \pos, ~samples_data[~sample_id][8].choose);
		~gran1.set( \rate, rrand(0.5, 1.2));
	}

		{ which == 4} {

	};

				"lastpeak: ".post;~lastPeak1[0].postln;
				~now = (~t.asInt)+0.1;
				"now: ".post;~now.postcs;
				"time: ".post;~t.postcs;
		res;

};
)