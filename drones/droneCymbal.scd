

(
~drC = Ndef(\droneCymbal, {arg lowPassFreq  =100, lowPassQ = 1, freq_scale = 0.7, volume = 0.5;
	var lfo, num_freq, ratios;
	num_freq = 50;//MouseY.kr(1,50);//50;
	ratios = Scale.rast.ratios;
	lfo =  LFNoise2.kr(5);
	//lowPassFreq = MouseX.kr(100, 8000,1);lowPassQ = MouseX.kr(2, 1);

	s = BPF.ar(Ringz.ar(PinkNoise.ar(0.1), {exprand(50, 15000) * ratios.choose}.dup(num_freq) *
		//Select.kr(MouseX.kr(0, 1).round(0.2) * r.size * 0.5, r).poll  *
		freq_scale
		//* lfo.range(0.9, 1.1)
		,{rrand(0.1, 1)}.dup(num_freq), 0.25).mean, (lowPassFreq.lag(0.1) * lfo.range(0.1, 2) )
		, lowPassQ.reciprocal
	) * 1/4 * volume;
	//s = Array.fill(n, RLPF.ar(Ringz.ar(PinkNoise.ar(0.1), {rrand(300, 10000)} * Select.kr(MouseX.kr(0, 1) * r.size, r).poll *0.2 ,{rrand(0.5, 1.5)}, n.reciprocal/4), 1000)) * 1/16;
	AdCVerb.ar( s);

}).play;

)
/*
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