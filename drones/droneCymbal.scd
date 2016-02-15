

(
~drC = Ndef(\droneCymbal, {arg lowPassFreq  =400, lowPassQ = 1, freq_scale = 0.7, volume = 0.4, pan = 0;
	var lfo, num_freq, ratios, output, volFilter;
	num_freq = 50;//MouseY.kr(1,50);//50;
	ratios = Scale.whole.ratios;
	lfo =  LFCub.kr(1/8);
	lowPassFreq = MouseX.kr(100, 8000);lowPassQ = MouseY.kr(2, 1);

	output = BPF.ar(Ringz.ar(BrownNoise.ar(0.1), {exprand(50, 15000) * ratios.choose}.dup(num_freq) *
		//Select.kr(MouseX.kr(0, 1).round(0.2) * r.size * 0.5, r).poll  *
		freq_scale
		//* lfo.range(0.9, 1.1)
		,{rrand(0.1, 1)}.dup(num_freq), 0.25).mean, (lowPassFreq * lfo.range(0.5, 1.5) )
		, lowPassQ.reciprocal.poll, lowPassFreq.linlin(100, 8000, 1, 12).poll
	) * 1/4 * volume;
	//s = Array.fill(n, RLPF.ar(Ringz.ar(PinkNoise.ar(0.1), {rrand(300, 10000)} * Select.kr(MouseX.kr(0, 1) * r.size, r).poll *0.2 ,{rrand(0.5, 1.5)}, n.reciprocal/4), 1000)) * 1/16;
	//AdCVerb.ar( output, 2);
	output = FreeVerb.ar(output, 0.5, 0.8);
	output = Out.ar(0, Pan2.ar(output, pan));

}).play;

SynthDef(\droneCymbal, {arg lowPassFreq  =400, lowPassQ = 1, freq_scale = 0.7, volume = 0.4, pan = -1;
	var lfo, num_freq, ratios, output, volFilter;
	num_freq = 50;//MouseY.kr(1,50);//50;
	ratios = Scale.whole.ratios;
	lfo =  LFCub.kr(1/8);
	lowPassFreq = MouseX.kr(100, 8000);lowPassQ = MouseY.kr(2, 1);

	output = BPF.ar(Ringz.ar(BrownNoise.ar(0.1), {exprand(50, 15000) * ratios.choose}.dup(num_freq) *
		//Select.kr(MouseX.kr(0, 1).round(0.2) * r.size * 0.5, r).poll  *
		freq_scale
		//* lfo.range(0.9, 1.1)
		,{rrand(0.1, 1)}.dup(num_freq), 0.25).mean, (lowPassFreq * lfo.range(0.5, 1.5) )
		, lowPassQ.reciprocal.poll, lowPassFreq.linlin(100, 8000, 1, 12).poll
	)  * volume ;
	//s = Array.fill(n, RLPF.ar(Ringz.ar(PinkNoise.ar(0.1), {rrand(300, 10000)} * Select.kr(MouseX.kr(0, 1) * r.size, r).poll *0.2 ,{rrand(0.5, 1.5)}, n.reciprocal/4), 1000)) * 1/16;
	//AdCVerb.ar( output, 2);
	output = FreeVerb.ar(output, 0.5, 0.8) * EnvGen.ar(Env.perc(), doneAction:2);
	output = Out.ar(0, Pan2.ar(output, pan));

}).play;

)
/*
~drC.set(\lowPassFreq, 3000);

~drC.set(\volume, 1);
FreqScope.new
(
       var delay = 1, scale, ratios, tonic, lfoVal;
	scale = Scale.zhi;
	ratios = scale.ratios;
tonic = 1050;

x = { s = Ringz.ar(PinkNoise.ar(0.1), {tonic * ratios.choose}.dup(32)
//	{rrand(tonic, (tonic * (ratios[1] + ( ratios[1] * Array.fill(16, rrand(-0.1, 0.1)).choose ) ).postln))}.dup(10)
//		{rrand(tonic, (tonic * (ratios[1] + ( ratios[1] * rrand(-0.001,0.001) ) )).postln)}.dup(100)

	//5000.dup(100)
	, 1, 0.1).mean;
	s = LPF.ar(s, 2000)!2 }.play;
//x = { Ringz.ar(PinkNoise.ar(0.1), {rrand(300, 20000).postln}.dup(100), 1, 1).mean }.play;

)
note
440.note
* rrand(1/3,1/5).postln
1.1224620483089 * 0.8
100:115=1:1.15
(
	s = Scale.major;
	r = s.ratios.postln;
(r + (1/5));
)
[ 0.4, 0.42449240966177, 0.45198420997874, 0.4669679708337, 0.49966141537485, 0.53635856610079, 0.57754972507172 ]+0.2
[ 1, 1.1224620483089, 1.2599210498937, 1.3348398541685, 1.4983070768743, 1.6817928305039, 1.8877486253586 ] + (1/5)
1/5
*/