/*
Synth(\padS, [\volume, 0.5, \scale_freq, rrand(0.9, 1.1).postln, \filter_mod, rrand(0.5, 0.7).postln,\rq_mod, rrand(0.3, 1.0).postln ]);
~pad.set(\volume, 0);
~pad.set(\volume, 2, \scale_freq, (Scale.bartok.ratios.choose * 0.5).postln);
~pad.set(\volume, 0.5, \scale_freq, (Scale.bartok.ratios.linlin(1, 1.7817974362766, 1, 1.1224620483089).choose * 0.5).postln);
{e = EnvGen.kr(Env([0,0,1,1],[0.1,0,0.1]),); v = VarLag.kr(e, 0.1,4); l = Lag.kr(e,0.1); [e,v,l];}.plot(0.3)
*/
(
~pad = Ndef(\pad, { arg  freqMul = 0.6,  master_vol = 0.3, volume = 0, scale_freq = 0.5, filter_mod = 1, rq_mod = 1,  volume2 = 1, pan =0;
	var sig, freq, gen, fmod, rqmod;
	freq = { ([60, 67, 75, 89, 106].choose.midicps * VarLag.kr(scale_freq, 10, 4) )* LFNoise2.kr(1,0.01,1) }!24;
	gen = LFSaw.ar(freq* freqMul) * 0.1;
	//filter_mod = MouseX.kr(0.1, 4.5, 1); rq_mod = MouseY.kr(0.1, 2.0);
	fmod = LFCub.kr(1/12).range(1, 1.5) * filter_mod; // modulate filter
	rqmod = LFNoise2.kr(1/8).range(0.5,1.2) * rq_mod;
//	sig = BPF.ar(gen, (freq.mean * fmod).poll , rqmod.poll) * master_vol * volume;
	sig = Resonz.ar(gen, (freq.mean * fmod) ,rqmod, rqmod.reciprocal * 0.5);
	//sig = Mix.ar(sig);
	//sig = AdCVerb.ar( sig, 4)* 0.015;
	//sig = Mix.ar(sig);
	//sig = Limiter.ar(sig);
	//sig =  BBandPass.ar(gen, (freq.mean * fmod).poll , rqmod.poll) * master_vol * volume;
	sig = Splay.ar(sig, 1, 3, BrownNoise.kr(3)) *
//	(volume * volume2)
	Lag3UD.kr(volume * volume2, 0, 0.5)
	;
	sig = GVerb.ar(sig, 200, 5, 0.7, 0.5, 50) * 0.1;
//	sig = AdCVerb.ar(sig, 3) * 0.2;
//	sig = FreeVerb.ar(sig, 1, 0.9);
//	sig = Mix.new(sig);

	sig = Pan2.ar(sig, pan);
	Out.ar(0, sig);
}).play;

SynthDef(\padS, { arg  freqMul = 0.6,  master_vol = 0.3, volume = 0, scale_freq = 0.5, filter_mod = 1, rq_mod = 1,  volume2 = 1, pan = 0;
	var sig, freq, gen, fmod, rqmod;
	freq = { ([60, 67, 75, 89, 106].choose.midicps * scale_freq) * LFNoise2.kr(1,0.01,1) }!24;
	gen = LFSaw.ar(freq* freqMul) * 0.1;
	//filter_mod = MouseX.kr(0.1, 4.5, 1); rq_mod = MouseY.kr(0.1, 2.0);
	fmod = LFCub.kr(1/12).range(1, 1.5) * filter_mod; // modulate filter
	rqmod = LFNoise2.kr(1/8).range(0.7,1.3) * rq_mod;
//	sig = BPF.ar(gen, (freq.mean * fmod).poll , rqmod.poll) * master_vol * volume;
		sig = Resonz.ar(gen, (freq.mean * fmod) , rqmod, rqmod.reciprocal * 0.5) * EnvGen.ar(Env.perc(0.5, 3, curve:-6), doneAction:2);
	//sig = Mix.ar(sig);
	//sig = AdCVerb.ar( sig, 4)* 0.015;
	//sig = Mix.ar(sig);
	//sig = Limiter.ar(sig);
	//sig =  BBandPass.ar(gen, (freq.mean * fmod).poll , rqmod.poll) * master_vol * volume;
	sig = Splay.ar(sig, 1, 3, BrownNoise.kr(3)) * volume * volume2;
//	sig = GVerb.ar(sig, 200, 5);
//	sig = AdCVerb.ar(sig, 3) * 0.2;
	sig =  FreeVerb.ar(sig, 0.5, 0.5);
	sig = Mix.new(sig);
	sig = Pan2.ar(sig, pan);
	Out.ar(0, sig);
}).add;
)