~pad.set(\scale_freq, 0.5);
(
~pad = Ndef(\pad, { arg  freqMul = 0.6,  master_vol = 0.3, volume = 0, scale_freq = 0.5, filter_mod = 1, rq_mod = 1,  volume2 = 1;
	var sig, freq, gen, fmod, rqmod;
	freq = { ([60, 67, 75, 89, 106].choose.midicps * scale_freq) * LFNoise2.kr(1,0.01,1) }!24;
	gen = LFSaw.ar(freq* freqMul) * 0.1;
	//filter_mod = MouseX.kr(0.1, 4.5, 1); rq_mod = MouseY.kr(0.1, 2.0);
	fmod = LFCub.kr(1/12).range(1, 1.5) * filter_mod; // modulate filter
	rqmod = LFNoise2.kr(1/8).range(0.7,1.3) * rq_mod;
//	sig = BPF.ar(gen, (freq.mean * fmod).poll , rqmod.poll) * master_vol * volume;
	sig = Resonz.ar(gen, (freq.mean * fmod) , rqmod, rqmod.reciprocal * 0.5);
	//sig = Mix.ar(sig);
	//sig = AdCVerb.ar( sig, 4)* 0.015;
	//sig = Mix.ar(sig);
	//sig = Limiter.ar(sig);
	//sig =  BBandPass.ar(gen, (freq.mean * fmod).poll , rqmod.poll) * master_vol * volume;
	sig = Splay.ar(sig, 1, 3, BrownNoise.kr(3)) * volume * volume2;
//	sig = GVerb.ar(sig, 200, 5);
	sig = AdCVerb.ar(sig, 2) * 0.2;
	Out.ar(0, sig);
}).play;
)