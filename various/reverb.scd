(
SynthDef(\AdCverb, {|in= 0, out= 0, mix= 0.5|
	var src= InFeedback.ar(in, 2);
	Out.ar(out, AdCVerb.ar(src, revTime));
}).add;

SynthDef(\AdCverb, {|in= 0, out= 0, |
	var src= InFeedback.ar(in, 2);
	Out.ar(out, GVerb.ar(src, roomsize, revtime));
}).add;

)
~myBus= Bus.audio(s, 2);
a= Synth(\verb, [\in, ~myBus, \out, 0])		//the 2ch reverb effect synth

Ndef(\test).play(~myBus)	//route via reverb
Ndef(\test, {Impulse.ar([3, 4])})	//a stereo sound
Ndef(\test).stop
Ndef(\test).play(0)		//no reverb
Ndef(\test).stop

// other example

(
SynthDef(\sin, {|out=0, mod=400|
        Out.ar(out, SinOsc.ar(SinOsc.kr(12, 0, mod * [1,1.2]), 0, 0.2))
}).add;

SynthDef(\rev, {|in=666, out=0|
        // dummy 'in=666' bus because I don't want all audio on the
        // main bus (0) to go into the reverb
        var input = InFeedback.ar(in, 2);
        Out.ar(out, GVerb.ar(input) * 0.3)
}).add;
)

p = ProxySpace.push(s)

~sin.ar(2);
~sin = (instrument: \sin)

~rev.ar(2);
~rev = (instrument: \rev);

// ProxySpace automagically creates SynthDef for you with their own Bus
// assign 'in' ~rev to the private Out bus from ~sin
~rev.set(\in, ~sin.bus.index);

~rev.play;
~rev.stop;

// another example

p = ProxySpace.push(s.boot);

// a very simple sound source:
~sound = { Decay2.ar(Dust.ar(4 ! 2), 0.001, 0.01, PinkNoise.ar(1)) };
// play it directly
~sound.play;

// make a reverb for it:
~rvb = { var in = ~sound.ar(2); FreeVerb.ar(in, 0.6, 10) * 1 };
~rvb.play;

// if you only want to hear the reverberated signal:
~sound.stop;

// add another source:
~rvb = { var in = ~sound.ar(2) + ~sound2.ar(2); FreeVerb.ar(in, 0.6, 10) * 3  };
~sound2 = { max(LFPulse.kr(1, 0.5, 0.1, 0.2), LFPulse.kr(0.05, 0.5, 0.1)) * SinOsc.ar(400) };

// assuming you want to mix several sources without restarting the reverb:
~rvb[0] =  Ndef(\decay, { Decay2.ar(Impulse.ar(1, 0, 0.1))});
~rvb[0].stop
~rvb[0]

~rvb2[0] = Ndef(\dust, { Dust.ar([5,6], 2)}).play; // another one
~rvb2[0].stop;
~rvb[10] = \filter -> { |in| FreeVerb.ar(in, 0.6, 10) * 1 };
~rvb.play;
