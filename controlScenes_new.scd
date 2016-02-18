b.sendMsg("/start", 1);
b.sendMsg("/stop", 1);


(

var w, amp, freq, csAmp, csFreq;
b = NetAddr("127.0.0.1", 57120);
b.sendMsg("/start", 1);
w=FlowView.new(windowTitle:"Send OSC", bounds:Rect(400,500,400, 500));









i = EZListView.new(w,
    300@130,
    "Sample1:",
    [
        "szene 0" ->{ |a| b.sendMsg("/szene", 0); },
        "szene 1" ->{ |a| b.sendMsg("/szene", 1); },
        "szene 2" ->{ |a| b.sendMsg("/szene", 2); },
        "szene 3" ->{ |a| b.sendMsg("/szene", 3); },
        "szene 4" ->{ |a| b.sendMsg("/szene", 4); },
        "szene 5" ->{ |a| b.sendMsg("/szene", 5); },
        "szene 6" ->{ |a| b.sendMsg("/szene", 6); },
        "szene 7" ->{ |a| b.sendMsg("/szene", 7); },
        "szene 8" ->{ |a| b.sendMsg("/szene", 8); },
        "szene 9" ->{ |a| b.sendMsg("/szene", 9); },

    ],
   // globalAction: { |a| ("this is a global action of "++a.asString ).postln },
    initVal: 2,
    initAction: true,
    labelWidth: 30,
    labelHeight: 16,
    layout: \vert,
    gap: 2@2
    );


w.front;

)

