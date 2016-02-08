(
~fw = Ndef(\freq_wander, { arg out=0, lo=70, hi=100, step=0.1, rate=10, amp=0.5, amp2 = 1, pan=0, lgate = 1, scale_val = 1, scale_tones = 1, deviation = 1;
	var output, freq, num_comb, num_tones, freq_list;
	num_comb = 24;
	num_tones = num_comb*2;

	freq = Demand.ar(Impulse.ar(rate), 0, Dbrown(lo, hi, step,)).midicps * scale_val;
//	freq = Demand.ar(Impulse.ar(rate), 0, SinOsc.ar(0.02).range(lo, hi)).midicps * scale_val;

	output = LPF.ar(
		//Mix.new(VarSaw.ar((freq + [0, -0.2, 0.2, 0.4, -0.4]).poll, 0, 0.8, 0.1)),
		Mix.new(VarSaw.ar((freq + Array.fill(num_tones, {gauss(0.0, 0.5) * deviation})), 0, 0.8, 0.1)),

		LFNoise2.ar(1).range((freq/2), (freq*1.5)),
	);

	output = Mix.ar(Array.fill(num_comb,{ CombN.ar(output, 0.02, rrand(0.001, 0.02), 2, 1/num_comb) })) * amp * 0.2 * amp2;
	output = GVerb.ar(output, 200, 3) * 0.5;
	OffsetOut.ar(out, Limiter.ar(Pan2.ar(output, pan, 1), 0.9));
}, [\ir]).play;
)
/*
FreqScope.new
~fw.set(\rate, 10);
~fw.set(\scale_val, 4); ~fw.set(\step, 0.1);
~fw.set(\scale_val, 2); ~fw.set(\step, 0.1);
~fw.set(\scale_val, 0.3); ~fw.set(\step, 0.1); ~fw.set(\scale_tones, 10);
~fw.set(\scale_val, 0.1); ~fw.set(\step, 0.3);
~fw.set(\scale_tones, 100);
~fw.play
~fw.stop

*/


