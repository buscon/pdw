(
~rvb[10] = \filter -> { |in, revTime= 3, amt = 1| AdCVerb.ar(in, revTime) * amt };
~rvb.play;
~rvb2[10] = \filter -> { |in, roomsize =100, revtime = 3, amt = 0.8| GVerb.ar(in, roomsize, revtime) * amt };
~rvb2.play;
)