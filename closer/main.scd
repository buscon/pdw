tr
("/Users/marcello/Music/Supercollider/PdW/beat/timpani.scd").load;
("/Users/marcello/Music/Supercollider/PdW/ligeti/main.scd").load;

("/Users/marcello/Music/Supercollider/PdW/drones/droneCymbal.scd").load;

// take glitch sound, and make it Env.perc and reactive to touch

(
// debug 0, no debug
// debug 1, print all data
// debug 2, print all data when > touch_thres
var prox = SensorData.new, val, triggered = 0, touch_thres = 0.4, debug = 2, aTi, pTi, stTi, time, now, oscar =  NetAddr("192.168.1.7", 8000), oscar_there = 1,
data_sel, data_touch, which_data = 1, freq;

aTi = [50,70,90,120,100, 150];	// array of the pitches of the timpani
aTi = [50,70,90,Prand(aTi),120,100, 150];
pTi = Pxrand(aTi, inf);				// make the Pattern
stTi = pTi.asStream;				// have the Pattern make a Stream

time = Main.elapsedTime.asInt;
now = (time.asInt)-0.1;

data_sel = { arg val, which;
	var res, env;

	res = case
		{ which == 0} {

	}
	{ which == 1} {
		~fw.set(\amp, ~expMa.linlin(0.05, 0.15, 0, 0.7)); ~fw.set(\step, ~expMa.linlin(0.1, (touch_thres - 0.2), 0.3, 1)); ~fw.set(\deviation, ~expMa.linlin(0.2, touch_thres, 4, 150));
	}
	{ which == 2} {
		var env, env2;
		~drC.set(\volume, ~expMa.linlin(0.05, 0.15, 0, 0.7));
		//env = ControlSpec(100, 8000, 4); ~drC.set(\lowPassFreq, env.map(~expMa.linlin(0.1, touch_thres, 0, 1)).postln); env2 = ControlSpec(2, 1, 4); ~drC.set(\lowPassQ, env.map(~expMa.linlin(0.1, touch_thres, 0, 1)));
		~drC.set(\lowPassFreq, ~expMa.linexp(0.1, touch_thres, 100, 8000)); ~drC.set(\lowPassQ, ~expMa.linlin(0.1, touch_thres, 2, 1));

	};
	res;
};

data_touch = { arg val, which;
	var res;

	res = case
		{ which == 0} {

	}
	{ which == 1} {
			freq = stTi.next; y = exprand(0.01,7);
			Synth(\Synth3, [\ress, y, \choose, freq, \volume, 1.5]);Synth(\Synth4, [\choose, freq, \volume, 1.5]);
			~fw.set(\scale_val, exprand(0.2, 0.7));
			now = (time.asInt)+0.01;
	}
	{ which == 2} {

		~drC.set(\freq_scale, Scale.rast.ratios.choose.linlin(1, 1.9, 0.2, 1.5).postln);
	};
	res;
};


OSCdef( \amount1, { |msg|
	msg;
	~raw = msg[1].explin(0.3, 0.6, 0.001, 1);

	//x.set(\val, e);
	/*
	~fw.set(\scale_tones, e.linlin(0,1, 1, 200));
	~fw.set(\amp, e.linlin(0,0.2, 0.0, 0.2));
*/
	prox.addValue( ~raw );
	prox.stlen_( 1  );
	prox.ltlen_( 30 );

	//Ndef(\noise).set(\val, e);
	~mas = prox.shortSMA;

	~expMa = prox.expMA.linlin(0, 0.9, 0, 1);//.explin(0.04, 0.5, 0.001, 1);

	~mal = prox.shortStdDev;

	if(debug ==1, {
	("~raw: "++~raw).postln
	("~mas: "++~mas).postln;
	("~expMa: "++~expMa).postln;

	("~mal: "++~mal).postln;
	});
	if(oscar_there > 0, {
		oscar.sendMsg("/raw", ~raw);
		oscar.sendMsg("/mas", ~mas);
		oscar.sendMsg("/expMa", ~expMa);
		oscar.sendMsg("/mal", ~mal);

	});
	data_sel.value(~expMa, which_data);



		//lowPassFreq = MouseX.kr(100, 8000);lowPassQ = MouseX.kr(2, 1);



	time = Main.elapsedTime.asInt;
	if(~expMa > touch_thres && (now < time) && triggered == 0,
		{

			if(debug ==2,
				{
					("~raw: "++~raw).postln;
					("~mas: "++~mas).postln;
					("~expMa: "++~expMa).postln;
					("~mal: "++~mal).postln;

	});

			data_touch.value(~expMa, which_data);
				if(oscar_there > 0, {
			oscar.sendMsg("/touch", 1);
			});

			//~fw.set(\amp2, 0);

			triggered = 1;
	});
	if(~expMa < touch_thres, {
		triggered = 0;
			if(oscar_there > 0, {
					oscar.sendMsg("/touch", 0);
		});

//		~fw.set(\amp2, 1);

	});

	//x.set(\amp, ~val.linlin(0, 0.2, 0, 1));
		//x.set(\cutoffFreq, ~val.linlin(0.2, 0.7, 1000, 10000));
	//~val = LPF.kr(e);
	}, "/closer/sender1/channe2",
nil,
	9677);

)
(
	c = SWPlotterMonitor.new( {
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
c.stop
m.stop
m.free
m.start