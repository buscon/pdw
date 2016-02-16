(
~sens_sel = { arg val,  which;
	var res;

	res = case
		{ which == 0} {

	}
	{ which == 1} {

	}
		{ which == 2} {
				Synth(\trigDrones, [\volume, 1.5, \sensitive, 1, \rate, Scale.whole.ratios.choose, \lpfFreq, rrand(1000, 4000), \octave, 1.5 ]);

			  // Synth(\stringS, [\amp, 0.1]);sensitive = 1;

	}
	{ which == 3} {
			Synth(\granS, [\bufNum, ~b[~sample_id1].bufnum, \volume, rrand(0.5, 1.5), \rate, ~ratef.postln, \dur, rrand(0.1, 0.5), \pan, -1, \pos, ~samples_data[~sample_id1][8].choose.postln, \cutoff, ~ratef.linlin(0.7, 1.24, 3000, 500).postln]);

	}
	{ which == 4} {
			Synth(\granS, [\bufNum, ~b[~sample_id2].bufnum, \volume, rrand(0.5, 1.5), \rate, ~ratef, \dur, rrand(0.1, 0.5), \pan, 1, \pos, ~samples_data[~sample_id2][8].choose, \cutoff, ~ratef.linlin(0.7, 1.24, 3000, 500)]);

	}
	{ which == 5} {
			Synth(\freq_wanderS, [\volume, rrand(0.5, 0.9), \lo, rrand(40, 70), \hi, rrand(70, 100), \deviation, exprand(50, 100), \scale_val, rrand(0.5, 1.5), \pan, 1]);

	}
	{ which == 6} {

	}
	{ which == 7} {

	}
	{ which == 8} {
					Synth(\strangaS, [\volume, rrand(0.1, 0.35), \pitch, rrand(0.6, 1), \pitch_fine, rrand(0.3, 1), \pitch_dev, rrand(0.3, 0.7), \decay_time, rrand(1.0, 7.0), \roomsize, rrand(80, 150),\revtime , rrand(2.0,6.0) ]);

	}
	{ which == 9} {
			Synth(\droneCymbal, [ \lowPassFreq , rrand(100, 8000).postln, \lowPassQ, rrand(1,2).postln, \freq_scale, rrand(0.5, 1.2), \volume, rrand(0.2, 0.5), \pan, -1]);

	}
	{ which == 10} {

	}
	{ which == 11} {
	}
	{ which == 12} {
		Synth(\stringS, [ \freq, 211.gauss(1), \sustain, 0.5.gauss(0.01), \freq_dev, rrand(1, 3), \freq_scale, 1.gauss(0.01).postln]);

	};
	res;
};
)