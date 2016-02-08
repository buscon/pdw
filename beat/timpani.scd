// Ressonance
(
SynthDef(\Synth3,
	{arg ress = 0, choose = 0, volume = 1;
		var klank, env;
		klank = Klank.ar(`[choose !12, {Rand(0.128,0.700)}!12],BrownNoise.ar(0.3));
		klank = klank;
		env = EnvGen.kr(Env.perc(0.07, ress), doneAction:2);
		Out.ar(0, klank*env.dup*0.000128*volume);
}).add;

//Attack

SynthDef(\Synth4,
	{arg ress = 0, choose = 0, volume = 1;
		var klank, env;
		klank = Klank.ar(`[choose !12, {Rand(0.128,0.700)}!12],BrownNoise.ar(0.3));
		klank = klank;
		env = EnvGen.kr(Env.perc(0, 1), doneAction:2);
		Out.ar(0, klank*env.dup*0.00128*volume);
}).add;
)

//{21.do{x = [70,90,120].choose; y = exprand(0.01,7).postln; Synth(\Synth3, [\ress, y, \choose, x]);Synth(\Synth4, [\choose, x]); y.wait;}}.fork;