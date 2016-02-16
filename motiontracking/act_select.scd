(
~act_sel = { arg val,  which, sensitive;
	var res,  time, now;

res = case
		{ which == 0} {

	}
	{ which == 1} {
			// trig Drones
		~ibeat.set(\volume, val.linlin(0, 0.02, 0, 0.5));

		~ibeat.set(\speed, val.linlin(0, 0.2, 0, 1));
		~ibeat.set(\speed2, val.linlin(0.3, 1, 0, 3));

		~ibeat.set(\scale_freq, val.linlin(0.7, 1, 1, 3));

		~ibeat.set(\which, val.linlin(0.6, 1, 0, 0.5));
		~ibeat.set(\pitch, val.linlin(0.4, 0.8, 0, 1));
		~ibeat.set(\pitchDispertion, val.linlin(0.5, 0.8, 0, 0.2));
	~ibeat.set(\timeDispertion, val.linlin(0.6, 1, 0, 0.2));



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

		~gran1.set(\bufNum, ~b[~sample_id1].bufnum);
		~gran1.set(\pan, -1);

		~gran1.set( \volume, val.linlin(0, 0.1 , 0, ~samples_data[~sample_id1][2]));
		~gran1.set( \volume2, val.linlin(0.1, 0.7, 1, ~samples_data[~sample_id1][3]));
		~gran1.set( \volume3, val.linlin(0.6, 1, 1, ~samples_data[~sample_id1][4]));

		~gran1.set( \trigRate1, val.linexp(0.1, 0.5, 2, ~samples_data[~sample_id1][5])); // mean or val?
		~gran1.set( \trigRate2, val.linlin(0.5, 1, 0, ~samples_data[~sample_id1][6]));
		~gran1.set( \dur, val.linlin(0.4, 1, 0.3, 1));

			~gran1.set( \pv_amt, val.linlin(0.5, 0.9, 0, 0.5));
				~gran1.set( \stretch_bins, val.linexp(0.6, 1, 0.5, 4));

		~gran1.set( \amtRnd, val.linlin(0.3, 1, 0.002, ~samples_data[~sample_id1][7]));

		if((val > 0.95) && (~changed3 !=0), {
			~ratef = (Scale.bartok.ratios.choose * 0.7);
			~gran1.set(\rate, ~ratef);

		});



	}
	{ which == 4 } {

		~gran2.set(\bufNum, ~b[~sample_id2].bufnum);
		~gran2.set(\pan, 1);



		~gran2.set( \volume, val.linlin(0, 0.1 , 0, ~samples_data[~sample_id2][2]));
		~gran2.set( \volume2, val.linlin(0.1, 0.7, 1, ~samples_data[~sample_id2][3]));
		~gran2.set( \volume3, val.linlin(0.6, 1, 1, ~samples_data[~sample_id2][4]));

		~gran2.set( \trigRate1, val.linexp(0.1, 0.5, 2, ~samples_data[~sample_id2][5])); // mean or val?
		~gran2.set( \trigRate2, val.linlin(0.5, 1, 0, ~samples_data[~sample_id2][6]));
		~gran2.set( \dur, val.linlin(0.4, 1, 0.4, 1));

			~gran2.set( \pv_amt, val.linlin(0.5, 0.9, 0, 0.5));
				~gran2.set( \stretch_bins, val.linexp(0.6, 1, 0.5, 4));

		~gran2.set( \amtRnd, val.linlin(0.2, 1, 0.002, ~samples_data[~sample_id2][7]));

		if((val > 0.95) && (~changed4 !=0), {
			~ratef = (Scale.bartok.ratios.choose * 0.7);
			~gran2.set(\rate, ~ratef);

		});

	}

			{ which == 5 } {


		~fw.set(\volume,	val.linlin(0, 0.1, 0, 0.5));
		~fw.set(\deviation, val.linlin(0.4, 0.8, 5, 150));
		~fw.set(\step, val.linlin(0.3, 1, 0.01, 10));
		~fw.set(\volume2, val.linlin(0.3, 0.8, 1, 2));
		~fw.set(\lowPass_scale, val.linlin(0.3, 0.8, 1, 2));

		if(val > 0.99, {
			//~fw.set(\scale_val, rrand(0.5, 1.5).postln;);
			Synth(\freq_wanderS, [\volume, rrand(1, 2), \lo, rrand(50, 80), \hi, rrand(70, 110), \deviation, exprand(90, 100), \scale_val, rrand(0.5, 1.5), \pan, 1]);

		});

	}
			{ which == 6 } {
			Ndef(\complexB).set(\volume, val.linlin(0.05, 0.1, 0, 0.5));

			Ndef(\complexB).set(\volume2, val.linlin(0.5, 1, 1, 2));
			Ndef(\complexB).set(\lpfFreq, val.linexp(0.1, 0.6, 50, 20000));

			Ndef(\complexB).set(\hpfFreq, val.linlin(0.7, 1, 10, 7000));



			Ndef(\complexB).set(\speed, val.linlin(0, 0.2, 3, 1.5));

			Ndef(\complexB).set(\speed2, val.linlin(0.7, 0.9, 0, -1.4));

	}
	{ which == 7 } {
		~pad.set(\volume, val.linlin(0, 0.2, 0.000001, 0.3));
			//filter_mod = MouseX.kr(0.1, 4.5, 1); rq_mod = MouseY.kr(0.1, 2.0);
		~pad.set(\volume2, val.linexp(0.2, 1, 1, 2.5));

		~pad.set(\filter_mod, val.linlin(0.2, 1, 0.1, 4.5));
		~pad.set(\rq_mod, val.linlin(0.2, 0.7, 0.15, 0.3));


			}
	{ which == 8 } {

		~stranga.set(\volume, val.linlin(0, 0.1, 0, 1));
		~stranga.set(\volume2, val.linexp(0.1, 1, 1, 6));

		~stranga.set(\speed, val.linlin(0, 0.8, 0, 5));
		~stranga.set(\pitch_dev, val.linlin(0.5, 1, 0.1, 2));
		~stranga.set(\decay_time, val.linlin(0.1, 1, 6, 1));
		~stranga.set(\pitch_fine, val.linlin(0.25, 1, 0.25, 1));
		//if(val > 0.95, {~stranga.set(\pitch, rrand(0.2, 1);)});

		//sensitive.postln;

			//pitch = MouseY.kr;
	//speed = MouseX.kr(0, 10);
	//decay_time = MouseY.kr(6, 1);
	//pitch_dev = GrayNoise.kr(0.01).range(0.001, 0.009).poll;
					}
	{ which == 9 } {

				~drC.set(\volume, val.linlin(0.05, 0.15, 0, 2));

		~drC.set(\lowPassFreq, val.linexp(0.1, 0.9, 100, 8000).postln);
		~drC.set(\lowPassQ, val.linlin(0.1, 0.9, 2, 1));

		if(val > 0.95, {
			Synth(\droneCymbal, [ \lowPassFreq , rrand(100, 8000).postln, \lowPassQ, rrand(1,2).postln, \freq_scale, rrand(0.5, 1.5), \volume, rrand(1, 2.4).postln, \pan, -1]);
		});

			}
	{ which == 10 } {
					~glitch_drones.set(\volume, val.linlin(0, 0.05, 0, 0.05));
			~glitch_drones.set(\volume2, val.linlin(0.5, 1, 1, 3));

			~glitch_drones.set(\modAmp1, val.linlin(0.1, 1, 1, 10));

			~glitch_drones.set(\modF, val.linlin(0.1, 1, 0, 1));
			~glitch_drones.set(\modN, val.linlin(0.1, 1, 0, 1));
			}
	{ which == 11 } {
			}
	{ which == 12 } {
					// strings
		~string.set( \volume, val.linlin(0, 0.1 , 0, 0.1));
		~string.set( \volume2, val.linlin(0.4, 1 , 1, 2));

		~string.set( \sustain, val.linlin(0, 1 , 5, 0.1));
		~string.set( \freq, val.linexp(0.5, 1, 211, 250));
		~string.set( \lpfF, val.linexp(0.5, 1, 1000, 6000));

			//"dev: ".post;
		~string.set(\freq_dev, (val.linlin(0.4, 0.9, 0.1, 10) ));
		~string.set(\fdecay, (val.linexp(0.5, 1, 0.01, 3) ));
		~string.set( \freq2, val.linexp(0.8, 1, 0, 20));
		~string.set( \mx, val.linlin(0, 1, 0, 30));
	};
	res;
};
)