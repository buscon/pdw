// todo

/*
- couple of sounds:
- \trigDrones with Oscar organic pdw1.wav
*/
("/Users/marcello/Music/Supercollider/PdW/beat/irregular_beat.scd").load;
("/Users/marcello/Music/Supercollider/PdW/beat/irregular_beat.scd").openTextFile;

("/Users/marcello/Music/Supercollider/PdW/drones/triggering_drones_minibees.scd").load;
("/Users/marcello/Music/Supercollider/PdW/granular/granulator.scd").openTextFile;
("/Users/marcello/Music/Supercollider/PdW/strings/3.scd").load;
Ndef(\ibeat).stop
Ndef(\ibeat).set(\volume, 0);
(
var speedx1, speedy1, speedz1, speedx2, speedy2, speedz2, xyz1, xyz2, speedAll1, speedAll2,  longval1, longval2,  long, changePos = 0, oscar, stlen= 5, ltlen = 50, debug = 1, oscar_there = 1, val = 0, data_sel, hyper_data_sel, which_data = 0,
sensitive = 0,
setup = 2, // setup
x1, y1, z1, x2, y2, z2;

data_sel = { arg val, which;
	var res;
	res = case
		{ which == 0} {

	}
	{ which == 1} {
		Ndef(\ibeat).set(\volume, 0);//~val1.linlin(0, 0.02, 0, 0.5));
		Ndef(\ibeat).set(\speed, ((~val1 + ~val1 + longval1)/3).linlin(0, 1, 0, 4));
		Ndef(\ibeat).set(\which, ~val1.linlin(0.2, 0.6, 0, 1));
		Ndef(\ibeat).set(\pitch, ~val1.linlin(0.4, 0.8, 0, 1));
		Ndef(\ibeat).set(\pitchDispertion, ~val1.linlin(0.5, 0.8, 0, 0.2));
		Ndef(\ibeat).set(\timeDispertion, ~val1.linlin(0.6, 1, 0, 0.2));
	}
	{ which == 2 } {
		Ndef(\trigDrones).play;
		Ndef(\trigDrones).set(\volume, ~val1.linlin(0, 0.2, 0, 1.2));
		Ndef(\trigDrones).set(\volume2, ~val1.linlin(0.3, 1, 1, 3));
		Ndef(\trigDrones).set(\speed, (~val1.linlin(0.15, 1, 0, 35) ));
		Ndef(\trigDrones).set(\rate, (~val1.linlin(0.9, 0.95, 1, 1.25) ));
		Ndef(\trigDrones).set(\lpfFreq, (val.linlin(0.2, 0.8, 3000, 8000) ));

		Ndef(\trigDrones).set(\sensitive, (~val1.linlin(0.02, 0.04, 0, 1) ));
	}
	{ which == 3 } {
		//granulator
		//~gran1.set( \frate, ~val1.linlin(0.7, 1.0, 1, 1.5));
		//~gran1.set( \dur, ~val1.linlin(0.8, 1.0, 0.2, 2));
		//~gran1 = Synth(\gran);

		~sample_id = 1;

		~gran1.set(\bufNum, ~b[~sample_id].bufnum, \amtRnd, 0, \amFreq, 1000, \master_vol, 2, \dur, 0.25, \pos, 1.0.rand, \volume,1);
		//~gran2.set(\bufNum, ~b[1].bufnum, \amVol, 0, \amFreq, 1000, \master_vol, 0.5, \dur, 0.25, \pos, 1.0.rand, \volume,1);


		~gran1.set(\bufNum, ~b[~sample_id].bufnum);


		~gran1.set( \volume, ~val1.linlin(0, 0.0001 , 0, ~samples_data[~sample_id][2]));
		~gran1.set( \volume2, ~val1.linlin(0.0001, 0.7, 1, ~samples_data[~sample_id][3]));
		~gran1.set( \volume3, ~val1.linlin(0.7, 1, 1, ~samples_data[~sample_id][4]));

		~gran1.set( \trigRate1, ~val1.linexp(0.01, 0.5, 2, ~samples_data[~sample_id][5])); // mean or val?
		~gran1.set( \trigRate2, ~val1.linlin(0.5, 1, 0, ~samples_data[~sample_id][6]));

		~gran1.set( \amtRnd, ~val1.linlin(0.5, 1, 0.001, ~samples_data[~sample_id][7]));
	}
	{ which == 4 } {
			// strings


		~string.set( \volume, val.linlin(0, 0.0001 , 0, 0.3));
		~string.set( \volume2, val.linlin(0.4, 1 , 1, 2));

		~string.set( \sustain, val.linlin(0, 1 , 5, 0.1));
		~string.set( \freq, val.linexp(0.5, 1, 211, 250));
		~string.set( \lpfF, val.linexp(0.3, 1, 1000, 6000));

			//"dev: ".post;
		~string.set(\freq_dev, (val.linlin(0.4, 0.8, 0.1, 10) ));
		~string.set(\sdecay, (val.linexp(0.5, 1, 1, 0.1) ));
		~string.set( \freq2, val.linexp(0.8, 1, 0, 50));
		~string.set( \mx, val.linlin(0, 0.8, 0, 20));



		//if(~val1 > 0.03, {val = 1}, {val = 1}); ~string.set(\sensitive, val.postln);
		if((sensitive == 0) && (~val1 > 0.04), {   Synth(\stringS, [\freq2, 50.0.rand.postln, \freq_dev, 5.0.rand.postln]);sensitive = 1;});
		if((~val1 < 0.04), { sensitive = 0; });
		//sensitive.postln;
		//~string.set(\sensitive, ~val1.linlin(0.02, 0.04, 0, 1 ));
	}

		{ which == 5 } {
			Ndef(\complexB).set(\volume, ~val1.linlin(0, 0.1, 0, 0.5));

			Ndef(\complexB).set(\volume2, ~val1.linlin(0.5, 1, 1, 2));
			Ndef(\complexB).set(\lpfFreq, ~val1.linexp(0.1, 0.6, 50, 20000));

			Ndef(\complexB).set(\hpfFreq, ~val1.linlin(0.7, 1, 10, 7000));



			Ndef(\complexB).set(\speed, ~val1.linlin(0, 0.2, 2, 1.5));

			Ndef(\complexB).set(\speed2, ~val1.linlin(0.7, 0.9, 0, -1.45));


};
	res;

};

hyper_data_sel = { arg val, which;
	var res;
	/*
	Ndef(\ibeat).stop;
	Ndef(\trigDrones).stop;
	~gran1.free;
	~string.stop;
*/
	res = case
		{ which == 0} {

	}
	{ which == 1} {
		Synth(\ibeat, [\scale_freq, exprand(0.2, 1),\which, 0.5, \pitchRatio, 1.0.rand, \pitchDispertion, 3.0.rand, \timeDispertion, 3.0.rand, \volume, 1]);

		//Synth(\kick, [\volume, 0.25]); Synth(\snare, [\volume, 0.01]);
	}
	{ which == 2} {
		Ndef(\trigDrones).set(\select, 1.0.rand );
		"octave: ".post;Ndef(\trigDrones).set(\octave, ([1, (5/4), 3/2].wchoose([0.4,0.3,0.3]) * [1, 1/4, 1/6, 1/8, 1.5, 2].wchoose([0.1, 0.2, 0.2, 0.2, 0.15, 0.15]) * 0.45) );
	}
		{ which == 3} {
		"pos: ".post;~gran1.set( \pos, ~samples_data[~sample_id][8].choose.postln);
		~gran1.set( \rate, rrand(0.5, 1.2));
	}

		{ which == 4} {

	};

				"lastpeak: ".post;~lastPeak1[0].postln;
				~now = (~t.asInt)+0.1;
				"now: ".post;~now.postcs;
				"time: ".post;~t.postcs;
		res;

};


oscar = NetAddr("192.168.1.7", 8000);

speedx1 = SensorData.new;
speedy1 = SensorData.new;
speedz1 = SensorData.new;
speedAll1 = SensorData.new;
speedAll2 = SensorData.new;

speedx2 = SensorData.new;
speedy2 = SensorData.new;
speedz2 = SensorData.new;


//speed3 = SensorData.new;

speedx2.stlen_( stlen );
speedy2.stlen_( stlen );
speedz2.stlen_( stlen );
speedx2.ltlen_( ltlen );
speedy2.ltlen_( ltlen  );
speedz2.ltlen_( ltlen  );

speedx1.stlen_( stlen );
speedy1.stlen_( stlen );
speedz1.stlen_( stlen );
speedx1.ltlen_( ltlen   );
speedy1.ltlen_( ltlen  );
speedz1.ltlen_( ltlen  );
~t = Main.elapsedTime.asInt;
~now = (~t.asInt)-0.1;

OSCdef( \minibeeRouter, { |msg|
	var absValue, absValue2;

	//("full messages" + msg).postln;

	if ( msg[1] == 1,{

		x1 = msg[2];
		y1 = msg[3];
		z1 = msg[4];
// +pow(z,2)

		speedx1.addValue( x1 );
		speedy1.addValue( y1 );
		speedz1.addValue( z1 );


//speed.lastPeak.postln;
		//speed.data.plot;
		///speed.mean.postln;
		xyz1 = (pow(x1,2)+pow(y1,2)).sqrt;
~xyz1 = xyz1;
		speedAll1.addValue( xyz1 );
		~val1 = speedAll1.shortStdDev.explin(0.0003, 0.2, 0, 1);
		~lastPeak1 = speedAll1.lastPeak;
		longval1 = speedAll1.longStdDev.linlin(0.001, 0.1, 0.0, 1);
	if(debug ==1, {
	("~val1: "++~val1).postln
	("~lastPeak1: "++~lastPeak1).postln;
	("longval1: "++longval1).postln;

	});

		if(oscar_there > 0, {
		oscar.sendMsg("/x1", speedx1.shortStdDev);
		oscar.sendMsg("/y1", speedy1.shortStdDev);
		oscar.sendMsg("/z1", speedz1.shortStdDev);
		oscar.sendMsg("/xyz1", ~val1);

		oscar.sendMsg("/lastPeakx1", speedx1.lastPeak[0]);
		oscar.sendMsg("/lastPeaky1", speedy1.lastPeak[0]);
		oscar.sendMsg("/lastPeakz1", speedz1.lastPeak[0];);
		});

		data_sel.value(~val1, which_data );
/*

		~t = Main.elapsedTime.asInt;

//		if( (~lastPeak1[0] > 0.95) && (~now < ~t),
		if( (~val1 > 0.75) && (~now < ~t),

			{

		hyper_data_sel.value(~val, which_data );


		} );

*/
	});

		if ( msg[1] == 2 ,{
		x2 = msg[2];
		y2 = msg[3];
		z2 = msg[4];

		speedx2.addValue( x2 );
		speedy2.addValue( y2 );
		speedz2.addValue( z2 );


//speed.lastPeak.postln;
		//speed.data.plot;
		///speed.mean.postln;
		xyz2 = (pow(x2,2)+pow(y2,2)).sqrt;

		speedAll2.addValue( xyz2 );
		~val2 = speedAll2.shortStdDev.explin(0.00037, 0.2, 0.00000001, 1);
		longval2 = speedAll2.longStdDev.linlin(0.001, 0.1, 0.0, 1);

					if(oscar_there > 0, {
		oscar.sendMsg("/x2", speedx2.shortStdDev);
		oscar.sendMsg("/y2", speedy2.shortStdDev);
		oscar.sendMsg("/z2", speedz2.shortStdDev);
		oscar.sendMsg("/xyz2", ~val2);

		oscar.sendMsg("/lastPeakx2", speedx2.lastPeak[0]);
		oscar.sendMsg("/lastPeaky2", speedy2.lastPeak[0]);
		oscar.sendMsg("/lastPeakz2", speedz2.lastPeak[0];);
		});


		// triggering drones;
		/*
		Ndef(\trigDrones).set(\speed, val2);
		Ndef(\trigDrones).set(\decaytime, val2.linlin(0,1, 0.8, 0.8));
		*/

	});


}, "/minibee/data" );


)
~val2
e
(
	m = SWPlotterMonitor.new( {
    //data to plot
    [
    [ ~val1], // view the two streams superimposed
//    [e, f], // view the two streams superimposed

    //[~e - ~f], // view their differene
    //[(~e- ~f).sign] // view sign of difference
    ]},
    200, //nr of points to plot
    1, // channels
    0.25, // plot dtime
    1 // write every n data points
    ).start;
)
m.stop
Scale.rast.ratios
pentatonic.ratios
1.0.bilinrand
1.0.gauss
		"pos: ".post;~gran1.set( \pos, ~samples_data[~sample_id][8].choose.postln);
		~gran1.set( \rate, rrand(0.2, 0.8).postln);
		~gran1.set( \rate, rrand(1.4, 1.7).postln);