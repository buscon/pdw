(
s.waitForBoot{
	("/Users/marcello/Music/Supercollider/pdw/main/synths_noreverb.scd").load;
("/Users/marcello/Music/Supercollider/pdw/main/ndefs_noreverb.scd").load;
("/Users/marcello/Music/Supercollider/pdw/main/reverb.scd").load;
	};
)
("/Users/marcello/Music/Supercollider/pdw/minibees/zeroVol.scd").load;

("/Users/marcello/Music/Supercollider/miniBee/ssdn_python/pydon/scripts/pydoncli.py -c /Users/marcello/Music/Supercollider/miniBee/ssdn_python/pydon/4minibees_new.xml").runInTerminal;
(
("/Users/marcello/Music/Supercollider/pdw/main/minibees_data.scd").load;
("/Users/marcello/Music/Supercollider/pdw/main/plot_minibee.scd").load;

("/Users/marcello/Music/Supercollider/pdw/main/controlPatch.scd").load;
("/Users/marcello/Music/Supercollider/pdw/main/controlScenes_new.scd").load;
s.meter
)


~fw.set(\scale_val,  [0.30238105197449, 0.42763138470637, 0.5339359416674, 0.71271897451062].choose.postln)

~fw.set(\scale_val, (Scale.bartok.ratios.choose * 0.8 * [0.95891652919953, 1.140350359217, 1.4254379490212, 2.0158736798299].choose).postln)

~drC.set(\freq_scale, (Scale.bartok.ratios.choose * 0.7 * 1.3).postln);
~drC.set(\freq_scale, [0.7857234338162, 0.8819447349256, 0.93438789791794, 1.1111807363757].choose.postln);
~drC.set(\freq_scale, [1.3334168836508, 1.4445349572884,  1.573222430718, 1.8708873080904].choose.postln);

~pad.set(\scale_freq, 0.5);
~pad.set(\scale_freq, 0.7857234338162);
~pad.set(\scale_freq, 1.1111807363757);
~pad.set(\scale_freq, 1.2472582053936);

~pad.set(\scale_freq, (Scale.bartok.ratios.choose * 1.5).postln);


~stranga.set(\pitch, (Scale.bartok.ratios.choose * 0.4).postln);
~stranga.set(\pitch, 0.5993228307497); // tief
~stranga.set(\pitch, 0.67347722898531); // mitte
~stranga.set(\pitch, 0.84534797668457); // hoch
~stranga.set(\pitch, 1.048814953812); // sehr hoch