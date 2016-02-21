/*
Synth(\string, [\pan, -1]);
~string.set(\freq_dev,0.6);
Synth(\string,[\pan, 1, \sustain, 3, \freq_dev, 10]);
~string = Synth(\string, [\pan, -1]);
~string2 = Synth(\stringS, [\pan, 1]);
FreqScope.new
Synth(\stringS, [\pan, 1]);

*/

(
~string = Ndef(\string, {arg out=0, freq=211, freq2 = 0, pan=0, mx = 10, mx2 = 0,sustain=0.5, volume=0, volume2 = 1, sgate = 0, sensitive = 0, freq_dev = 0.5, freq_scale = 1, brFreq = 400, lpfF = 3000, decay = 0.3;
	var pluck, period, string, impulse, trig, res_num = 12;

	freq=freq + freq2;// + MouseY.kr(12,78).round(2) ;

	//mx=MouseX.kr(0,50).poll  ;

	impulse =  Dust.ar(mx + mx2, );
	//freq = Demand.ar(impulse, 0, Drand([60, 67, 64, 72, 58], inf)).midicps;
	freq = Demand.ar(impulse, 0, Dwhite((freq-freq_dev), (freq+freq_dev), inf)!res_num)  * freq_scale;
	sgate = Demand.ar(impulse, 0, Dseq([1,0], inf)) + sgate;

	//sustain = Demand.ar(impulse, 0, Dwhite(0.4, 1.0, inf));

	period = freq.reciprocal;//Array.fill(4, {freq.reciprocal.rand});

	pluck = BrownNoise.ar(0.2) * EnvGen.ar(Env.perc(0.02, decay), sgate);

	//string = CombL.ar(pluck, 0.1, period, {sustain.rand}*6);

	string = Splay.ar(CombL.ar(pluck, 0.2, period,  {sustain.rand}*1) );
	//freq.poll;
	//string = BRF.ar(string, brFreq, 0.5);
	//string = Median.ar(3, string);
	string = LeakDC.ar(LPF.ar(Pan2.ar(string, pan), lpfF)) * volume * volume2;
//	string = GVerb.ar(string.clip2, 200, 1) * 0.5;
//	string = GVerb.ar(string, 100, 1.85, 0.41, 0.19, 0.71, 0.35, 0.28 ) * 0.5;
//	string = GVerb.ar(string, 20, 1.24, 0.1, 0.95, 0.71, 0.17, 0.14 ) * 0.5;


	Out.ar(out, string.clip2);
}).play;

// more complexity, maybe BPF or BRF ?

)

/*
SynthDef(\stringSold, {arg out=0, freq=211, freq2 = 0, pan=0, mx = 0,sustain=0.5, amp=0.5,sgate = 0, sensitive = 1;
	var pluck, period, string, impulse, trig, res_num = 6;

	freq=freq + freq2;// + MouseY.kr(12,78).round(2) ;



	impulse =  Trig.ar(sensitive, 0.05);
	//freq = Demand.ar(impulse, 0, Drand([60, 67, 64, 72, 58], inf)).midicps;
	freq = {rrand((freq-0.5), (freq+0.5))}!res_num;
	sgate = impulse;

	sustain = {rrand(0.4, 1.0)};

	period = freq.reciprocal;//Array.fill(4, {freq.reciprocal.rand});

	pluck = BrownNoise.ar(0.2) * EnvGen.ar(Env.perc(0.01, 0.05), sgate);

	//string = CombL.ar(pluck, 0.1, period, {sustain.rand}*6);

	string = Splay.ar(CombL.ar(pluck, 0.2, period, {sustain.rand}*1) );
	//freq.poll;

	string = LeakDC.ar(LPF.ar(Pan2.ar(string, pan), 12000)) * amp;
	string = FreeVerb.ar(string, 0.5, 0.3);
	//string = GVerb.ar(string, 100, 2.85, 0.41, 0.19, 0.71, 0.35, 0.28 ) * 0.5;
//	string = GVerb.ar(string, 20, 1.24, 0.1, 0.95, 0.71, 0.17, 0.14 ) * 0.5;
	DetectSilence.ar(string, doneAction:2);
	string = Pan2.ar(string, pan);
	Out.ar(out, string);
}).add;


)

-17.dbamp
(
var speed, speed2,  val, val2,  longval2, longval, meanval, peak, changePos = 0;
speed = SensorData.new;
speed2 = SensorData.new;
//speed3 = SensorData.new;

speed2.stlen_( 5 );
speed2.ltlen_( 50 );
speed.stlen_( 6 );
speed.ltlen_( 50 );

OSCdef( \minibeePost, { |msg|
	var absValue, absValue2;

	//("full messages" + msg).postln;

	if ( msg[1] == 2,{

		x = msg[2];
		y = msg[3];
		z = msg[4];
// +pow(z,2)
		absValue = (pow(x,2)+pow(y,2)+pow(z,2)).sqrt;

		speed.addValue( absValue );
//speed.lastPeak.postln;
		//speed.data.plot;
		//speed.shortIntegral.postln;
		val = speed.shortStdDev.explin(0.00034, 0.1, 0.00000001, 1);
	//	speed3.addValue(val);
		//speed3.shortMean.postln;

		longval = speed.longStdDev.linlin(0.001, 0.1, 0.0, 1);

		~a.set( \volume, val.linlin(0, 0.0001 , 0, 1));
		~a.set( \sustain, val.linlin(0, 1 , 5, 0.3));

//		Ndef(\gran).set( \volume2, val.linlin(0.0001, 0.7, 1, 2.0));
//		Ndef(\gran).set( \volume3, val.linlin(0.7, 1, 1, 1.5));

		~a.set( \freq, val.linexp(0.5, 1, 211, 250));

		~a.set( \freq2, val.linexp(0.8, 1, 0, 100));
		~a.set( \mx, val.linlin(0, 1, 0, 40));

/*		Ndef(\gran).set( \amtRnd, val.linlin(0.5, 1, 0.001, 0.2));
		Ndef(\gran).set( \frate, val.linlin(0.7, 1.0, 1, 1.5));
		Ndef(\gran).set( \dur, val.linlin(0.8, 1.0, 0.2, 2));
*/

		if(speed.lastPeak[0] > 1.1,// && changePos== 0,
			{
				speed.lastPeak[0].postln;
//				Ndef(\gran).set( \pos, 1.0.rand);
//				Ndef(\gran).set( \rate,  ~pitch_grain1 * Scale.whole.ratios.choose);

			}
		);


	});
		if ( msg[1] == 2 ,{
		x = msg[2];
		y = msg[3];
		z = msg[4];
// +pow(z,2)
		absValue2 = (pow(x,2)+pow(y,2)).sqrt;

		speed2.addValue( absValue2 );

		val2 = speed2.shortStdDev.explin(0.00035, 0.1, 0.00000001, 1);
		longval2 = speed2.longStdDev.linlin(0.0002, 0.1, 0.0, 1);





		Ndef(\gran2).set( \amtRnd, val.linlin(0.5, 1, 0.001, 0.2));
		Ndef(\gran2).set( \frate, val.linlin(0.7, 1.0, 1, 1.5));
		Ndef(\gran2).set( \dur, val.linlin(0.8, 1.0, 0.2, 2));

		Ndef(\gran2).set( \volume, val2.linlin(0, 0.0001 , 0, 1));

		Ndef(\gran2).set( \volume2, val2.linlin(0.1, 0.7, 1, 2.0));
		Ndef(\gran2).set( \volume3, val2.linlin(0.7, 1, 1, 1.5));

		Ndef(\gran2).set( \trigRate1, val2.linlin(0.001, 0.5, 2, 12)); // mean or val?
		Ndef(\gran2).set( \trigRate2, val2.linlin(0.3, 0.8, 0, 10));

		Ndef(\gran2).set( \amtRnd, val2.linlin(0.5, 1, 0.001, 0.2));
		Ndef(\gran2).set( \frate, val2.linlin(0.7, 1.0, 1, 1.5));
		Ndef(\gran2).set( \dur, val2.linlin(0.8, 1.0, 0.2, 2));

		//Ndef(\gran2).set( \dur, val2.linlin(0.6, 1.0, 0.3, 0.1));

		if(speed2.lastPeak[0] > 0.9,// && changePos== 0,
			{
								speed2.lastPeak[0].postln;

				Ndef(\gran2).set( \pos, 1.0.rand);
				Ndef(\gran2).set( \rate,  ~pitch_grain2 * Scale.whole.ratios.choose);

			}
		);


	});

}, "/minibee/data" );
)
*/