// http://twitter.com/#!/alln4tural/status/99846300173991936
// http://soundcloud.com/tengototen/esoteric-tweet


// http://sccode.org/1-D

fork{loop{h=[5,7,8].choose*(2**(2..8).choose);play{Splay.ar({SinOsc.ar(exprand(h,h+(h/64)),0,0.1)}!64)*LFGauss.ar(9,1/4,0,0,2)};2.wait}};

fork{loop{h=[100,800,3000].choose;play{Splay.ar({SinOsc.ar(exprand(60,h),0,0.1)}!40)*LFGauss.ar(19,0.25,0,0,2)};8.wait}};

// really i wanted to do this:
fork{loop{h=([33,38,40].choose.midicps)*(2**((0 .. 5).choose));play{Splay.ar({SinOsc.ar(exprand(h-(h/256),h+(h/256)),0,0.1)}!64)*LFGauss.ar(19,1/4,0,0,2)};4.wait}};

// edit
3.midicps
fork{loop{h=([33,38,40].choose.midicps)*(2**((0 .. 5).choose));h.postln;play{Splay.ar({SinOsc.ar(h.gauss(MouseX.kr(1, 50)),0,0.1)}!64)*LFGauss.ar(6,1/4,0,0,2)};2.wait}};

{ LeakDC.ar( LFGauss.ar(MouseX.kr(1/8000, 0.1, 1), MouseY.kr(0.001, 0.1, 1)) * 0.1 )}.play;

(
{
    var trig, seq, freq;
    trig = Impulse.kr(24);
    seq = Drand([Dseq((1..5).mirror1, 1), Drand((4..10), 8)], 2000);
    freq = Demand.kr(trig, 0, seq * 100);
    SinOsc.ar(freq + [0,0.7]).cubed.cubed.scaleneg(MouseX.kr(-1,1)) * 0.1;
}.play;
)
[33, 38, 40].midicps

(
Ndef(\ambSin, { arg deviation = 10;
	var freq, freq_sel, output, trig;
	freq_sel = Dxrand([33, 38, 40]*2, inf);
	trig = Impulse.kr(2);
	freq = Demand.kr(trig, 0, freq_sel.dpoll.midicps.dpoll);
	output = SinOsc.ar(freq * 1.gauss(1),0,0.1)
	* LFGauss.ar(2,1/4,0,1,0)

	;
		output = Splay.ar(output);
	Out.ar(0, output * 0.25);
}).play;
)

// or more like a constant drone:
fork{loop{h=([33,38,40].choose.midicps)*(2**((0 .. 4).choose));play{Splay.ar({SinOsc.ar(exprand(h-(h/64),h+(h/64)),0,0.1)}!8)*LFGauss.ar(5,1/4,0,0,2)};0.25.wait}};
// primes
fork{loop{h=(4 .. 100).choose.nthPrime*(2**(0..3).choose);play{Splay.ar({SinOsc.ar(exprand(h-(h/256),h+(h/256)),0,0.1)}!64)*LFGauss.ar(19,1/4,0,0,2)};2.wait}};
// Fibonacci
fork{loop{h=(List.fib(15).choose)*(2**(0..4).choose);play{Splay.ar({SinOsc.ar(exprand(h-(h/64),h+(h/64)),0,0.1)}!64)*LFGauss.ar(19,1/4,0,0,2)};2.wait}};

// but they were too long.
// __________________________
// inspired by http://sctweets.tumblr.com/post/8379573991/sinosc
// (http://soundcloud.com/rukano)