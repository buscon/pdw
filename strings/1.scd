(
~stranga = Ndef(\stranga, {arg speed = 1, volume = 0.5, volume2 = 1, pitch =0;
    var num_voices = 8, output;
    output = Mix.ar( // mix all stereo pairs down.
        Pan2.ar( // pan the voice to a stereo position
            CombC.ar( // a comb filter used as a string resonator
                Dust.ar( // random impulses as an excitation function
                    // an array to cause expansion of Dust to n channels
                    // 1 means one impulse per second on average
					speed.dup(n),
                    0.8 // amplitude
                ),
                0.1, // max delay time in seconds
                // array of different random lengths for each 'string'
				{(0.004.rand+pitch.linlin(0, 1, 0.0001, 0.0009))  }.dup(n),
                4 // decay time in seconds

            ) ,
            {1.0.rand2}.dup(n) // give each voice a different pan position
        )
    );
	Out.ar(0, output);
}).play;

)