(
	m = SWPlotterMonitor.new( {
    //data to plot
    [
    [ ~val1, ~val2, ~val3, ~val4], // view the two streams superimposed

 //   [ ~val3, ~val4, ~medVal1, ~expVal1], // view the two streams superimposed
//    [e, f], // view the two streams superimposed

    //[~e - ~f], // view their differene
    //[(~e- ~f).sign] // view sign of difference
    ]},
    200, //nr of points to plot
    4, // channels
    0.25, // plot dtime
    1 // write every n data points
    ).start;
)