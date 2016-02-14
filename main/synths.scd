(
SynthDef(\gran, { arg bufNum = 2, pos = 0.1, trigRate1 = 3,trigRate2 = 0,trigRate3 = 0, rate = 1, frate = 1, overlap = 4, amtRnd = 0, lfoR = 4, dur = 0.3, list_of_pos = [0, 0.5],
		amFreq = 64, amVol = 0.5, pan = 0,
	stretch_bins = 0.5, //0.1-4 exponential
	pv_amt = 0, freeze = 0,
	holdperiod = 0.02, multiplier = 1, stutter = 0,
	ffreq_low = 22000, drywet = -0.8, decay = 0.1,
	panMax = 1, amp = 0.5, interp = 4, volume = 0, volume2 = 1, volume3 = 1, master_vol = 1,
	rndTrigRate = 0, speedRndTrigRate = 2, speedRndRate = 5, rndRate = 0, combLevel = -1, envbufnum;
    var trate, rndPos, ausgang, am, midiOsc, freqMod, sig, reverbered, comb, chain;
	rate = rate * frate;
	//trigRate1 =MouseX.kr(0, 10); dur = MouseX.kr(0.2, 1);
	pos = pos + LFNoise0.kr(lfoR, amtRnd );

	trate = (trigRate1 + trigRate2 + trigRate3);
	ausgang = TGrains2.ar(2, Impulse.kr(trate) , bufNum, rate, pos.linlin(0, 1, 0,  BufDur.kr(bufNum)) , dur , 0, amp, 0.01, decay, 4);

	// AM
	am = SinOsc.ar( amFreq, mul:amVol*1.5) * SinOsc.ar( (amFreq)/2, mul:amVol*1.5);
	ausgang = XFade2.ar(ausgang, ausgang * am, amVol.linlin(0, 1, -1, 1));


	sig = ausgang * volume * volume2 * volume3 * master_vol;

	chain = FFT(LocalBuf(2048), sig);
	chain = PV_BinShift(chain, stretch_bins, 0, 4);
	sig = SelectX.ar(pv_amt, [sig,  IFFT(chain, 0) *4]);

	sig = RLPF.ar(sig, 3000, 0.8, 0.7);
	sig = FreeVerb.ar(sig, 0.5, 0.5, 0.8);
	sig = Mix.ar(sig) * 1.5;

	sig = Limiter.ar(sig, 0.8);
	sig = LeakDC.ar(sig);
	sig = Pan2.ar(sig, pan).clip2;

	Out.ar(0, sig  );

}).add;


SynthDef(\granS,{ arg out, bufnum, dur = 1, rate = 1, position = 0.0, volume = 1,  speed =0.1, pan, drywet = 1, cutoff = 1000;//, freq = 400;
var env, grain, chain, chainout, mix, mixChain, reverbered;

     env = EnvGen.kr(Env.perc(0.01, dur), doneAction:0) - 0.001;
     grain = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, 1,
                                                       BufFrames.kr(bufnum) * position) * env;
	grain = BBandPass.ar(grain, cutoff, 0.7) * volume;

	reverbered = FreeVerb.ar(grain, 0.8, 0.8, 1) *  (EnvGen.kr(Env.perc(0.01, dur*4), doneAction:2) - 0.001);
	mix = XFade2.ar(grain, reverbered, drywet.linlin(0, 1, -1, 1));

	mix = Pan2.ar(mix, pan);
	mix = LeakDC.ar(mix);
	Out.ar(out, mix.clip2(0.9)) ;

}).add;
)

