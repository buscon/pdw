/*
~gran1.set(\pan, 0, \amtRnd, 0.01);
~gran1.set(\pos, ~samples_data[0][8].choose);
~gran1.set(\pv_amt, 0, \stretch_bins, 4.5);
0.2*2500
1.5*
ratef.linlin(0.2, 1.5, 5000, 500);
FreqScope.new
[-1/32,-1/16,-1/8,-1/4,-1/2,1/32,1/16,1/8,1/4,1/2]
[-1/32,-1/16,-1/8,-1/4,-1/2,1/32,1/16,1/8,1/4,1/2].choose, \dur, rrand(0.1,5.0), \bufnum, ~b[~sample_id].bufnum, \speed, [-1/32,-1/16,-1/8,-1/4,-1/2,1/32,1/16,1/8,1/4,1/2] ]);
~b[~sample_id]
~sample_id
var ratef; ratef = rrand(0.5, 1.5); Synth(\granS, [\bufNum, ~b[~sample_id].bufnum, \volume, rrand(1.5, 2.5), \rate, ratef.postln, \dur, rrand(0.2, 0.5), \pan, -1, \pos, ~samples_data[~sample_id][8].choose.postln, \cutoff, 3000]);

~gran1 = Synth(\gran);
~gran1.set(\volume, 0.8);
~gran1.set(\bufNum, 16, \pos, 0.95, \trigRate1, 1, \dur, 0.3);
*/

(
~path="/Users/marcello/Music/Samples/metabody_tolouse/*.wav";
~path.pathMatch;
~b = ~path.pathMatch.collect { |i| Buffer.readChannel(s, i, channels:[0])};
// array of data about the samples
// 0 id of the sample, 1 pitch of the grain (0-1), 2 max vol1, 3 max vol2, 4 max vol3, 5 trigRate1, 6 trigRate2, 7 amtRand max, 8 list of good positions
~samples_data = [
	[0, 0.5, 0.5, 2, 2, 10, 5, 0.2, [0.03, 0.18,  0.367,  0.46, 0.51,  0.79, 0.86] ],//
	[1, 0.5, 0.5, 2, 2, 10, 5, 0.2, [0.01, 0.02, 0.04,  0.18, 0.19] ],
	[2, 0.5, 1, 2.5, 2.5, 10, 5, 0.2, [0.03, 0.08, 0.11,0.13,0.18, 0.26, 0.29, 0.36, 0.361, 0.363, 0.367, 0.38, 0.46, 0.51, 0.52, 0.55, 0.65, 0.68, 0.79, 0.86, 0.88, 0.9, 0.94, 0.95, 1]],
	[3, 0.5, 0.7, 1.5, 2.5, 10, 5, 0.2, [0, 0.01, 0.1, 0.13,0.17,  0.19, 0.29, 0.37, 0.6]],
	[4, 0.5, 0.5, 2, 2, 10, 5, 0.2, [0, 0.1, 1]],
	[5, 0.5, 0.5, 2, 2, 10, 5, 0.2, [0, 0.4, 0.6]],
	[6, 0.5, 1, 3, 3, 10, 5, 0.2, [0.05, 0.1, 0.3, 0.4, 0.7]]
];

~gran1 = Synth(\gran);
~gran2 = Synth(\gran);









)
/*
(
		~sample_id = 2;
~gran1 = Synth(\gran, [\list_of_pos, ~samples_data[~sample_id][8]]);
)
(
var aS, pS, stS;
		~sample_id = 0;

~gran1.set(\bufNum, ~b[~sample_id].bufnum);

aS = ~samples_data[~sample_id][8];	// array of the pitches of the timpani
//aS = [50,70,90,Prand(aS),120,100, 150];
pS = Pseq(aS, inf);				// make the Pattern
~stS = pS.asStream;
)
~gran1.set(\pos, ~stS.next.postln);
)
~gran1.set(\master_vol, 1);
~gran1.set(\pos, ~samples_data[1][8].choose.postln);
		~gran1.set(\bufNum, ~b[~sample_id].bufnum, \amtRnd, 0, \amFreq, 1000, \master_vol, 2, \dur, 0.25, \pos, 1.0.rand, \volume,1);

*/