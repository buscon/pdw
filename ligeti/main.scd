
(
~fw = Ndef(\freq_wander, { arg out=0, lo=70, hi=80, step=1, rate=10, volume=0, volume2 = 1, pan=0, lgate = 1, scale_val = 1, scale_tones = 1, deviation = 1, freq_scale = 1, bwr = 0.2, lowPass_scale = 1;
	var output, freq, num_comb, num_tones, freq_list, bpassFreq;
	num_comb = 24;
	num_tones = num_comb*2;
	//deviation = MouseX.kr(1, 150);step = MouseX.kr(0.01, 10);
	freq = Demand.ar(Impulse.ar(rate), 0,
//		Dbrown(lo, hi)
		Dbrown(lo, hi, step)
	).midicps * scale_val;
	bpassFreq = freq * 0.45232423;
//	freq = Demand.ar(Impulse.ar(rate), 0, SinOsc.ar(0.02).range(lo, hi)).midicps * scale_val;

	output = LPF.ar(
		//Mix.new(VarSaw.ar((freq + [0, -0.2, 0.2, 0.4, -0.4]).poll, 0, 0.8, 0.1)),
		Mix.new(VarSaw.ar(((freq  + Array.fill(num_tones, {gauss(0.0, 0.5) * deviation}))) * freq_scale, 0, 0.8, Array.fill(num_tones, {rrand(0.01, 0.1)}) )), LFNoise2.ar(0.5).range((freq * 0.634423), (freq* 1.45)) * lowPass_scale, 0.5
	);

	output = Mix.ar(Array.fill(num_comb,{ CombN.ar(output, 0.02, rrand(0.001, 0.02), 0.5, 1/num_comb) })) *1 * Lag3UD.kr(volume * volume2, 0, 0.5 );
//	output = Resonz.ar(output, bpassFreq, bwr, 10);
	//output = LPF.ar(output, 1000);
	output = LeakDC.ar(output);
//	output = GVerb.ar(output, 200, 3):
	output = FreeVerb.ar(output, 0.5, 0.5) * 1.5;
	output = Mix.new(output);

	OffsetOut.ar(out, Limiter.ar(Pan2.ar(output, pan, 1), 0.9));
}, [\ir]).play;

SynthDef(\freq_wanderS, { arg out=0, lo=70, hi=80, step=1, rate=10, volume=0, volume2 = 1, pan=0, lgate = 1, scale_val = 1, scale_tones = 1, deviation = 1, bwr = 0.2;
	var output, freq, num_comb, num_tones, freq_list, bpassFreq;
	num_comb = 24;
	num_tones = num_comb*2;
	//deviation = MouseX.kr(1, 150);step = MouseX.kr(0.01, 10);
//	freq = Demand.ar(Impulse.ar(rate), 0,Dbrown(lo, hi, step) ).midicps.poll * scale_val;
	freq = rrand(lo, hi).midicps* scale_val;
//	freq = Demand.ar(Impulse.ar(rate), 0, SinOsc.ar(0.02).range(lo, hi)).midicps * scale_val;

	output = RLPF.ar(
		//Mix.new(VarSaw.ar((freq + [0, -0.2, 0.2, 0.4, -0.4]).poll, 0, 0.8, 0.1)),
		Mix.new(VarSaw.ar((freq  + Array.fill(num_tones, {gauss(0.0, 0.5) * deviation})), 0, 0.8, 0.1)), LFNoise2.ar(0.5).range((freq * 0.634423), (freq* 0.834232)), 0.5, 0.5
	);

	output = Mix.ar(Array.fill(num_comb,{ CombN.ar(output, 0.02, rrand(0.001, 0.02), 0.5, 1/num_comb) })) * 0.2 * volume * volume2 * EnvGen.ar(Env.perc(0.02, 5, curve:-14), 1, doneAction:2);
//	bpassFreq = freq * 0.45232423;

//	output = Resonz.ar(output, bpassFreq, bwr, 6);

	output = LeakDC.ar(output);
//	output = GVerb.ar(output, 200, 3):
	output = FreeVerb.ar(output, 0.5, 0.5) * 1.5;
	output = Mix.new(output);

	Out.ar(out, Limiter.ar(Pan2.ar(output, pan, 1), 0.9));
}).play;
)
/*
~fw.set(\scale_val, 1);
~fw.set(\step, 0.1);
~fw.set(\scale_tones, 10);
FreqScope.new

.new
~fw.set(\rate, 10);
~fw.set(\scale_val, 4); ~fw.set(\step, 0.1);
~fw.set(\scale_val, 2); ~fw.set(\step, 0.1);
~fw.set(\scale_val, 0.1); ~fw.set(\step, 0.3);
~fw.set(\scale_tones, 100);
~fw.play
~fw.stop

*/


