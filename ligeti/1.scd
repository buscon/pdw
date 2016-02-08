{ Mix.fill(12, { LFPulse.ar(exprand(80, 5000), 0, 0.2, SinOsc.ar(1000.0.rand, 0, 0.05).max(0).poll) }); }.play;
{ Mix.fill(24, { GVerb.ar(SinOsc.ar( (MouseX.kr(20, 500) * exprand(5.0, 10.0)).postln, 0, SinOsc.ar(exprand(0.01, 0.3).postln, 0, 0.01)),  100, spread: 30) } )}.play

FreqScope.new

2.do({ Pbind(  \note, Pbrown(20, 50, 0.1, inf) ,\dur, 0.05.rand ).play });
(
       SynthDef(\foo, { arg out=0, freq=440, amp=0.1, pan=0, gate=1, mul=100;
                                var z;
	freq = Array.fill(4, Demand.kr(Impulse.kr(4), 0, Dbrown(0, 15, 1, inf)*mul));
                                z = Array.fill(4,LPF.ar(
                                                Mix.new(VarSaw.ar(freq + [0, Rand(-0.4,0.0), Rand(0.0,0.4)], 0, 0.3, 0.3)),
		XLine.kr({Rand(4000,5000)}, {Rand(2500,3200)}, 1)
	) * Linen.kr(gate, {0.05.rand}, 0.7, 0.3, 2));
                                OffsetOut.ar(out, Pan2.ar(z, pan, amp));
                        }, [\ir]).add;
)
a = Synth(\foo, [\note,Pbrown(20, 50, 0.1, inf) ,\dur, 0.2.rand, \transpose, rrand(0.0,20.0)]);
a.play;
(
10.do(
	{
		Synth(\foo, [\note, Pbrown(0, 20, 0.1, inf) ,\dur, 0.01.rand, \amp, 0.00001]);
});
)
Drand([Dseq((1..5).mirror1, 1), Dxrand((4..10), 8)], 2000).plot;

Demand


(
{
    var trig, seq, freq;
    trig = Impulse.kr(12);
    seq = Drand([Dseq((1..5).mirror1, 1), Drand((4..10), 8)], 2000) * Drand([1,2,4,8],2000);
    freq = Demand.kr(trig, 0, seq * 100);
    SinOsc.ar(freq + [0,0.7]).cubed.cubed.scaleneg(MouseX.kr(-1,1)) * 0.1;
}.play;
)
