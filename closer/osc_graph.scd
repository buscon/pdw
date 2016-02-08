movingAverage
("/Users/marcello/Music/Supercollider/PdW/beat/timpani.scd").load;
("/Users/marcello/Music/Supercollider/PdW/ligeti/main.scd").load;
(
Ndef(\noise, { arg val = 0, numsamp = 10,amp = 0.5, cutoffFreq = 5000;
	//var numsamp = 40;
	val = (RunningSum.kr(val.squared, numsamp) / numsamp).sqrt;

	SendTrig.kr(Impulse.kr(10), 0, val);
	//	Out.ar(0, LPF.ar(PinkNoise.ar(amp.linlin(0, 1, 0, 0.3)), cutoffFreq));
}).play;
)
x = Synth(\noise);
// what is the speed of receiving osc data?
// we need to reiceve the data at higher sampling rate and then interpolate the values

(

var prox = SensorData.new, val, triggered = 0, touch_thres = 0.7, debug = 0, streamTimpani;

~t = Main.elapsedTime.asInt;
~now = (~t.asInt)-0.1;
OSCdef( \amount1, { |msg|
	msg;
	~raw = msg[1];
	if(debug ==1, {("~raw: "++~raw).postln});
	//x.set(\val, e);
	/*
	~fw.set(\scale_tones, e.linlin(0,1, 1, 200));
	~fw.set(\amp, e.linlin(0,0.2, 0.0, 0.2));
*/
	prox.addValue( ~raw );
	prox.stlen_( 5 );
	prox.ltlen_( 30 );

	//Ndef(\noise).set(\val, e);
	~mas = prox.shortSMA;

	~expMa = prox.expMA;

	~mal = prox.longSMA;

	if(debug ==1, {("~mas: "++~mas).postln});
	if(debug ==1, {("~mal: "++~mal).postln});

	~fw.set(\amp, ~expMa.linlin(0.05, 0.1, 0, 0.5));

	~fw.set(\step, ~expMa.linlin(0.1, touch_thres -0.2, 0.3, 1));
	~fw.set(\scale_tones, ~expMa.linlin(0.2, touch_thres - 0.2, 4, 150));


			~t = Main.elapsedTime.asInt;
	if(~expMa > touch_thres && (~now < ~t) && triggered == 0,
		{
			x = [70,90,120].choose; y = exprand(0.01,7);Synth(\Synth3, [\ress, y, \choose, x]);Synth(\Synth4, [\choose, x]);
			~fw.set(\scale_val, exprand(0.2, 0.8).postln);
			~now = (~t.asInt)+0.01;
			//~fw.set(\amp2, 0);

			triggered = 1;
	});
	if(~expMa < touch_thres, {
		triggered = 0;
//		~fw.set(\amp2, 1);

	});

	//x.set(\amp, ~val.linlin(0, 0.2, 0, 1));
		//x.set(\cutoffFreq, ~val.linlin(0.2, 0.7, 1000, 10000));
	//~val = LPF.kr(e);
	}, "/closer/sender1/channe2",
nil,
	9677);
/*
OSCdef(\filteredVal, { arg msg;
	"filtered: ".post;
	f = msg[3].postln;
},'/tr', s.addr);

OSCdef( \amount2, { |msg|
	msg.postln;
	f = msg[1];
	}, "/centerX1",
nil,
	9000);
*/
)
(
	m = SWPlotterMonitor.new( {
    //data to plot
    [
    [~raw, ~mas, ~expMa], // view the two streams superimposed
    //[~~e - ~f], // view their differene
    //[(~e- ~f).sign] // view sign of difference
    ]},
    100, //nr of points to plot
    3, // channels
    0.25, // plot dtime
	2 // write every n data points
    ).start;
)
m.stop
m.free
m.start