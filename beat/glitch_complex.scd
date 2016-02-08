((1/8!8) ++ (1/4!8) ++ [Dseq([1/16, 1/16], Drand([1, 2, 4], inf))] ++ [Dseq([1/32, 1/32], Drand([2, 4], inf))] )
{ Schmidt.kr(SinOsc.kr(1, 0, 0.2), -0.15, 0.15)}.scope;


1000/600
(
var wave, buf;
wave = Wavetable.chebyFill(512, [1]);
buf = Buffer.alloc(s, 1024, 1);

buf.sendCollection(wave.asWavetableNoWrap);

a = {
var ctrigs, ctrigsB, freq, freqW, freqB, clicks, output, waves, bass, speed = 2;
ctrigs =
{
TDuty.ar
(
			Dxrand(((1/2!4) ++ (1/8!8) ++ (1/4!8) ++ [Dseq([1/16, 1/16], Drand([1, 2, 4], inf))] ++ [Dseq([1/32, 1/32], Drand([1, 2], inf))]  ) * 1.5 , inf), //see above logic
0,
Dwhite(0.5, 1, inf) //trigger values are between 0.5, 1
)
}!2;
freqB = 52.8;
ctrigsB = 	(ctrigs[0]  ).abs;

//ctrigsB = 	(ctrigs[0] * 2 ** LFNoise0.ar(16).round ).abs.poll;
 bass =
	( SinOsc.ar([freqB, freqB*2.01, freqB*5] * 1, 0, [1, 1, 0.05] * 0.5).mean.tanh + FBSineC.ar(52.8*20, mul:0.05)!2 )  *
EnvGen.ar(Env([0, 0.5, 0.2, 0], [0.01, 0.13, 0.1], -4), ctrigsB )!2;
	bass = bass + ( SinOsc.ar(freqB*1, 0, 0.1) * EnvGen.ar(Env.perc(0.01, 0.1), ctrigsB)!2 );
	bass = HPF.ar(bass, 20);
	bass = MidEQ.ar(bass, freqB * 2, 1, 6) * 0.5;

	//AllpassC.ar(local, 1, 1/freq, 0.01);
	//f =  Dwrand( [LFNoise0.kr(speed).exprange(-100, 100), LFNoise0.kr(speed).exprange(-1000, -2000) ,LFNoise0.kr(speed).range(-1000, -100) ,LFNoise0.kr(speed).range(100, 2000)], [1, 1,7,1].normalizeSum, inf);
	f = Dwhite(500, 300);
	freqW = Demand.ar(ctrigs, 0, f);

	waves = SinOsc.ar(([freqW, (freqW*{rand(0.9,1.1)})]), 0, Decay.ar(ctrigs, 0.05 * LFNoise1.ar(2).abs));
	//waves = RLPFD.ar(waves, freqW/2, 1, 0.5, 0.5);

	waves = Shaper.ar(buf.bufnum, waves, 0.5);

	waves = LeakDC.ar(waves, 0.995)  * 0.5;
	waves = BPF.ar(waves, freqW*2, 0.1, 4);

	freq = Demand.ar(ctrigs, 0, Dwhite(8000, 12000));
clicks =
BPF.ar
(
		SinOsc.ar(1000, 0, Decay.ar(ctrigs, 0.05 * LFNoise1.ar(2).abs)), //decay time is modulated
		freq ,
		0.2,
 (50 * LFNoise1.ar(2).range(0, 1)) //extreme amplification of glitches.
	).fold(-0.5, 0.5) * 0.3;
	//clicks = CombC.ar(clicks, 1, 0.07, 0.05, 1, clicks);
//output = waves;
	output = (bass + waves + clicks) * 0.5;
	output = MidEQ.ar(output, 2000, 0.7, 6);
	output = GVerb.ar(output, 16, 1.24, 0.1, 0.95, 15, 0.dbamp, -9.dbamp, -11.dbamp);
	Limiter.ar(output * 0.5);
}.play;
)
a.stop;
2000/10000
-3.dbamp

FreqScope.new