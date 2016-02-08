(
Ndef(\beat, { arg out = 0;
	var hh, blip, ausgang, crackle;

	hh =
//	Impulse.kr([16,8,4],0,[0.3,0.5,0.6]).lag.poll
	Impulse.kr(MouseX.kr(2,16).round(4),0).lag

	* Crackle.ar({BrownNoise.kr(1).abs.lag}.dup(2)*1.8) * 4;


	blip =GVerb.ar( [Impulse.kr(2,0)+Impulse.kr(4,0.5)] * Blip.ar(55.9,50,0.1,)!2 ,1,1);

	ausgang = (hh + blip).tanh;
	Out.ar(out, ausgang);

}).play;
)
// aa
