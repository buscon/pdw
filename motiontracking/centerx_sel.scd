(
~cx_sel = { arg val,  which;
	var res;

	res = case
		{ which == 0} {

	}
	{ which == 1} {

	}
		{ which == 2} {
					var list = Scale.bartok.ratios;

			Ndef(\trigDrones).set(\select, list[(val.linlin(0.1, 0.9, 1, list.size).round(1); )];);
	}
		{ which == 3} {

		~gran1.set(\pos, val.linlin(0.1,0.9, 0, 1) );

					//~drC.set(\freq_scale, val.linlin(0.1, 0.9, 0.5, 1.5).round(0.1));
	}
				{ which == 4} {
		~gran2.set(\pos, val.linlin(0.1,0.9, 0, 1) );

//~fw.set(\scale_val, Scale.rast.ratios.choose.linlin(1, 1.9, 0.2, 0.7));
		}
				{ which == 5} {
	}
				{ which == 6} {
			//~glitch_drones.set(\modAmp1, val.linlin(0.1, 1, 1, 50));


		}
				{ which == 7} {
	}
				{ which == 8} {
		~stranga.set(\pitch, ((Scale.bartok.ratios[val.linlin(0, 1, 0, [Scale.bartok.ratios.size -1])][0]) * 0.5).postln);

		}
				{ which == 9} {
//		val.linlin(0.1, 1, 0.4, 1.1).round(0.1).postln;
		~drC.set(\freq_scale, Scale.bartok.ratios[val.linlin(0, 1, 0, [Scale.bartok.ratios.size -1])][0].postln);

	}
				{ which == 10} {
					~glitch_drones.set(\modAmp2, val.linlin(0.1, 1, 1, 50));
			~glitch_drones.set(\modAmp3, val.linlin(0.1, 1, 1, 40));
			~glitch_drones.set(\gpos, val.linlin(0.1, 1, 0.1, 0.9));
			~glitch_drones.set(\modN, val.linlin(0.1, 1, 0.1, 0.9));

		}
				{ which == 11} {
	}
				{ which == 12} {
				~string.set( \freq_scale, Scale.bartok.ratios[val.linlin(0, 1, 0.01, [Scale.bartok.ratios.size -1]).postln][0]);

						//~string.set( \freq_scale, val.linlin(0.01, 0.99 , 0.8, 1.2).round(0.2));

	};
};
)