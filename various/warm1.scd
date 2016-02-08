    { SinOsc.ar(340, LFTri.ar(100, 0, 60), 0.8)!2 }.play

{LFSaw.ar(50+(MouseX.kr(0,10).round(1)),0,0.5)}.scope

{LFSaw.ar(1102.5+(MouseX.kr(0,10).round(1)),0,0.5)}.scope

{Saw.ar(1102.5+(MouseX.kr(0,10).round(1)),0.5)}.scope

(

var numdetune=4;

{LPF.ar(Mix(LFSaw.ar(Array.rand(numdetune,1,1.01)*70,0.2, 0.3)), 1000)!2}.play

)

(

{
var num_of_synths = 16;
Mix.fill(num_of_synths,{

var freqmult, lpf_freq;


//between 1 +- 0.01

freqmult= 1+SinOsc.ar(LFNoise1.kr(rrand(0.25,1.0),4,5),pi.rand,0.01);

		lpf_freq = LFNoise1.kr(4,0.5, 0.5);
		LPF.ar(LFSaw.ar(70*(freqmult.poll),pi.rand,0.2), (300 * lpf_freq ), num_of_synths.reciprocal)


})!2

}.play

)
LFPar.ar(3

{Mix.fill(6,{|i| [LFTri, LFCub, LFPar].choose.ar(30*(2**i),pi.rand,10.rand.neg.dbamp) * 0.3})!2}.play

	Array.fill(6, {rrand(0.5, 1.5)});
(

z = {

Resonz.ar(

				Mix(Saw.ar(Array.fill(48, {gauss(1.0, MouseX.kr(0.01, 1.5)).poll})*80,0.3)),
500,
//MouseX.kr(100,20000,\exponential), // cutoff freq.

MouseY.kr(0.1, 1.0, \linear), // rq

0.5)!2; // mul

}.play

)

z.free;
	 { SinOsc.ar(50 + Pulse.ar(100, 0.15, 2000)) }.play