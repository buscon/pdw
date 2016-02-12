(
SynthDef(\glitch_sounds, { arg outbus = 0, modN = 0.5, modF = 0.4, modAmp1 = 0.1, modAmp2 = 1, modAmp3 = 1, modC = 1, gpos = 0,  volume = 0, volume2 = 1;
	var chain, snd;

	snd = BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(modF,phase:Rand (0,pi), mul:Rand( 0.1,1) )),modAmp1 * modAmp2 * modAmp3 *  Rand(0,400) * modN  )!2
	+
	BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(modF,phase:Rand (0,pi), mul:Rand( 0.1,1) )),modAmp1 * modAmp2 * modAmp3  * Rand(0,400)* modN )!2
	+
	BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(modF,phase:Rand (0,pi), mul:Rand( 0.1,1) )),modAmp1 * modAmp2 * modAmp3  * Rand(0,400) * modN )!2 ;
	snd = BrownNoise.ar(modF, snd) + snd;
	snd = snd.clip2(0.5);
	snd = Array.fill(8, CombN.ar(snd, 0.2, {rrand(0.05,0.1)} * modC, {rrand(0.1,1)} * modC, 1/8));
	snd = Mix.new(snd);
	snd = HPF.ar(snd, 20);

	//snd = GVerb.ar(snd, 5, 0.83423432, 0.5, spread:15, mul:0.2);
	snd = Pan2.ar(snd, gpos) * volume * volume2 * 0.1;
	snd = GVerb.ar(snd, 100);
	Out.ar(outbus, snd ).clip2(0.5);

}).add;

)
~glitch_drones = Synth(\glitch_sounds);

//~glitch_drones.set(\volume, 0.2, \modAmp1, 10, \modAmp2, 65, \modN, 0.2, \modF, 0.4, \gpos, 0.1);
