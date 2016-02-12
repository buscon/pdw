Ndef(\src, { Dust.ar(5 ! 2) });
Ndef(\fx, { CombL.ar(\in.ar(0 ! 2), 1, LFNoise1.kr(0.1).range(0, 0.1), LFNoise1.kr(0.1).range(2, 15)) });
Ndef(\out, { \in.ar(0 ! 2) }).play; // just an empty out

Ndef(\out).fadeTime = 5; // replace by 20
Ndef(\out) <<> Ndef(\src);
Ndef(\out) <<> Ndef(\fx) <<> Ndef(\src);


// another alternative
Ndef(\src, { Dust.ar(5 ! 2) }).play;
Ndef(\src, { Impulse.ar(5 ! 2) }).play;

Ndef(\src).fadeTime = 1;
Ndef(\src).put(3, \filter -> { |in| GVerb.ar(in) });

Ndef.clear
Ndef(\sig, {arg sp Impulse.ar(1); } ).play
Ndef(\sig).play;
//set the slot [1]
Ndef(\sig)[0] = ~dust
Ndef(\sig)[0] = ~impulse
~impulse = {arg speed =1; Impulse.ar(speed)};
Ndef(\sig).set(\speed, 4);
~dust = {arg speed =1; Dust.ar([speed,speed*3])};
Ndef(\sig)[10] = \filter -> { |in|  GVerb.ar(in) };
//erase slot [1]
Ndef(\sig)[1] = nil; 