
{ Trig.ar(Impulse.ar(10), 0.1) * FBSineC.ar(FBSineN.ar(10).range(100, 2000), 0.5) }.play

(
SynthDef(\skit, { |out, freq=440, amp=1, sustain=0.8, release=0.5, gate=1, ring=1|
                                Out.ar(out, Pan2.ar(SinOsc.ar(freq) * amp * ring *
                                        (EnvGen.kr(Env.adsr(0.01, 0.2, sustain, release), gate, doneAction:2)), 0));
}).add;

SynthDef(\skat, { |out, freq=440, amp=1, sustain=0.8, release=0.5, gate=1, ring=1|
                                Out.ar(out, Pan2.ar(Saw.ar(freq) * amp * ring *
                                        (EnvGen.kr(Env.adsr(0.01, 0.2, sustain, release), gate, doneAction:2)), 0));
}).add;


Pdef(\b,Pbind(\instrument, \skit, \dur, 0.2, \freq, Pseq([1,2],inf) * 100, \ring, 1,
        \legato, Pwrand(#[0.5, 1.0], #[0.1, 0.9], inf), \amp, 0.5, )).play;
);
Pdef(\b).play;
Synth(\skat);
Synth(\skit);

(
t = TempoClock.default.tempo = 60/60;

Pbind(\instrument, Prand([\skat,\skit],inf), \dur, 0.1, \freq, Prand([0.5, 1,2],inf) * 100, \legato, 0.1 ).play;
)

p = Pbind(\legato, 0.1, \dur, 0.4, \midinote, Pseq([66, 74],inf), \lag, Pwhite(-0.05!3, 0.05)).play() 