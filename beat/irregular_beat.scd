(
Ndef(\ibeat, { arg speed = 1, volume = 0.5, scale_freq = 1, pitchRatio = 1, pitchDispertion = 0, timeDispertion = 0, which  = 0;
	var ausgang, input;
	//speed = MouseX.kr(0.1,4, 0); which = MouseY.kr(); pitchDispertion = MouseY.kr(0, 0.1);timeDispertion = MouseX.kr(0, 0.2);
	input = CoinGate.ar([5,20,4,7,6]/10 * speed.round(0.2), T2A.ar(Impulse.kr([5,5,5,10,10])) ) ;
	ausgang= Ringz.ar(input, [45,9e3,50,8e3,250] * scale_freq,([6,1,10,1,3]/10) * speed.linlin(0.1, 4, 0.1, 5),[1,0.2,3,0.2,0.8] ).sin.sum.tanh * 0.1;

	ausgang = SelectX.ar(which, [ausgang, PitchShift.ar(ausgang, 0.2, pitchRatio, pitchDispertion, timeDispertion)]);

	ausgang = Pan2.ar(ausgang, BrownNoise.kr(1), volume);

	ausgang = GVerb.ar(ausgang, 200, 2);
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
    DetectSilence.ar(ausgang, doneAction:2);
	OffsetOut.ar(0, ausgang);
}).add;

	SynthDef("kick", {
		arg outBus=0, volume = 0.25;
		var env0, env1, env1m, out;

		env0 =  EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, 0.26], [-4, -2, -4]), doneAction:2);
		//env1 = 29;//
		env1 = EnvGen.ar(Env.new([110, 59, 29], [0.005, 0.29], [-4, -5]));
		env1m = env1.midicps;

		out = LFPulse.ar(env1m, 0, 0.5, 1, -0.5);
		//out = out + WhiteNoise.ar(0.5);
		out = LPF.ar(out, env1m*1.5, env0);
		out = out + SinOsc.ar(env1m, 0.5, env0 );

		out = out * 1.2;
		out = out.clip2(1) * volume * 0.6;
	out = GVerb.ar(out, 400, 10) ;
		OffsetOut.ar(outBus, out.dup);
	}).add;

	SynthDef("snare", {
		arg outBus=0, amp=0.2;
		var env0, env1, env2, env1m, oscs, noise, out;

		env0 = EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.03, 0.10], [-4, -2, -4]));
		env1 = EnvGen.ar(Env.new([110, 60, 49], [0.005, 0.1], [-4, -5]));
		env1m = env1.midicps;
		env2 = EnvGen.ar(Env.new([1, 0.4, 0], [0.05, 0.13], [-2, -2]), doneAction:2);

		oscs = LFPulse.ar(env1m, 0, 0.5, 1, -0.5) + LFPulse.ar(env1m * 1.6, 0, 0.5, 0.5, -0.25);
		oscs = LPF.ar(oscs, env1m*1.2, env0);
		oscs = oscs + SinOsc.ar(env1m, 0.8, env0);

		noise = WhiteNoise.ar(0.2);
		noise = HPF.ar(noise, 200, 2);
		noise = BPF.ar(noise, 6900, 0.6, 3) + noise;
		noise = noise * env2;

		out = oscs + noise;
		out = out.clip2(1) * amp;
	out = GVerb.ar(out, 400, 10) ;
		Out.ar(outBus, out.dup);
	}).add;
)
/*
play{a =Ringz.ar(CoinGate.ar([5,10,4,7,6]/10 * MouseX.kr(0.1,2).round(0.25).poll,T2A.ar(Impulse.kr([5,5,5,10,10]))),[45,9e3,50,8e3,250],[6,1,10,1,3]/10,[1,0.1,3,0.1,0.8]).sin.sum.tanh!2 * 0.1;FreeVerb.ar(a);}

	Ndef(\ibeat).stop;

		Ndef(\beat).set(\speed, 1);
*/