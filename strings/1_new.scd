/*~stranga.set(\pitch, 0.8);
~stranga.set(\pitch_fine, 0.5);
Synth(\strangaS, [\volume, rrand(0.1, 0.4), \pitch, rrand(0.2, 0.8), \pitch_fine, rrand(0.3, 0.7), \pitch_dev, rrand(0.3, 0.7),]);
			Synth(\strangaS, [\volume, 0, \pitch, rrand(0.6, 1), \pitch_fine, rrand(0.3, 1), \pitch_dev, rrand(0.3, 0.7),]);

~stranga.set(\pitch, 0.6)
*/

(

~stranga = Ndef(\stranga, {arg speed = 0, volume = 0, volume2 = 1, pitch =0.8, pitch_fine =0.5, pitch_dev = 1, decay_time = 2, reverb_amt = 1, pan = 1,
	predelay = 0.048, combdecay=5, allpassdecay=1, revVol=0.31;
    var num_voices = 8, output, reverbed;
	//pitch = MouseY.kr;
	//speed = MouseX.kr(0, 10);
	//decay_time = MouseY.kr(6, 1);
	//pitch_dev = GrayNoise.kr(0.01).range(0.001, 0.009).poll;

	output = CombL.ar( (
		//Impulse.ar(speed.dup(num_voices), 0, 0.5) +
		Dust.ar(speed.dup(num_voices),0.5 * speed.linlin(0,10, 0.8, 1.4))), 0.1, {((
		gauss(0.002, pitch_dev.linlin(0, 1, 0.0001, 0.0005)).abs
		//0.004.rand+0.0003
		+ pitch_fine.linlin(0, 1, 0.0009,0.0001).lag(0.4)) * pitch.linlin(0, 1, 5, 0.5)
	) }.dup(num_voices), {decay_time.rand});
	output = RLPF.ar(output, pitch_fine.linlin(0, 1, 100, 3000 ), 0.3, 1);

	output = Pan2.ar(output, {1.0.rand2}.dup(num_voices));
	//output = Impulse.ar([3,4]);
	output = Mix.ar(output);

	output = output * volume * volume2;
	reverbed = output;

	//reverbed = Array.fill(8, LeakDC.ar(AllpassL.ar(RLPF.ar(reverbed*0.9,3000), 0.2, {0.19.rand+0.01}!2, 3, reverb_amt)) ) * 0.5;
	//reverbed = GVerb.ar(reverbed, 100);
    //};
	reverbed =  FreeVerb.ar(reverbed, 0.5, 0.5);

	output = Mix.new(reverbed+ output) ;
	output = LeakDC.ar(output);

	output = Pan2.ar(output, pan);

	Out.ar(0, output  * 0.25);
}).play;


SynthDef(\strangaS, {arg speed = 1, volume = 0, volume2 = 1, pitch =0.5, pitch_fine =0.5, pitch_dev = 0.0003, decay_time = 4, roomsize = 100, revtime = 3, trigger = 1, pan = 1;
    var num_voices = 8, output, reverbed;
	//pitch = MouseY.kr;
	speed = MouseX.kr(0, 10);
	//decay_time = MouseY.kr(6, 1);
	//pitch_dev = GrayNoise.kr(0.01).range(0.001, 0.009).poll;
//PinkNoise.ar(Decay.kr((trigger + Impulse.kr(speed, 0, 10) + Trig.kr(sensitive, 0.05)), 0.05 * decay_scale)) * volume * volume2;
	output = CombC.ar( PinkNoise.ar(Decay2.kr(Trig.kr(trigger, 0.01), 0.01, 0.1, 0.1).dup(num_voices)),  0.1, {((
		gauss(0.002, pitch_dev.linlin(0, 1, 0.0001, 0.0005)).abs
		//0.004.rand
		+ pitch_fine.linlin(0, 1, 0.0009,0.0001).lag(0.4)) * pitch.linlin(0, 1, 5, 0.5)) }.dup(num_voices), decay_time) ;
	output = RLPF.ar(output, pitch.linlin(0, 1, 300, 3000 ), 0.3, 1);

	output = Pan2.ar(output, {1.0.rand2}.dup(num_voices));
	//output = Impulse.ar([3,4]);
	output = Mix.ar(output);

	output = output * volume * volume2;
	reverbed = output;

	//reverbed = Array.fill(8, LeakDC.ar(AllpassL.ar(RLPF.ar(reverbed*0.9,3000), 0.2, {0.19.rand+0.01}!2, 3, reverb_amt)) ) * 0.5;
	//reverbed = GVerb.ar(reverbed, roomsize, revtime, drylevel:0);
    //};

	reverbed =  FreeVerb.ar(reverbed, roomsize, revtime)* EnvGen.ar(Env.perc(0.02, 3), 1, doneAction:2);

	output = Mix.new(reverbed+ output) ;
	output = LeakDC.ar(output);


	output = Mix.new(reverbed) + output;
	output = LeakDC.ar(output);

	output = Pan2.ar(output, pan);

	Out.ar(0, output  * 0.25);
}).add;
)