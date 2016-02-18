b.sendMsg("/start", 1);
b.sendMsg("/stop", 1);


(

var w, amp, freq, csAmp, csFreq;
b = NetAddr("127.0.0.1", 57120);
b.sendMsg("/start", 1);
w=FlowView.new(windowTitle:"Send OSC", bounds:Rect(400,500,400, 500));
csAmp=EZSlider(w, label:"volume ", controlSpec:[0.0, 1.0, \lin, 0.01], action:{|mv| b.sendMsg("/volume", 0,0, mv.value);}, initVal:0);
csFreq=EZSlider(w, label:"freq ", controlSpec:[60, 6000, \lin, 1], action:{|mv| b.sendMsg("/freq", 0,0, mv.value);}, initVal:60);




csFreq=EZSlider(w, label:"activityNormal1 ", controlSpec:[0, 1, \lin, 0.01, 0], action:{|mv| b.sendMsg("/activityNormal1", mv.value);}, initVal:0);
csFreq=EZSlider(w, label:"activityNormal2 ", controlSpec:[0, 1, \lin, 0.01, 0], action:{|mv| b.sendMsg("/activityNormal2", mv.value);}, initVal:0);
csFreq=EZSlider(w, label:"Volume ", controlSpec:[0, 1, \lin, 0.01, 0.5], action:{|mv| b.sendMsg("/volume", mv.value);}, initVal:0.5);

csFreq=EZSlider(w, label:"height ", controlSpec:[0, 1, \lin, 0.01, 0.7], action:{|mv| b.sendMsg("/height1", mv.value);}, initVal:0.7);
csFreq=EZSlider(w, label:"width ", controlSpec:[0, 1, \lin, 0.01, 0.4], action:{|mv| b.sendMsg("/width1", mv.value);}, initVal:0.4);
csFreq=EZSlider(w, label:"position ", controlSpec:[0, 1, \lin, 0.01, 0.5], action:{|mv| b.sendMsg("/centerX1", mv.value);}, initVal:0.5);



csFreq = Button(w, Rect(90, 20, 200, 30))
        .states_([
            ["play", Color.black, Color.green],
            ["stop", Color.black, Color.red]
        ])
        .action_({ arg butt;
	x = case
	{ butt.value == 0} { b.sendMsg("/stop", 1); }
	{ butt.value == 1} { b.sendMsg("/play", 1); };

            butt.value.postln;
        });
w.front;
i = EZListView.new(w,
    200@130,
    "Sample1:",
    [
        "szene 0" ->{ |a| b.sendMsg("/szene", 0); },
        "szene 1" ->{ |a| b.sendMsg("/szene", 1); },
        "szene 2" ->{ |a| b.sendMsg("/szene", 2); },
    ],
   // globalAction: { |a| ("this is a global action of "++a.asString ).postln },
    initVal: 2,
    initAction: true,
    labelWidth: 30,
    labelHeight: 16,
    layout: \vert,
    gap: 2@2
    );



)

