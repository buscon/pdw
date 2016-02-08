(

Ndef(\trigDrones, {| out = 0, speed = 0, select = 0, decaytime = 0.5, volume = 0, volume2 = 1, sensitive = 0, rate = 1, octave = 0.5 |

	var pitch, mousex, ausgang, size, pluck, period, string,trigger = 0, triggerNote, timer;

	//pitch = Scale.rast.cents;		// e a d g b e
	pitch = [1,9/8,6/5,4/3,3/2,8/5,7/4] * octave * 0.5;// * 52;
	mousex = select;//

//	mousex = MouseX.kr; speed = MouseY.kr(0, 4);
size = 100;

	trigger = Mix.fill(size, { arg i;


		// place trigger points from 0.25 to 0.75
	//timer = Timer.kr(trigger);  // how long since the last trigger?
		trigger =  HPZ1.kr(mousex > (0.01 +(i * size.reciprocal)).postln).abs;


	});
	//trigger = triggerNote;// +  HPZ1.kr(speed);
	pluck = PinkNoise.ar(Decay.kr((trigger + Impulse.kr(speed, 0, 5) + Trig.kr(sensitive, 0.05)), 0.05)) * volume * volume2;

	period = Select.kr(mousex * pitch.size, pitch);

	ausgang = RLPF.ar(Ringz.ar(pluck, {rrand(500, 10000)}.dup(12) * period * rate,{rrand(0.5, 1.5)}.dup(12) * decaytime, 0.1).mean, 8000 ) * 0.02;
		//string = LPF.ar(Ringz.ar(pluck, {rrand(500, 10000)}.dup(12) * period.poll,{rrand(0.5, 1.5)}.dup(12), 0.1).mean, 10000) * 0.2;

	//ausgang = CombL.ar(string, period, period, 4);
	//ausgang = LPF.ar(ausgang, 12000);

	ausgang = LeakDC.ar(ausgang) ;
	ausgang = GVerb.ar(ausgang, 200, 2);
//	ausgang = AdCVerb.ar( ausgang, 3 ) ;
	Out.ar(out,ausgang);

});
)


(

//g.set(\master_volume, 1.2);
var port = 9000, now;
t = Main.elapsedTime.asInt;
now = (t.asInt)-0.1;

OSCdef (\activityNormal, { |msg|
	//("ActivityAll: " ++ msg[1]);

		//g.set(\freeze, -1);
			Ndef(\trigDrones).set(\volume, msg[1].linlin(0, 0.06, 0, 1));
	Ndef(\trigDrones).set(\volume2, msg[1].linlin(0.1, 1, 1, 2));
	Ndef(\trigDrones).set(\speed, (msg[1].linlin(0.06, 1, 0, 15) ));
	Ndef(\trigDrones).set(\rate, (msg[1].linlin(0.9, 0.95, 1, 1.25) ));

	Ndef(\trigDrones).set(\sensitive, (msg[1].linlin(0.05, 0.06, 0, 1) ));
		t = Main.elapsedTime.asInt;

		if( (msg[1] > 0.99) && (now < t),
			{

				"octave: ".post;
				Ndef(\trigDrones).set(\octave, ([1, (5/4), 3/2].wchoose([0.4,0.3,0.3]) * [1, 1/4, 1/6, 1/8, 1.5, 2].wchoose([0.1, 0.2, 0.2, 0.2, 0.15, 0.15]) * 0.45).postln );
				now = (t.asInt)+1;
				"now: ".post;now.postln;
				"time: ".post;t.postln;
			"=======".postln

		} );

	},
	'/activityNormal1',
	nil,
	port
);

OSCdef (\centerX, { |msg|
	//("centerX: " ++ msg[1]).postln;
	Ndef(\trigDrones).set(\select, (msg[1].linlin(0.1, 0.9, 0, 1) ).postln);
	//.range(0.0,1.0).round(0.1).postln);
	},
	'/centerX1',
	nil,
	port
);
)
