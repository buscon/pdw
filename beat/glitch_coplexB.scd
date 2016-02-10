// map it to mt! centerX control the filter , hi activity or a trigger control which (which is not interesting as continuous value)
(
var wave, buf;
wave = Wavetable.chebyFill(512, [1]);
buf = Buffer.alloc(s, 1024, 1);
buf.sendCollection(wave.asWavetableNoWrap);

Ndef(\complexB, {arg distortion = 0, volume = 0, volume2 = 1,speed = 1.5 , speed2 = 0, hpfFreq = 10, lpfFreq = 20000, which = 0, filter = 0, decay_bass = 1;


var ctrigs, ctrigsB, freq, freqW, freqB, clicks, output, waves, bass;
//	decay_bass = MouseX.kr(0.01, 3).poll;which = MouseY.kr();filter = MouseX.kr;
ctrigs =
{
TDuty.ar
(
			Dxrand(((1/2!4) ++ (1/8!8) ++ (1/4!8) ++ [Dseq([1/16, 1/16], Drand([1, 2, 4], inf))] ++ [Dseq([1/32, 1/32], Drand([1, 2], inf))]  ) * (speed + speed2), inf), //see above logic
0,
Dwhite(0.5, 1, inf) //trigger values are between 0.5, 1
)
}!2;
freqB = 52.8;
ctrigsB = 	(ctrigs[0]  ).abs;

//ctrigsB = 	(ctrigs[0] * 2 ** LFNoise0.ar(16).round ).abs.poll;
 bass =
	( SinOsc.ar([freqB, freqB*2.01, freqB*5] * 1, 0, [1, 1, 0.05] * 0.5).mean.tanh + FBSineC.ar(52.8*20, mul:0.05)!2 )  *
EnvGen.ar(Env([0, 0.5, 0.2, 0], [0.01, 0.13 * decay_bass, 0.1* decay_bass], -4), ctrigsB )!2;

	bass = bass + ( SinOsc.ar(freqB*1, 0, 0.1) * EnvGen.ar(Env.perc(0.01, 0.1 ), ctrigsB)!2 );
	bass = HPF.ar(bass, 20);
	bass = MidEQ.ar(bass, freqB * 2, 1, 6) * 0.5;

	//AllpassC.ar(local, 1, 1/freq, 0.01);
	//f =  Dwrand( [LFNoise0.kr(speed).exprange(-100, 100), LFNoise0.kr(speed).exprange(-1000, -2000) ,LFNoise0.kr(speed).range(-1000, -100) ,LFNoise0.kr(speed).range(100, 2000)], [1, 1,7,1].normalizeSum, inf);
	f = Dwhite(500, 300);
	freqW = Demand.ar(ctrigs, 0, f);

	waves = SinOsc.ar(([freqW, (freqW*{rand(0.9,1.1)})]), 0, Decay.ar(ctrigs, (0.05 * LFNoise1.ar(2).abs * decay_bass)));
	//waves = RLPFD.ar(waves, freqW/2, 1, 0.5, 0.5);

	waves = Shaper.ar(buf.bufnum, waves, 0.5);

	waves = LeakDC.ar(waves, 0.995)  * 0.5;
	waves = BPF.ar(waves, freqW*2, 0.1, 4);

	freq = Demand.ar(ctrigs, 0, Dwhite(8000, 12000));
clicks =
BPF.ar
(
		SinOsc.ar(1000, 0, Decay.ar(ctrigs, 0.05 * LFNoise1.ar(2).abs * decay_bass)), //decay time is modulated
		freq ,
		0.2,
 (50 * LFNoise1.ar(2).range(0, 1)) //extreme amplification of glitches.
	).fold(-0.5, 0.5) * 0.3;
	//clicks = CombC.ar(clicks, 1, 0.07, 0.05, 1, clicks);
//output = waves;
//	output = waves * 0.5;
	output = (bass + waves + clicks) * 0.5;
	//distortion = distortion.lag(0.2);
	//output = SelectX.ar(distortion, [output, Smoot.ar(output, distortion.linlin(0, 1, 0, 0.9), distortion.linlin(0, 1, 0, 0.9)) * 0.05]);
	output = RLPF.ar(output, lpfFreq, 0.7);
	output = RHPF.ar(output, hpfFreq.lag(0.1), 0.7);
	//output = SelectX.ar(which, [output, Resonz.ar(output, filter.linexp(0, 1, 100, 6000), 0.2, filter.linexp(0, 1, 3.5, 9) )]);
	output = MidEQ.ar(output, 2000, 0.7, 6) * volume * volume2;
	output = GVerb.ar(output, 100, 1.24, 0.1, 0.95, 15, 0.dbamp, -9.dbamp, -11.dbamp);
	//output = Limiter.ar(output * 0.5);
	Out.ar(0, output);
}).play;
)
