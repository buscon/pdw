
(
~path="/Users/marcello/Music/Samples/metabody_tolouse/*.wav";
~path.pathMatch;
~b = ~path.pathMatch.collect { |i| Buffer.readChannel(s, i, channels:[0])};

SynthDef(\gran, { arg bufNum = 0, pos = 0.1, trigRate1 = 3,trigRate2 = 0,trigRate3 = 0, rate = 1, frate = 1, overlap = 4, amtRnd = 0, lfoR = 4, dur = 0.15,
		amFreq = 64, amVol = 0.5,
	ffreq_low = 22000, drywet = -0.8, decay = 0.1,
	panMax = 1, amp = 0.5, interp = 4, volume = 0.5, volume2 = 1, volume3 = 1, master_vol = 1,
	rndTrigRate = 0, speedRndTrigRate = 2, speedRndRate = 5, rndRate = 0, combLevel = -1, envbufnum;
    var trate, rndPos, ausgang, am, midiOsc, freqMod, sig, reverbered, comb;
	rate = rate * frate;
	pos = pos+ LFNoise0.kr(lfoR, amtRnd );
	trate = (trigRate1 + trigRate2 + trigRate3);//  + LFNoise0.kr(speedRndTrigRate, rndTrigRate) ;
	//rate = rate + LFNoise0.kr(speedRndRate, rndRate);
	ausgang = TGrains2.ar(2, Impulse.kr(trate) , bufNum, rate, pos.linlin(0, 1, 0,  BufDur.kr(bufNum)) , dur , 0, amp, 0.01, decay, 4);//, TGrains2.ar(2, Impulse.kr(trate) , bufNum, rate * rrand(-0.99, 0.01), pos.linlin(0, 1, 0,  BufDur.kr(bufNum)) , dur , 0, amp, 0.01, decay, 4)];

	// AM
	am = SinOsc.ar( amFreq, mul:amVol*1.5) * SinOsc.ar( (amFreq)/2, mul:amVol*1.5);
	ausgang = XFade2.ar(ausgang, ausgang * am, amVol.linlin(0, 1, -1, 1));
	comb = Array.fill(8, {CombN.ar(ausgang, 0.2, LFNoise1.kr(0.1.rand, 0.04, 0.05), rrand(5, 10) , 1/8)});
	comb = Mix.new(comb);

	ausgang = XFade2.ar(ausgang, comb, combLevel.linlin(0, 1, -1, 1));
	sig = ausgang * volume * volume2 * volume3 * master_vol;
	sig = FreeVerb.ar(sig, 0.5, 0.8);
	sig = Mix.ar(sig);

	Out.ar(0, sig  );

}).add;





// array of data about the samples
// 0 id of the sample, 1 pitch of the grain (0-1), 2 max vol1, 3 max vol2, 4 max vol3, 5 trigRate1, 6 trigRate2, amtRand max, list of good positions
~samples_data = [
	[0, 0.5, 0.5, 1.5, 1.5, 12, 30, 0.2, [0.03, 0.08, 0.11,0.13,0.18, 0.26, 0.29, 0.36, 0.361, 0.363, 0.367, 0.38, 0.46, 0.51, 0.52, 0.55, 0.65, 0.68, 0.79, 0.86, 0.88, 0.9, 0.94, 0.95, 1] ],//
	[1, 0.5, 0.5, 1.5, 1.5, 12, 10, 0.2, [0.01, 0.02, 0.04, 0.11, 0.12, 0.18, 0.19, ] ],
	[2, 0.5, 0.5, 1.5, 1.5, 12, 10, 0.2, [0.03, 0.08, 0.11,0.13,0.18, 0.26, 0.29, 0.36, 0.361, 0.363, 0.367, 0.38, 0.46, 0.51, 0.52, 0.55, 0.65, 0.68, 0.79, 0.86, 0.88, 0.9, 0.94, 0.95, 1] ]
];

~gran1 = Synth(\gran);

)