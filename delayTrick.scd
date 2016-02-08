b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav"); // remember to free the buffer later.
b.free
(
~path="/Users/marcello/Music/Samples/metabody_tolouse/*.wav";
~path.pathMatch;
~b = ~path.pathMatch.collect { |i| Buffer.readChannel(s, i, channels:[0])}; // put your folder path here
)

//aa

StageLimiter.activate
b.bufnum
~b[11]
~a.set(\bufnum, ~b[4].bufnum);
~a.set(\rate, 0.2);
~a.set(\rate, 0.5);
~a.set(\rate, 2);
~a.set(\rate, 3);
~a.stop;
~a.set(\rate, 0.25);

(
~a = Ndef(\help_PlayBuf, {| out = 0, bufnum = 0, rate = 1 |
	var output,noise, phasor, sample, latch, bass, delay;

    output = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), 1, 0, loop:1, doneAction:2);
	noise = LFNoise0.ar(50).range(0, 2);
	phasor= Phasor.ar(0, 0.027 * rate
		//* LFNoise0.ar(1).range(0.95, 1.05)
		, 100, 400) ;
	sample = Changed.ar(phasor, 0.5);
	latch = Latch.ar(noise, sample);//.poll(sample);
	delay = DelayN.ar(output, 10,
//		LPF.ar(Latch.ar(noise, sample).poll(sample), 10);
		OpLPF.ar(latch, 100);
	) * 0.2;
	delay = GVerb.ar(delay, 100, ) * 0.3;
	bass = SinOsc.ar((latch * 110 /2).linlin(0, 110, 60, 75),0 ,0.05) * EnvGen.ar(Env.perc(0.05, 1 * rate.reciprocal.poll), sample, doneAction:2);
	output = delay + bass;

	    Out.ar(out, output!2);
}).play;
)
s.meter
FreqScope.new
Latch
(
{Changed.ar(LFNoise0.ar(1000).range(0,1).poll, 0).poll}.plot
)
(
{
        var phasor= Phasor.ar(0, 0-MouseX.kr(0.01, 0.03), 500, 200);
        var sample= Changed.ar(phasor, 0.5); //difference - threshold detects jumps in phasor signal
        var sah= Latch.ar(phasor, sample).poll(sample);
        SinOsc.ar([sah, phasor], 0, 0.2);
}.play
)
(
{ Phasor.ar(0, 0.02).poll}.plot
)
