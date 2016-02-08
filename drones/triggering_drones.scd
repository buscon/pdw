(

{

var trig,mx;

mx=MouseX.kr(0.0,1.0);

trig= mx>0.5;			//this is a UGen which compares mx to the constant signal 0.5 at krate


SinOsc.ar(440,0,0.1*trig)

}.play;

)


(	//trigger in a given region

{

var trig,mx,my;

mx=MouseX.kr(0.0,1.0);

my=MouseY.kr(0.0,1.0);

trig= if((mx>0.3) * (mx<0.5) * (my>0.3) * (my<0.7),1,0);

//if is a UGen here, * is equivalent to logical AND

//SinOsc.ar(440,0,0.1*trig)
			PinkNoise.ar(Decay.kr(trig, 0.01));


}.play;

)
Scale.rast.ratios.size;
* 52
(

    // strummable guitar

    // use mouse to strum strings

{

	var pitch, mousex, out;

	//pitch = Scale.rast.cents;		// e a d g b e
	pitch = Scale.rast.ratios * 0.2;// * 52;
	mousex = MouseX.kr;

	out = Mix.fill(pitch.size, { arg i;

		var trigger, pluck, period, string;

		// place trigger points from 0.25 to 0.75

		trigger = HPZ1.kr(mousex > (0.1 + (i * 0.1))).abs;

		pluck = PinkNoise.ar(Decay.kr(trigger, 0.05));

		period = pitch.at(i);

		string = AdCVerb.ar( LPF.ar(Ringz.ar(pluck, {rrand(500, 10000)}.dup(12) * period.poll,{rrand(0.5, 1.5)}.dup(12), 0.1).mean, 10000)) * 0.2;
		//string = CombL.ar(pluck, period, period, 4);

		//Pan2.ar(string, 0);// i * 0.2 - 0.5);

	});

	LPF.ar(out, 12000);

	LeakDC.ar(out);

}.play;

)