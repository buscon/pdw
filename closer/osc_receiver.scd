(
var e = 0, f = 0;

OSCdef( \amount1, { |msg|
	msg.postln;
	e = msg[1];
	}, "/closer/sender1/channel2",
nil,
	9677);

OSCdef( \amount2, { |msg|
	msg.postln;
	f = msg[1];

	}, "/closer/sender2/channel1",
nil,
	9675);

m = SWPlotterMonitor.new( {
    //data to plot
    [
    [e, f], // view the two streams superimposed
    //[~e - ~f], // view their differene
    //[(~e- ~f).sign] // view sign of difference
    ]},
    200, //nr of points to plot
    2, // channels
    0.25, // plot dtime
    1 // write every n data points
   ).start;


)