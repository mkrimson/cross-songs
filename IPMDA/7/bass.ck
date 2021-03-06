// bass.ck
<<< "IPMDA Assignment 7 - Cross Song 7: Bass" >>>;

/* ******************************** */
/* SOUND CHAIN, NOTES AND DURATIONS */
/* ******************************** */

//bass sound is made with 2 TriOsc and a set of filters
TriOsc osc[2];
ADSR env => Gain o => LPF f => Pan2 pan => MasterPan.pan;

[46, 48, 49, 51, 53, 54, 56, 58] @=> int scale[];

//notes that will be played
[5,5,5,5,2,
 5,5,5,5,2,
 5,5,5,5,2,
 3,3,5,5,1,1,7,7
] @=> int walk[];

//duration of individual notes
[BPM.quarterNote, BPM.quarterNote, BPM.quarterNote, 
 BPM.eighthNote, BPM.eighthNote,
 BPM.quarterNote, BPM.quarterNote, BPM.quarterNote, 
 BPM.eighthNote, BPM.eighthNote,
 BPM.quarterNote, BPM.quarterNote, BPM.quarterNote, 
 BPM.eighthNote, BPM.eighthNote,
 BPM.eighthNote, BPM.eighthNote, BPM.eighthNote, BPM.eighthNote,
 BPM.eighthNote, BPM.eighthNote, BPM.eighthNote, BPM.eighthNote
 ] @=> dur times[];


/* ************ */
/* MAIN SECTION */
/* ************ */
init();

0=>int i;
while(true){
    //set note to be played
    play(scale[walk[i%walk.cap()]]-24);
    
    //set timing
    times[i%times.cap()] => now;
    
    //increment index
    1+=>i;
}

/* ********* */
/* FUNCTIONS */
/* ********* */

fun void init() {
    0.3=>pan.pan;

    // set envelope 
    (0.05::second, 0.7::second, 0.2, 0.0001::second) => env.set;

    0.7 => o.gain;
    1200  => f.freq;
    5 => f.Q;

    for ( 0 => int i; i < osc.cap(); i++ ){
        osc[i] => env;
        1.2 / osc.cap() / (i+1) => osc[i].gain; 
    }
}

// bass function 
fun void play (int note)
{
    Std.mtof(note) => osc[0].freq;
    Std.mtof(note + 12) => osc[1].freq;
    1 => env.keyOn;
}