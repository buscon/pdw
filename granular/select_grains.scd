//

(

//~path="/Users/marcello/Music/Samples/granulator/Long/*wav";//".resolveRelative++"Samples/*.wav";
~path="/Users/marcello/Music/Samples/Oscar/*.wav";//".resolveRelative++"Samples/*.wav";

~path.pathMatch;
~b = ~path.pathMatch.collect { |i| Buffer.readChannel(s, i, channels:[0])}; // put your folder path here
)
(
SynthDef(\gran_m, { arg out = 0, bufNum = 0, pos = 0, trigRate = 1, rate = 1, rate2 = 0, overlap = 4, amtRnd = 0, lfoR = 20, selectSample = 0, sampleList = ~b, dur = 0.1,
	amFreq = 64, amVol = 0,
	gate = 1.0, freqMIDI = 64,
	ffreq_low = 22000, drywet = -0.8, freeze = 0,
	panMax = 1, amp = 0.1, interp = 4, volume = 0.5, volume2 = 1, rndTrigRate = 0, speedRndTrigRate = 2, rndRate = 0, speedRndRate = 2, master_volume = 1;

    var trate, rndPos, ausgang, am, midiOsc, freqMod, sig, reverbered, chain;
	rndPos = LFNoise0.kr(lfoR, amtRnd);
	//freqMod = (2 ** ((freqMIDI - 64) / 12)).midicps/10;
	trate = trigRate + LFNoise0.kr(speedRndTrigRate, rndTrigRate) ;
	rate = rate + LFNoise0.kr(speedRndRate, rndRate);
	bufNum = Select.kr(selectSample * ~b.size, ~b);
	ausgang = TGrains2.ar(2, Impulse.kr(trate) , bufNum, rate + rate2, ((pos + rndPos).range(0,  BufDur.kr(bufNum))) , dur , 0, amp, 0.05, 0.5, 4);

	// AM
	am = SinOsc.ar( freqMIDI+amFreq, mul:amVol*1.5) * SinOsc.ar( (freqMIDI+amFreq)/2, mul:amVol*1.5);
	// ausgang = ausgang * midiOsc;

	//ausgang = RLPF.ar(ausgang, ffreq_low, 0.9);
	ausgang = XFade2.ar(ausgang, ausgang * am, amVol.linlin(0, 1, -1, 1));
	//ausgang = EnvGen.kr(Env.adsr(attackTime: 0.01, sustainLevel: 1, decayTime: 0.5, releaseTime:1),gate, Latch.kr(gate,gate)) * ausgang;
	//ausgang = Array.fill(8, CombN.ar(ausgang, 0.2, {rrand(0.05, 0.01)}, {rrand(0.3, 0.01)} , 1/8));
	ausgang = Mix.new(ausgang)!2 * volume  * master_volume * volume2;


	reverbered = GVerb.ar(ausgang, 100, 2 );

	//sig = XFade2.ar(ausgang, reverbered, drywet);
	Out.ar(out, reverbered );

}).add;
)



//b = Buffer.read(s, "/Users/marcello/Music/Supercollider/different bodies/samples/french_voice_no_silence_mono.wav");
//b = Buffer.read(s,  ~b.at(0));
~b.at(2)

g = Synth(\gran_m, [ \master_volume, 0, \amtRnd, 0, \lfoR, 10, \sampleList, ~b]);
g.set(\master_volume, 0.2, \volume, 0.5, \pos, 0.2, \trigRate, 1,\amtRnd, 0.2, \rate, 0.5);
g.set(\sampleList, ~b);
g.free;
g.set(\selectSample, 0.8);
(
g = Synth(\gran_m, [\bufNum, ~b.at(0), \master_volume, 0, \amtRnd, 0, \lfoR, 10]);
g.set(\master_volume, 1, \volume, 1, \pos, 0.2, \trigRate, 10,\amtRnd, 0);

)
g.free


g.set(\pos, 0.3);
g.set(\bufNum, ~b.at(5));
~b.at(6)
)
g.free
g.set(\amtRnd, 0.05);
g.set(\amtRnd, 1);
g.set(\amtRnd, 0);
g.set(\trigRate, 10);
~b.at(2)
g.set(\lfoR, 30);
g.set(\lfoR, 5);
g.set(\rndTrigRate, 0);
g.set(\rndTrigRate, 1);
g.set(\speedRndTrigRate, 12);
g.set(\speedRndTrigRate, 6);
g.set(\freeze, 1);
g.set(\rate, 1);

g.set(\master_volume, 0.2);
b = NetAddr("127.0.0.1", 57120);

b.sendMsg("/activityNormal1", 0.1);
(
//g.set(\master_volume, 1.2);
var port = 9000;
OSCdef (\activityNormal, { |msg|
	//("ActivityAll: " ++ msg[1]);

		//g.set(\freeze, -1);
	g.set(\volume, msg[1].linlin(0, 1, 0, 1));
	g.set(\volume2, msg[1].linlin(0.5, 1, 1, 2.5));

	g.set(\amtRnd, msg[1].linlin(0.5, 1, 0.05, 0.5));
	g.set(\dur, msg[1].linexp(0, 1, 0.5, 0.01).postln);

	g.set(\trigRate, msg[1].linlin(0.3, 1, 2, 30));
	},
	'/activityNormal1',
	nil,
	port
);
OSCdef (\activityNormal2, { |msg|
	//("ActivityNormal2: " ++ msg[1]).postln;

		//g.set(\freeze, -1);
	h.set(\volume, msg[1].linlin(0, 0.1, 0, 3).lag(2));
	//h.set(\trigRate, msg[1].linexp(0.5, 2, 2, 20));
	},
	'/activityNormal2',
	nil,
	port
);

OSCdef (\activitySensitive, { |msg|
	//("ActivityAll: " ++ msg[1]).postln;

		//g.set(\freeze, -1);
	g.set(\volume, msg[1].linlin(0, 0.15, 0, 1));
	//g.set(\rate, msg[1].linlin(0.01, 1, 0, 1).postln);
	//h.set(\volume, msg[1].linlin(0, 0.3, 0, 1));
	//h.set(\rate, msg[1].linlin(0.01, 1, 0, 1).postln);
		//	g.set(\rate2, msg[1].linlin(0.9, 1, 0, 0.5));

			//g.set(\trigRate, msg[1].linexp(0.4, 1, 1, 60));ì

	},
	'/activitySensitive1',
	nil,
	port
);

OSCdef (\centerX, { |msg|
	//("centerX: " ++ msg[1]).postln;
	g.set(\selectSample, (msg[1].linlin(0.1, 0.9, 0, 1) ));
	//.range(0.0,1.0).round(0.1).postln);
	},
	'/centerX1',
	nil,
	port
);

OSCdef (\centerX2, { |msg|
	//("centerX: " ++ msg[1]).postln;
	h.set(\pos, (msg[1].linlin(0.05, 0.95, 0, 1) ));
	//.range(0.0,1.0).round(0.1).postln);
	},
	'/centerX2',
	nil,
	port
);

OSCdef (\height, { |msg|
	//("height: " ++ msg[1]).postln;
		//g.set(\ffreq_low, msg[1].linexp(0.1, 0.7, 50, 22000));
		g.set(\rate, msg[1].linlin(0, 0.7, 0, 1).postln);



	},
	'/height1',
	nil,
	port
);

OSCdef (\width, { |msg|
	("width: " ++ msg[1]).postln;
	//g.set(\drywet, msg[1].linlin(0.3, 1, -1, -0.5));
	},
	'/width',
	nil,
	port
);

OSCdef (\freeze, { |msg|
	("freeze: " ++ msg[1]).postln;
	//g.set(\drywet, msg[1].linlin(0.3, 1, -1, -0.5));
	},
	'/freeze',
	nil,
	port
);
)

trace