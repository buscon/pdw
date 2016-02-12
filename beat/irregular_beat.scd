/*
~sig1 = Ndef(\sig1);
~sig1.play;
Ndef.clear
~sig1 = ~ibeat;
*/
(
~ibeat = Ndef(\ibeat, { arg speed = 1, volume = 0, scale_freq = 1, pitchRatio = 1, pitchDispertion = 0, timeDispertion = 0, which  = 0;
	var ausgang, input;
	//speed = MouseX.kr(0.1,4, 0); which = MouseY.kr(); pitchDispertion = MouseY.kr(0, 0.1);timeDispertion = MouseX.kr(0, 0.2);
	input = CoinGate.ar([5,20,4,7,6]/10 * speed.round(0.2), T2A.ar(Impulse.kr([5,5,5,10,10])) ) ;
	ausgang= Ringz.ar(input, [45,9e3,50,8e3,250] * scale_freq,([6,1,10,1,3]/10) * speed.linlin(0.1, 4, 0.1, 5),[1,0.2,3,0.2,0.8] ).sin.sum.tanh * 0.1;

	ausgang = SelectX.ar(which, [ausgang, PitchShift.ar(ausgang, 0.2, pitchRatio, pitchDispertion, timeDispertion)]);

	ausgang = Pan2.ar(ausgang, BrownNoise.kr(1), volume);

	ausgang = GVerb.ar(ausgang, 200, 2);
	//Out.ar(reverb_out, ausgang * reverb_amt);

	OffsetOut.ar(0, ausgang);
}).play;

SynthDef(\ibeat, { arg speed = 1, volume = 0.5, scale_freq = 1, pitchRatio = 1, pitchDispertion = 0, timeDispertion = 0, which  = 0;
	var ausgang, input;
	//speed = MouseX.kr(0.1,4, 0);
	input = CoinGate.ar([5,20,4,7,6]/10 * speed.round(0.2), T2A.ar(Impulse.kr([5,5,5,10,10])) ) ;
	ausgang= Ringz.ar(input, 250 * scale_freq,1,[1,0.5] ).sin.sum.tanh * 0.5 * EnvGen.ar(Env.perc(0.01, 0.3)) * volume;

	ausgang = SelectX.ar(which, [ausgang, PitchShift.ar(ausgang, 0.2, pitchRatio, pitchDispertion, timeDispertion)]);

	//ausgang = Pan2.ar(ausgang, BrownNoise.kr(1), volume);
	ausgang = RLPF.ar(ausgang, 500, 0.5);
	ausgang = GVerb.ar(ausgang, 200, 4);
	//OffsetOut.ar(reverb_out, ausgang * reverb_amt);

    DetectSilence.ar(ausgang, doneAction:2);
	OffsetOut.ar(0, ausgang);
}).add;

)
/*
play{a =Ringz.ar(CoinGate.ar([5,10,4,7,6]/10 * MouseX.kr(0.1,2).round(0.25).poll,T2A.ar(Impulse.kr([5,5,5,10,10]))),[45,9e3,50,8e3,250],[6,1,10,1,3]/10,[1,0.1,3,0.1,0.8]).sin.sum.tanh!2 * 0.1;FreeVerb.ar(a);}

	Ndef(\ibeat).stop;

		Ndef(\beat).set(\speed, 1);
*/