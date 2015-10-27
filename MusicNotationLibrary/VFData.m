//
//  VFData.m
//  VexFlow
//
//  Created by Scott on 3/21/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFData.h"

@implementation VFData

@end


//http://www.angelfire.com/in2/yala/index.htm

/*
 Frequency
 
 Let's imagine you have a long hollow tube. If you hit it, you get a fairly constant sound because hitting it produces a shock-wave which oscillates (travels up and down) the tube. This oscillation or vibration is what we hear as pitch.
 The speed of oscillation or vibration is called @"Frequency". Frequency is measured in Hertz (Hz), which is oscillations per second. If the hollow tube vibrates at 200 cycles per second, the frequency is 200 Hz.
 
 When you hit a hollow tube, the shock-wave is actually travelling at a constant speed. What determines the frequency is the length of the hollow tube. The longer the tube, the further the shock-wave has to travel, hence, the lower the frequency... and vice versa.
 
 
 Notes and Octaves
 
 A @"Note" is a given name to describe a musical frequency. It describes the pitch of a piano key or guitar string. By convention, notes are named as :-
 A  , A# , B  , C  , C# , D  , D# , E  , F  , F# , G  , G#.
 
 */

/*
 The suffix @"#" denotes sharp and @"b" denotes flat.
 Also note that A# = Bb, C# = Db, D# = Eb, F# = Gb and G# = Ab.
 The names chosen are the de facto standard for nearly all music.
 "Octaves" of a note are just multiples of the original frequency. Let's say that a length of hollow tube has a frequency of 264 Hz and we'll call it @"C".
 If the length is half of the original length, the frequency will be double. This creates another @"C" but one octave higher than the first (264 x 2 = 528 Hz).
 If the length is quarter of the original, the frequency will be quadruple. This creates yet another @"C" but two octaves higher than the original (264 x 4 = 1,056 Hz).
 If the length is double, the frequency is halved. This creates @"C" again but one octave lower than the original (264 / 2 = 132 Hz).
 We can summarise the relationship between octaves and frequency as follows:
 Tube Length   Note   Octave        Frequency
 Original      C      Original   264 Hz  =   264 Hz
 Half          C      Up 1       264 x 2 =   528 Hz
 Quarter       C      Up 2       264 x 4 = 1,056 Hz
 Double        C      Down 1     264 / 2 =   132 Hz
 For simplicity, let's call 132 Hz = @"C1", 264 Hz = @"C2", 528 Hz = @"C3" and 1,056 Hz = @"C4". By convention, the first note in a numbered octave is @"A" (ie G#3 is followed by A4).
 */

/*
 Tuning Notes
 
 Let's look at the hollow tube length again. Halving it gives us an octave higher. What happens for lengths in between? Well, for lengths in between, we get the notes in between.
 If we use fractions where the numerator and denominator are whole numbers, we are creating the @"just intonation" sysem of tuning. The fractions are listed in the table below and are referenced to @"C".
 
 Tube Length      Frequency           Note
 Original    264 x 1      = 264 Hz    C3
 3 / 4       264 x 4 / 3  = 352 Hz    F3
 2 / 3       264 x 3 / 2  = 396 Hz    G3
 3 / 5       264 x 5 / 3  = 440 Hz    A4
 4 / 5       264 x 5 / 4  = 330 Hz    E3
 For most cultures, the @"just intonation" tuning has been in use for thousands of years. This makes sense because we are using multiples of the original length (and then normalising them to the octave) to create notes.
 The just-intonation tuning system works fine and sounds beautiful. However, it has only one drawback... you cannot transpose a song (ie you can only play songs in any key but @"C"). When you play in another key (eg @"D"), the tuning sounds wrong.
 
 The @"equal-tempered" tuning was developed to overcome this problem.
 
 */

/*
 Equal-Tempered Tuning
 
 How does it work? Well, if you think about it, tuning is not linear. You can double the frequency to get the next octave up but you have to quadruple it to get the next octave after that. Consequently, the notes within a scale are not equally distributed in frequency (nor in length).
 This is how it's worked out! @"A4" (the note @"A" at the fourth octave) is deemed to be at 440 Hz and, therefore, @"A5" will be at 880 Hz. We then take logarithms of A4 and A5 frequencies. Next, we mark in 11 equally spaced points between log(A4) and log(A5). On the logarithmic scale, this is the same as having 12 equally spaced notes per octave. We then apply arc-logarithms to those points and arrive the equal-tempered tuning.
 
 Calculation for Equal-Tempered tuning [A4 = 440Hz]
 Hertz      Octave=1    Octave=2    Octave=3    Octave=4    Octave=5     Octave=6
 
 0     A     55.000     110.000     220.000     440.000     880.000    1,760.000
 1   A#/Bb   58.270     116.541     233.082     466.164     932.328    1,864.655
 2     B     61.735     123.471     246.942     493.883     987.767    1,975.533
 3     C     65.406     130.813     261.626     523.251   1,046.502    2,093.005
 4   C#/Db   69.296     138.591     277.183     554.365   1,108.731    2,217.461
 5     D     73.416     146.832     293.665     587.330   1,174.659    2,349.318
 6   D#/Eb   77.782     155.563     311.127     622.254   1,244.508    2,489.016
 7     E     82.407     164.814     329.628     659.255   1,318.510    2,637.020
 8     F     87.307     174.614     349.228     698.456   1,396.913    2,793.826
 9   F#/Gb   92.499     184.997     369.994     739.989   1,479.978    2,959.955
 10     G     97.999     195.998     391.995     783.991   1,567.982    3,135.963
 11   G#/Ab  103.826     207.652     415.305     830.609   1,661.219    3,322.438
 12     A    110.000     220.000     440.000     880.000   1,760.000    3,520.000
 Since this tuning is mathematically derived, a song will sound @"correct" when played in a different key.
 Special note - The decision to use A4 = 440 Hz, 12 notes per octave and naming them A to G was due to historical circumstances. Any other combination would also be valid. However, the equal-tempered tuning is now the de facto system.
 */

/*
 Scales
 
 Musicians compose and play songs. In order to ensure that the song is played correctly, we have to determine which notes are valid. A Scale is a series of notes which we define as @"correct" or appropriate for a song. Normally, we only need to define the series within an octave and the same series will be used for all octaves.
 A Scale is usually referenced to a @"root" note (eg C). Typically, we use notes from the @"equal-tempered" tuning comprising 12 notes per octave; C, C#, D, D#, E, F, F#, G, G#, A, A# & B.
 
 For most of us, we will only probably need to know 2 scales: the Major scale; and, the Minor scale. Using a root of @"C", the Major scale comprises C, D, E, F, G, A, B while the Minor scale comprises A, B, C, D, E ,F, G. Both of these scales have 7 notes per octave.
 
 Examples of various Scales (Root = @"C")
 Name                C   Db   D   Eb   E   F   Gb   G   Ab   A   Bb   B   C
 Major               1        2        3   4        5        6        7   1
 Minor (natural)     1        2    3       4        5    6        7       1
 Harmonic Minor      1        2    3       4        5    6            7   1
 Melodic Minor Asc   1        2    3       4        5        6        7   1
 Melodic Minor Desc  1        2    3       4        5    6        7       1
 Enigmatic           1    2            3        4        5        6   7   1
 Chromatic           1    2   3    4   5   6    7   8    9  10   11  12   1
 Diminished          1        2    3       4    5        6   7        8   1
 Whole Tone          1        2        3        4        5        6       1
 Pentatonic Major    1        2        3            4        5            1
 Pentatonic Minor    1             2       3        4             5       1
 3 semitone          1             2            3            4            1
 4 semitone          1                 2                 3                1
 Bluesy R&R*         1             2   3   4        5        6    7       1
 Indian-ish*         1    2        3   4            5    6        7       1
 Note - The Melodic Minor is played differently when ascending (Asc) and descending (Desc).
 * denotes Names conjured by myself to reflect the mood of the Scales.
 For more examples of scales, see the Scales Reference section at the end of this document.
 As you can see, there are many scales and there is nothing to stop you from creating your own. After all, scales are just a series of notes. Different cultures have developed different scales because they find some series of notes more pleasing than others.
 
 */

/*
 Major and Minor Scales
 
 The Major scale and Minor scale share many similarities. For example, the white notes on a piano concur for both @"C Major" as well as @"A minor". More precisely, @"C Major" comprises C, D, E, F, G, A and B whilst @"A Minor" comprises A, B, C, D, E, F and G. The difference is the starting point or root.
 The Major scale will always have semitone jumps of 2 2 1 2 2 2 1 while a Minor scale has semitone jumps of 2 1 2 2 1 2 2. Semitone means the next note so one semitone up from @"C" is @"C#". In any major scale, the 6th note will be the equivalent minor scale. Similarly, in any minor scale, the 3rd note will be the equivalent major scale.
 
 By a process called @"transposition", we can workout the major or minor scale for every key (ie root). Transposition is basically starting from another key but still maintaining the separation of notes by following the same sequence of semitone jumps. In other words, we are shifting the scale to a different starting note. We can calculate the @"Db Major" scale as being Db, Eb, F, Gb, Ab, Bb and C. The concurring minor for the @"Db major" scale will be @"Bb minor".
 
 The Major Scale
 Key    C   C#    D   D#    E    F   F#    G   G#    A   A#    B    C
 C      1         2         3    4         5         6         7    1
 D           7    1         2         3    4         5         6
 E           6         7    1         2         3    4         5
 F      5         6         7    1         2         3    4         5
 G      4         5         6         7    1         2         3    4
 A           3    4         5         6         7    1         2
 B           2         3    4         5         6         7    1
 When we transpose, we are changing key (ie root). The scale is always maintained. I have not included the Major scales for Db, Eb, F#, Ab and Bb but that should be easy for you to work out.
 */

/*
 Major & Minor Transforms
 
 "Transform" is a general term meaning to convert something into another. Here, transform is just a way to convert from one scale to another. It is not the same as transpose. Transpose changes the key but always maintains the scale. A transform can change the key and/or the scale. Transforms are a convenient way to convert a musical sequence into a different scale and/or key.
 This document will concentrate on one-note transforms. If you have a song in C Major, then converting every occurrance of F to F# will transform it into G Major. Similarly, converting every B to A#/Bb will give you F Major.
 
 The table below highlights the one-note transforms for the major scale. These particular transforms only involve Key changes (not scale).
 
 One Note Transforms - Comparisons for the Major Scale
 Key    C   C#    D   D#    E    F   F#    G   G#    A   A#    B    C
 F      5         6         7    1         2         3    4         5
 C      1         2         3    4         5         6         7    1
 G      4         5         6         7    1         2         3    4
 D           7    1         2         3    4         5         6
 A           3    4         5         6         7    1         2
 E           6         7    1         2         3    4         5
 B           2         3    4         5         6         7    1
 A scale can be transformed into the one above it or below it simply by comparing the difference between them. The difference should only be one note.
 When would you use a transform? Let's say you have a nice sequenced pattern running throughout a song. You have to accommodate a big key change but transposing it doesn't sound right. Then try transforming it instead. Transforming only a few notes will not detract too much from the original pattern and can sound more natural.
 
 */

/*
 Modes
 
 Modes are variant-scales developed from the Major scale simply by starting from a different note. Consider the C Major scale [C, D, E, F, G, A, B, C] which has 7 notes: If you start from D with the same 7 notes, you get a new scale [D, E, F, G, A, B, C, D]. Basically, starting the series from any of 7 notes would give you a different scale and these are called @"Modes". Each mode also has a name taken from ancient Greece.
 The table below shows the modal scales for the white notes on a piano.
 
 Modal Scales
 MODES       C    D    E    F    G    A    B    C     Semitone Jumps
 mC    Ionian      1    2    3    4    5    6    7    1     2 2 1 2 2 2 1
 mD    Dorian      7    1    2    3    4    5    6    7     2 1 2 2 2 1 2
 mE    Phrygian    6    7    1    2    3    4    5    6     1 2 2 2 1 2 2
 mF    Lydian      5    6    7    1    2    3    4    5     2 2 2 1 2 2 1
 mG    Mixolydian  4    5    6    7    1    2    3    4     2 2 1 2 2 1 2
 mA    Aeolian     3    4    5    6    7    1    2    3     2 1 2 2 1 2 2
 mB    Locrian     2    3    4    5    6    7    1    2     1 2 2 1 2 2 2
 Note - this looks is a bit like transposition but is actually completely different.
 In transposition, the series of semitone jumps is the same. In other words, the separation of notes of the scale is maintained (ie the relative differences in frequencies between notes remains).
 In modes, the series of semitone jumps changes. In other words, the separation of notes of the scale is different (ie the relative differences in frequencies between notes is not maintained).
 The table below shows the same modal scales with a @"C" root.
 
 MODES          C  Db   D  Eb   E   F  Gb   G  Ab   A  Bb   B   C
 mC    Ionian      1       2       3   4       5       6       7   8
 mD    Dorian      1       2   3       4       5       6   7       8
 mE    Phrygian    1   2       3       4       5   6       7       8
 mF    Lydian      1       2       3       4   5       6       7   8
 mG    Mixolydian  1       2       3   4       5       6   7       8
 mA    Aeolian     1       2   3       4       5   6       7       8
 mB    Locrian     1   2       3       4   5       6       7       8
 What do they sound like? Well, Ionian mode is the same as the Major scale and Aeolian mode is the same as Minor scale. The rest sound strangely familiar but not quite right. For example, Dorian mode sounds like the band is playing in @"D" but you're doing the melody in @"C" instead.
 */

/*
 Mode Transforms
 
 We can look as the modes in terms of one-note transforms. The table below highlights the one-note transforms for modes. These particular transforms involve scale changes but not key changes.
 If you have a song in C Major (ie Ionian), then converting every occurrance of B to A# (Bb) will give you Mixolydian. Similarly, converting every F to F# will give you Lydian.
 
 One Note Transforms - Comparisons for Modes
 Modes       C  Db   D  Eb   E   F  Gb   G  Ab   A  Bb   B   C
 mF     Lydian      1       2       3       4   5       6       7   1
 mC     Ionian      1       2       3   4       5       6       7   1
 mG     Mixolydian  1       2       3   4       5       6   7       1
 mD     Dorian      1       2   3       4       5       6   7       1
 mA     Aeolian     1       2   3       4       5   6       7       1
 mE     Phrygian    1   2       3       4       5   6       7       1
 mB     Locrian     1   2       3       4    5      6       7       1
 mF^-1  Lydian          2       3       4    5      6       7   1
 The prefix @"m" denotes mode. Therefore @"mF" is Lydian. @"Carets" (^) with plus or minus signs denote transposition up and down respectively and is enumerated in semitones. Therefore @"mF^-1" is Lydian transposed down one semitone.
 A scale can be transformed into the one above it or below it simply by comparing the difference between them. The difference should only be one note.
 
 */

/*
 Pentatonics
 
 A pentatonic is simply a scale of five notes. A series of any five notes per octave will qualify as a pentatonic scale.
 A Major pentatonic in @"C" comprises C, D, E, G and A... which is a common scale used by most cultures in the world. This is achieved by removing the 4th and 7th notes.
 
 What is interesting is that if we remove the 4th and 7th notes from the modal scales, we get quite remarkable results. The table below illustrates the modal pentatonics. This time I'm using the @"black" notes on the piano.
 
 Modal Pentatonics
 Name -from-      F#  G  G#   A   A#  B   C   C#  D   D#  E   F   F#  Semitone Jumps
 pC   Ionian      1       2       3   -       4       5       -   1    2 2 3 2 3
 pD   Dorian      1       2   3       -       4       5   -       1    2 1 4 2 3
 pE   Phrygian    1   2       3       -       4   5       -       1    1 2 4 1 4
 pF   Lydian      1       2       3       -   4       5       -   1    2 2 3 2 3
 pG   Mixolydian  1       2       3   -       4       5   -       1    2 2 3 2 3
 pA   Aeolian     1       2   3       -       4   5       -       1    2 1 4 1 4
 pB   Locrian     1   2       3       -   4       5       -       1    1 2 3 2 4
 What do they sound like (my interpretation)?
 "pF, pC & pG" are exactly the same and as they are all the Major pentatonic. The major pentatonic is the mainstay of most Folk music.
 "pA" is used mainly in Japanese and Balinese music.
 "pE" is a popular scale in music from India (also used in Bali).
 "pB" sounds like a mix of arab and indian music (or somewhere from Asia minor). You'll have to judge this one yourself.
 "pD" sounds very serious indeed. You'll have to judge this one yourself too.
 */

/*
 Modal-Pentatonic Transforms
 
 If we arrange the pentatonics in the same order as the previous one-note transforms, we get the following modal scale transforms:-
 One Note Transforms - Comparisons for Modal Pentatonics
 Notes        E   F  F#   G  G#   A  A#   B   C  C#   D  D#   E
 pF     Folk            1        2       3           4       5
 pC     Folk            1        2       3           4       5
 pG     Folk            1        2       3           4       5
 pD     AsiaMin         1        2   3               4       5
 pA     JapBali         1        2   3               4   5
 pE     Indian          1    2       3               4   5
 pB     Serious         1    2       3           4       5
 pF^-1  Folk         1       2       3           4       5
 A scale can be transformed into the one above it or below it simply by comparing the difference between them. The difference should only be one note.
 In addition to the above transforms, there are a further set of transforms for the modal-pentatonics. The table below is slightly different as it groups the possible transforms by each pentatonic. These particular transforms involve scale changes ans well as key changes.
 More One Note Transforms - Grouped for Modal Pentatonics
 Name        E   F  F#   G  G#   A  A#   B   C  C#   D  D#
 pFCG  Folk              1       2       3           4       5
 pFCG^+7       3           4       5           1       2
 pFCG^+5           4       5           1       2       3
 pB^+1                 1   2       3           4       5
 pD^+7     3               4       5           1       2
 pB^+6             4       5               1   2       3
 pD    AsiaMin           1       2   3               4       5
 pA^+7     3               4   5               1       2
 pFCG^+5           4       5           1       2       3
 pB^+6             4       5               1   2       3
 pA    JapBali           1       2   3               4   5
 pE^+7     3               4   5               1   2
 pD^+5             4       5           1       2   3
 pE    Indian            1   2       3               4   5
 pB^+7     3           4       5               1   2
 pA^+5             4   5               1       2   3
 pB    Serious           1   2       3           4       5
 pD^+6                 4       5           1       2   3
 pFCG^+6   3           4       5           1       2
 pE^+5             4   5               1   2       3
 Well, there you have it... all the posible one-note transforms for the pentatonics. If wish to transform from one pentatonic to another but no direct one-note transform is available, then you will have to do it in two or more steps.
 */

/*
 Example Application of Transforms
 
 Transforms are useful for converting from one scale and/or key to another. Of all the transforms described in this document, the modal pentatonic transforms are the most interesting to apply because the results are quite remarkable.
 If you have a sequencer, try this modal pentatonic experiment:
 
 - Write a short pattern using only the black notes... name it @"pFCG".
 - Using @"pFCG",       convert every @"A#" into @"A"...  name it   @"pD".
 - Using   @"pD",       convert every @"D#" into @"D"...  name it   @"pA".
 - Using   @"pA",       convert every @"G#" into @"G"...  name it   @"pE".
 - Using   @"pE",       convert every @"C#" into @"C"...  name it   @"pB".
 - Using @"pFCG" again, convert every @"F#" into @"E"...  name it @"pD^+7".
 - Using @"pD^+7",      convert every @"C#" into @"B"...  name it @"pA^+2".
 - Using @"pFCG" again, convert every @"F#" into @"G"...  name it @"pB^+1".
 - Using @"pB^+1",      convert every @"A#" into @"C"...  name it @"pE^+6".
 - Then delete @"pFCG".
 You now have 7 pentatonic patterns: 2 AsiaMins, 2 JapBalis, 2 Indians and 1 Serious.
 Arrange the patterns in any order you like... you've now made one seriously ethnic-sounding new tune.
 */

/*
 Scales Reference
 
 Below is a table of Scales. They are arranged into 3 sections: (a) Non 7 or 5 note scales, (b) 7 note scales, and (c) 5 note scales. They are sorted in order of distance from the root-key.
 -------------  NAME  C  -  D  -  E  F  -  G  -  A  -  B  C  ALTERNATIVE
 Chromatic            1  2  3  4  5  6  7  8  9 10 11 12  1
 Spanish 8 Tone       1  2  -  3  4  5  6  -  7  -  8  -  1
 Flamenco             1  2  -  3  4  5  -  6  7  -  8  -  1
 Symmetrical          1  2  -  3  4  -  5  6  -  7  8  -  1  Inverted Diminished
 Diminished           1  -  2  3  -  4  5  -  6  7  -  8  1
 Whole Tone           1  -  2  -  3  -  4  -  5  -  6  -  1
 Augmented            1  -  -  2  3  -  -  4  5  -  -  6  1
 3 semitone           1  -  -  2  -  -  3  -  -  4  -  -  1
 4 semitone           1  -  -  -  2  -  -  -  3  -  -  -  1
 -------------  NAME  C  -  D  -  E  F  -  G  -  A  -  B  C  ALTERNATIVE
 Ultra Locrian        1  2  -  3  4  -  5  -  6  7  -  -  1
 Super Locrian        1  2  -  3  4  -  5  -  6  -  7  -  1  Ravel
 Indian-ish*          1  2  -  3  4  -  -  5  6  -  7  -  1
 Locrian              1  2  -  3  -  4  5  -  6  -  7  -  1
 Phrygian             1  2  -  3  -  4  -  5  6  -  7  -  1
 Neapolitan Minor     1  2  -  3  -  4  -  5  6  -  -  7  1
 Javanese             1  2  -  3  -  4  -  5  -  6  7  -  1
 Neapolitan Major     1  2  -  3  -  4  -  5  -  6  -  7  1
 Todi (Indian)        1  2  -  3  -  -  4  5  6  -  -  7  1
 Persian              1  2  -  -  3  4  5  -  6  -  -  7  1
 Oriental             1  2  -  -  3  4  5  -  -  6  7  -  1
 Maj.Phrygian (Dom)   1  2  -  -  3  4  -  5  6  -  7  -  1  Spanish/ Jewish
 Double Harmonic      1  2  -  -  3  4  -  5  6  -  -  7  1  Gypsy/ Byzantine/ Charhargah
 Marva (Indian)       1  2  -  -  3  -  4  5  -  6  -  7  1
 Enigmatic            1  2  -  -  3  -  4  -  5  -  6  7  1
 -------------  NAME  C  -  D  -  E  F  -  G  -  A  -  B  C  ALTERNATIVE
 Locrian Natural 2nd  1  -  2  3  -  4  5  -  6  -  7  -  1
 Minor (natural)      1  -  2  3  -  4  -  5  6  -  7  -  1  Aeolian/ Algerian (oct2)
 Harmonic Minor       1  -  2  3  -  4  -  5  6  -  -  7  1  Mohammedan
 Dorian               1  -  2  3  -  4  -  5  -  6  7  -  1
 Melodic Minor (Asc)  1  -  2  3  -  4  -  5  -  6  -  7  1  Hawaiian
 Hungarian Gypsy      1  -  2  3  -  -  4  5  6  -  7  -  1
 Hungarian Minor      1  -  2  3  -  -  4  5  6  -  -  7  1  Algerian (oct1)
 Romanian             1  -  2  3  -  -  4  5  -  6  7  -  1
 -------------  NAME  C  -  D  -  E  F  -  G  -  A  -  B  C  ALTERNATIVE
 Maj. Locrian         1  -  2  -  3  4  5  -  6  -  7  -  1  Arabian
 Hindu                1  -  2  -  3  4  -  5  6  -  7  -  1
 Ethiopian 1          1  -  2  -  3  4  -  5  6  -  -  7  1
 Mixolydian           1  -  2  -  3  4  -  5  -  6  7  -  1
 Major                1  -  2  -  3  4  -  5  -  6  -  7  1  Ionian
 Mixolydian Aug.      1  -  2  -  3  4  -  -  5  6  7  -  1
 Harmonic Major       1  -  2  -  3  4  -  -  5  6  -  7  1
 Lydian Min.          1  -  2  -  3  -  4  5  6  -  7  -  1
 Lydian Dominant      1  -  2  -  3  -  4  5  -  6  7  -  1  Overtone
 Lydian               1  -  2  -  3  -  4  5  -  6  -  7  1
 Lydian Aug.          1  -  2  -  3  -  4  -  5  6  7  -  1
 Leading Whole Tone   1  -  2  -  3  -  4  -  5  -  6  7  1
 Bluesy R&R*          1  -  -  2  3  4  -  5  -  6  7  -  1
 Hungarian Major      1  -  -  2  3  -  4  5  -  6  7  -  1  Lydian sharp2nd
 -------------  NAME  C  -  D  -  E  F  -  G  -  A  -  B  C  ALTERNATIVE
 "pB"                 1  2  -  3  -  -  4  -  5  -  -  -  1
 Balinese 1           1  2  -  3  -  -  -  4  5  -  -  -  1  @"pE"
 Pelog (Balinese)     1  2  -  3  -  -  -  4  -  -  5  -  1
 Iwato (Japanese)     1  2  -  -  -  3  4  -  -  -  5  -  1
 Japanese 1           1  2  -  -  -  3  -  4  5  -  -  -  1  Kumoi
 Hirajoshi (Japanese) 1  -  2  3  -  -  -  4  5  -  -  -  1  @"pA"
 "pD"                 1  -  2  3  -  -  -  4  -  5  -  -  1
 Pentatonic Major     1  -  2  -  3  -  -  4  -  5  -  -  1  Chinese 1/ Mongolian/ @"pFCG"
 Egyptian             1  -  2  -  -  3  -  4  -  -  5  -  1
 Pentatonic Minor     1  -  -  2  -  3  -  4  -  -  5  -  1
 Chinese 2            1  -  -  -  2  -  3  4  -  -  -  5  1
 In general, the non-european scales have not been well documented and many of the names selected may not be representative of their music. For example, indian and indonesian music use a huge range of different scales. Arabic music also use quarter-tone tuning (there are notes in between the semitones). Algerian music can use one scale for the first octave and another for the next. Ethopian music can also use the minor, dorian and mixolydian scales. And this is only the tip of the iceberg. Also remember that the above table is only a guide to scales used and the actual tunings used can vary immensely. In the end, the best source for examining scales it to hear it for yourself and translate it.
 */

/*
 Conforming to Classical Notation
 
 You do not have to know how to read classical notation in order to use the information in this section. This information is provided as an additional guide to scales because of the limitations imposed by classical notation. For example, the scale of @"A# major" and @"Bb major" are exactly the same but classical notation only allows for @"Bb major".
 The classical notation system is well suited for instruments which are @"pre-fingered" for the major scale (eg keyboards) but, for @"linear" instruments (eg guitar, violin), it requires more familiarisation.
 
 Classical Notation system:-
 The Range of Notes - is represented by a pair of @"Staffs" (a Staff has 5 horizontal lines) and these are marked by @"Clefs" (ie either treble or bass).
 Note Identification - Every line or space has been preassigned a note @"letter" (ie C, D, E, F, G, A, B). The large space between the Staffs has an imaginary line which represents @"middle C".
 The Duration of Notes - are represented by a set of Note-Symbols (usually containing some form of circular dot).
 The Notes to be played - are the placement of Symbols either on the lines or in the spaces.
 Sharp and Flat Notes - @"#" and @"b" can also be placed next to the Note-Symbols on the Staff.
 Specific Scales - are declared by a @"Key-Signature" (a set of sharps or flats on the relevant line or space) at the beginning of the Staff (eg The scale of G major or E minor is declared by marking @"#" on @"F" locations at the start).
 
 If you are using the scale of C major or A minor (the white notes on a piano), you will not have to pre-mark any sharps or flats as Key Signature. With any other scale, you will need to assign sharps or flats.
 
 With classical notation, problems arises because the Staff represents notes by their @"letter". This means that every note in the scale should have a different letter. For example, the scale of F major is F, G, A, Bb, C, D, E. You should not use A# instead of Bb, otherwise the @"A#" will have to share the same line or space as @"A" (and the @"B" line or space will not be used at all). This will cause problems with the Key-Signature.
 
 The table below gives Major and Minor Scales which conform to classical notation. Note - as you count the notes in the scale, you are also counting @"letters" (ie In E major, the 6th note is @"C#"... so counting 1, 2, 3, 4, 5, 6 is counting E, F, G, A, B, C... and @"C" is letter no.6 from @"E").
 
 MAJOR SCALE   R   -   2   -   3   4   -   5   -   6   -   7
 C  maj.:   C   -   D   -   E   F   -   G   -   A   -   B
 Db maj.:   Db  -   Eb  -   F   Gb  -   Ab  -   Bb  -   C
 D  maj.:   D   -   E   -   F#  G   -   A   -   B   -   C#
 Eb maj.:   Eb  -   F   -   G   Ab  -   Bb  -   C   -   D
 E  maj.:   E   -   F#  -   G#  A   -   B   -   C#  -   D#
 F  maj.:   F   -   G   -   A   Bb  -   C   -   D   -   E
 F# maj.:   F#  -   G#  -   A#  B   -   C#  -   D#  -  (E#)
 G  maj.:   G   -   A   -   B   C   -   D   -   E   -   F#
 Ab maj.:   Ab  -   Bb  -   C   Db  -   Eb  -   F   -   G
 A  maj.:   A   -   B   -   C#  D   -   E   -   F#  -   G#
 Bb maj.:   Bb  -   C   -   D   Eb  -   F   -   G   -   A
 B  maj.:   B   -   C#  -   D#  E   -   F#  -   G#  -   A#
 MINOR SCALE   R   -   2   b3  -   4   -   5   b6  -   b7  -
 A  min.:   A   -   B   C   -   D   -   E   F   -   G   -
 Bb min.:   Bb  -   Cb  Db  -   Eb  -   F   Gb  -   Ab  -
 B  min.:   B   -   C#  D   -   E   -   F#  G   -   A   -
 C  min.:   C   -   D   Eb  -   F   -   G   Ab  -   Bb  -
 C# min.:   C#  -   D#  E   -   F#  -   G#  A   -   B   -
 D  min.:   D   -   E   F   -   G   -   A   Bb  -   C   -
 Eb min.:   Eb  -   F   Gb  -   Ab  -   Bb (Cb) -   Db  -
 E  min.:   E   -   F#  G   -   A   -   B   C   -   D   -
 F  min.:   F   -   G   Ab  -   Bb  -   C   Db  -   Eb  -
 F# min.:   F#  -   G#  A   -   B   -   C#  D   -   E   -
 G  min.:   G   -   A   Bb  -   C   -   D   Eb  -   F   -
 G# min.:   G#  -   A#  B   -   C#  -   D#  E   -   F#  -
 Note - F# major contains @"E#" (which is @"F") and that Eb minor contains @"Cb" (which is @"B"). This is a small discrepancy in the system.
 The table below illustrates the @"letter" problems of using the non-conforming keys. Notes in brackets () indicate small discrepancies. Notes in square brackets [] indicate serious problems.
 
 C# maj.:   C#    D#   (E#)   F#    G#    A#   (B#)
 D# maj.:   D#   (E#)  [F##]  G#    A#   (B#)  [C##]
 Gb maj.:   Gb    Ab    Bb   (Cb)   Db    Eb    F
 G# maj.:   G#    A#   (B#)   C#    D#   (E#)  [F##]
 A# maj.:   A#   (B#)  [C##]  D#   (E#)  [F##] [G##]
 Ab min.:   Ab    Bb   (Cb)   Db    Eb   (Fb)   Gb
 A# min.:   A#   (B#)   C#    D#   (E#)   F#    G#
 Db min.:   Db    Eb   (Fb)   Gb    Ab   [Bbb] (Cb)
 D# min.:   D#   (E#)   F#    G#    A#    B     C#
 Gb min.:   Gb    Ab   [Bbb] (Cb)   Db   [Ebb] (Fb)
 These problems do not exist physically, scientifically or mathematically. The problems arise from the system itself. However, the classical notation system is the de facto @"language" of music. Plus the system is fairly compact and concise. So perhaps this extra @"learning" is not too bad.
 The table below shows the Scales of the Major and Minor Keys which conform to classical notation. This may be easier to visualise and remember.
 
 Major only              Db                       Ab
 both Major & Minor   C      D  Eb  E   F  F#  G      A  Bb  B   C
 Minor only              C#                       G#
 */

//http://www.angelfire.com/in2/yala/4chords1.htm

/*
 This article assumes that you are familiar with a musical instrument whether it be keyboard or guitar or whatever. You are (at the very least) expected to know the positions of notes on your instrument and how to play them. If you are unfamiliar with any instrument whatsoever, I would strongly suggest that you start off with the article entitled @"Scales".
 K E Y B O A R D
 C#		D#				F#		G#		A#				C#		D#				F#		G#		A#
 Db		Eb				Gb		Ab		Bb				Db		Eb				Gb		Ab		Bb
 C		 D		 E		 F		 G		 A		 B		 C		 D		 E		 F		 G		 A		 B		 C
 
 This emphasis of this article is to explain how Chords are structured and, hence, named. In the event that you are new to this, I have provided the keyboard and guitar tables as reference points.
 
 G U I T A R
 E |	F	F#	G	G#	A	Bb	B	C	C#	D	D#	E
 B |	C	C#	D	D#	E	F	F#	G	G#	A	Bb	B
 G |	G#	A	Bb	B	C	C#	D	D#	E	F	F#	G
 D |	D#	E	F	F#	G	G#	A	Bb	B	C	C#	D
 A |	Bb	B	C	C#	D	D#	E	F	F#	G	G#	A
 E |	F	F#	G	G#	A	Bb	B	C	C#	D	D#	E
 0			 3		 5		 7		 9			12
 
 I have included not only Chords for keyboards but also for guitar. Since the topic of Chords is very large indeed, this article is split into 2 parts to avoid any loading problems.
 
 
 Terms & Abbreviations Used
 
 b - means @"flat".
 # - means @"sharp".
 ?b or ?# - where @"b" or @"#" is suffixed, it identifies a note (eg. Bb = B flat,.C# = C sharp).
 b? or #? - where @"b" or @"#" is prefixed, it is a relative note position (eg. b7 = flattened 7th, #5 = sharpened 5th).
 Maj - or @"M" means @"Major".
 min - or @"m" means @"minor".
 R - means @"root". The reference root-note or key.
 dim - means @"diminished".
 aug - means @"augmented".
 sus - means @"suspended".
 add - means @"added".
 [????] - words enclosed by square parentheses means they are sometimes omitted.
 aka - abbreviation for @"also known as".
 
 What is a Chord?
 
 A Chord is a @"set of notes" usually played simultaneously. A Chord describes a whole @"set of notes" and not any individual notes.
 Every Chord has a distinct sound and mood. Chords are the harmony of a song. While we identify @"melody" by the sequence of notes played, we identify @"harmony" by the interaction of the Chords. Chords are the foundations of a song.
 
 We use the word @"Chord" to distinguish it from a @"Scale" (please see document entitled @"Scales"). A @"C Major" chord is completely different from the @"C Major" scale. Whereas a song may be played in a specific Scale, the Chords to a song will change as the song progresses. This is called a chord progression.
 
 
 Chord Root
 
 Every Chord has a Root by which we name the chord. The Root is the base of the Chord or you may think of it as the @"bass" of the chord (The way in which you hear the basis of a chord and the @"bass" is very similar).
 For example, for a song in the scale of C Major, the chord progression could be C Major, A minor, F Major and G Major. In this case, the Roots of the chords are @"C", @"A", @"F" and @"G" (a likely progression for the bass-line too).
 
 
 Intervals
 
 An interval is the @"distance" between notes (in a chord). Let's start off with diads (ie two notes played simultaneously -or- 2 note chord). You can describe the @"distance" in terms of semitones or by its name.
 Let's start off by looking at how the intervals are named (Bear in mind that we are talking about two notes played together). The classical music academics named the intervals by the quality of sound produced. If the sound was smooth and pleasant, it was called consonence: If it was strained and unpleasant, it was called dissonance. From this subjective @"quality assessment", the names were derived.
 
 You will notice that each interval is numbered (ie 2nd, 3rd, 4th, 5th, 6th and 7th). The numbering comes about by @"counting" the @"letters" (eg. C to D is 2, C to E is 3, C to F is 4, C to G is 5, C to A is 6, and, C to B is 7). The numbering disregards whether the note is sharp or flat.
 
 I N T E R V A L S
 Semi-	Key C	 Main	 Major	 Minor	 Extra	 Note
 Tones	 notes	 intervals	 intervals	 intervals	 intervals	 Name
 0	C	Unison				 R
 1	Db/C#			minor 2nd		b2
 2	D		[Maj] 2nd			 2
 3	Eb/D#			minor 3rd		b3
 4	E		[Maj] 3rd			 3
 5	F	[Perfect] 4th				 4
 6	Gb/F#				dim 5 / aug 4	#4 / b5
 7	G	[Perfect] 5th				 5
 8	Ab/G#			minor 6th		b6
 9	A		[Maj] 6th			 6
 10	Bb/A#	[Dominant] 7th				b7
 11	B		Major 7th			 7
 12	C	Octave / 8th				 8
 
 The intervals with the most consonance are Unison (playing the same note twice) and Octave. They only involve the root. Let's look at more!
 
 The main intervals are the Perfect 4th (5 semitones apart), Perfect 5th (7 semitones) and the Dominant 7th (10 semitones). They have special names because they have much consonance.
 
 What's the big deal? Why do they sound pleasant? It's actually because of the relative pitches (frequencies) of the notes. Let's say the Root is @"C", and let's play a diad using @"C" and @"G". The pitch of @"G" = @"C" x 3 / 2 (ie for every 2 oscillations of @"C", there are 3 oscillations of @"G"). When played together, there is a smooth @"ringing" caused by this mathematical relationship which is pleasant. Hence the name @"Perfect" 5th.
 
 Perhaps not surprisingly, the note @"F" = @"C" x 4 / 3 (appx), hence, called the Perfect 4th. Again, the note @"Bb" is approximately @"C" x 7 / 4, and called the Dominant 7th.
 
 Having set the 4th, 5th and 7th, the next best consonence happen to coincide with the Major Scale and hence were named Maj 2nd (C to D), Maj 3rd (C to E), and, Maj 6th (C to A). Note that @"C" to @"B" is actually dissonant but, for completeness, the interval is called the Maj 7th.
 
 Having set the 2nd, 3rd, 4th, 5th, 6th, 7th and Maj 7th, the leftover intervals (which happen to be flat notes) were conveniently named min 2nd (C to Db), min 3rd (C to Eb), and, min 6th (C to Ab). It doesn't help that this has little to do with the minor scale.
 
 The only remaining interval is C to Gb/F# and this is named as the diminished 5th (for C to Gb) or augmented 4th (C to F#). When referring to a Note, the word @"diminished" means @"flattened" and the word @"augmented" means @"sharpened".
 
 It is important to note that it the words @"Perfect", @"Dominant" and @"Major" are usually dropped. If you were to only use the Major scale to name the intervals, you would be mostly correct BUT except for the Major 7th. Hence, you never drop the word @"Major" for the Major 7th.
 
 The last column introduces another method of @"declaring" chords. Here the notes are numbered using the Major scale and all other notes are considered either @"flat" or @"sharp". This system declares the notes involved separated by commas. So a 5th interval would be @"R, 5" and the Dominant 7th interval would be @"R, b7". This system is never ambiguous and extremely accurate because every note is declared (and the rules are fixed). However, these are not really chord @"names" per se.
 
 SideNote - Guitarists like to play a 5th interval plus an octave root (ie root, 5th, octave) and refer to this as the @"power chord". It's actually a 5th chord.
 
 
 Basic Chords
 
 Having looked at the diad (2 note chord) intervals, let us now look at the triads (3 note chords).
 The triad is based on the Root, 3rd and 5th of a scale.
 From the Major Scale, we get the Major triad (R, 3, 5): therefore C Major is made of @"C", @"E" and @"G".
 From the Minor Scale, we get the minor triad (R, b3, 5): therefore C minor is made of @"C", @"Eb" and @"G".
 From the Augmented Scale, we get the augmented [5th] triad (R, 3, #5): therefore C augmented is made of @"C", @"E" and @"G#".
 From the Diminished Scale, we get the diminished 5th triad (R, b3, b5): therefore C diminished 5th is made of @"C", @"Eb" and @"Gb".
 Note - The augmented scale (aka whole tone scale) is a 6 note scale where every note is separated by a whole-tone (ie 2 semitones). The diminished scale is an 8 note scale where the separation alternates between whole-tone and semi-tone.
 In addition there are also @"replacement" to chord notes. These are the suspended 4ths and 2nds. They are suspended because they cannot be classified as Major or minor chords. In a suspended 4th, basically the 4th @"replaces" the 3rd (the same applies to the suspended 2nd).
 
 Key=C	 C	Db	 D	Eb	 E	 F	Gb	 G	Ab	 A	Bb	 B
 -TRIADS-	 Abbrev	 R	b2	 2	b3	 3	 4	b5	 5	b6	 6	b7	 7
 [Major] triad		 R				 3			 5
 minor triad	 min	 R			 b3				 5
 augmented [5th] triad	 aug5	 R				 3				 #5
 diminished 5th triad	 dim5	 R			 b3			 b5
 -REPLACEMENTS-	 Abbrev	 C	Db	 D	Eb	 E	 F	Gb	 G	Ab	 A	Bb	 B
 suspended 4th	 sus4	 R					 4		 5
 suspended 2nd	 sus2	 R		 2					 5
 
 The next set of basic chords are the 7ths. These are 4-note chords made up by adding a 7th (whether diminished, dominant or augmented) to the triad.
 
 At this point, to avoid any confusion, it is important to DROP the word @"Major" from the chord-name when describing a Major triad. You'll see why below.
 
 7th chord is a Major triad with added [dominant] 7th.
 Major 7th chord is a Major triad with added Major 7th.
 minor 7th chord is a minor triad with added [dominant] 7th.
 Key=C	 C	Db	 D	Eb	 E	 F	Gb	 G	Ab	 A	Bb	 B
 -SEVENTHS-	 Abbrev	 R	b2	 2	b3	 3	 4	b5	 5	b6	 6	b7	 7
 [dominant] 7th	 7	 R				 3			 5			 b7
 Maj 7th	 M7	 R				 3			 5				 7
 minor [dominant] 7th	 min7	 R			 b3				 5			 b7
 7th augmented 5th	 7aug5	 R				 3				 #5		 b7
 7th diminished 5th	 7dim5	 R				 3		 b5				 b7
 half diminished 7th	 half-dim7	 R			 b3			 b5				 b7
 diminished [7th]	 dim7	 R			 b3			 b5			 bb7
 
 The last four chords are more complicated because of possible misunderstanding.
 Consider the 7th augmented 5th chord- Is it the augmented 5th triad with added 7th? Or is it a 7th chord with an augmented 5th (ie sharpened 5th)? Luckily, interpreting it both ways will give the same chord (ie R,3,#5,b7).
 
 Next, consider the 7th diminished 5th chord - Is it the diminished 5th triad with added 7th? Or is it a 7th chord with a diminished 5th (ie flattened 5th)? The chord structure is R,3,b5,b7 which means it is a 7th with diminished 5th. This is often very confusing.
 
 The obvious question is @"What then is the diminished 5th triad with added 7th?". This would be R,b3,b5,b7 and it's called the half-diminished 7th. This too is often confusing.
 
 The last one is the diminished 7th! It is a diminished 7th triad with a diminished 7th. Structurally, it is R,b3,b5,bb7. The origin of this chord is different from the rest because it relates back to the diminished scale. It is a special chord because the spacing between each interval is exactly the same (ie 3 semitones). Note - aka @"the diminished chord" aka @"dim7" aka @"dim".
 
 Looking at the last four sevenths, confusion arises because of the ambiguity of the words @"diminished" and @"augmented". It is hard to tell if they refer to the chord or the note.
 
 As such, I would like to introduce you to a chord-naming system which utilises most of the traditional chord names and methods but is very specific when describing chords or notes.
 
 
 System for Chord Names
 
 IMPORTANT - The chord-naming system from here on is very specific and will mean that some traditional names like 7dim5 and half-dim7 will not be used. However, be assured that, using this system, any named chord will be easily understood by musicians.
 The system used has the following components:-
 
 BASE-CHORD + Alterations + Replacements + Additions1 + Additions2...etc
 Base-Chord - The basic chord. Allowed names are Major, minor, aug5, dim7 and dim5 in that order of priority. To avoid any confusion, the word @"Major" is never used but is taken for granted as the Major chord (the default base-chord).
 Alterations - Any note alterations to the basic chord. Allowed descriptors are (-) for flattened and (+) for sharpened. The words @"aug" and @"dim" are NOT allowed for notes and are reserved only for chords. Alterations are always in parentheses (brackets).
 Replacements - Any replacements to the basic-chord. Basically, these are suspended 4th and suspended 2nd in that order of priority.
 Additions - Any additions to the basic chord. They are prefixed with the word @"added" (or @"add"). Examples are 7th, 6th, 9th, 11th, and 13th in that order of priority. Note that additions have to have a number greater than 5 so @"added 2nd" is named as @"added 9th" (ie it is treated as beyond one octave).
 more Additions - You can have as many additions as needed but remember that they have to be declared in order of priority.
 To use this system, you must become familiar with the base chord structures.
 - When there is a [major] 3rd note, it could be a major or an aug5 chord.
 - When there is a flat 3rd note, it could be a minor or dim chord.
 - When there is a [perfect] 5th note, it could be a major or minor chord.
 - When there is a flat 5th note, it could be a dim chord.
 - When there is a sharp 5th note, it could be an aug5 chord.
 Note - the diminished 7th (R,b3,b5,bb7) is treated as a base-chord.
 
 The system has a specific order of components(ie Base-Chord, Alteration, Replacement, Additions). The point is to declare components only if needed. If a chord qualifys as say an @"aug 5 chord", there is no point in calling it a @"major chord" with alteration of a @"sharp 5th".
 
 "Priority" is mentioned for most of the components. Priority only comes into play when a component can be named in more than one way. How does it all work? Let's see a few examples with root @"C":-
 R, b3, #5 - Base-chord could be a minor or aug5. By priority, it is a minor and so it has one alteration being the sharpened 5th. Name = Cmin(+5).
 R, 3, b5 - Base-chord could be major or dim5. By priority, it is a major and so the alteration is the flat 5th. Name = C(-5).
 R, 4, #5 - It has not 3rd (it's a replacement using sus4). With the @"#5" it is assumed to be an aug5 chord. Name = Caug5sus4
 R, 4, b5 - It has no 3rd (it's a replacement using sus4). With the @"b5" it is assumed to be a dim5 chord. Name = Cdim5sus4.
 R, 2, 3, 5 - This as a major (R,3,5) with an addition. Since, the additon is the leftover 2nd, this would be called a 9th. Name = Cadd9.
 R, 2, 4, 5 - It's definitely a replacement and the leftover will be an addition. The base-chord could be a major or minor so, by priority, it defaults to a major. It has two possible replacements being sus4 or sus2. By priority, it is deemed to be a sus4. Name = Csus4add9.
 
 3-Note Chord Listing
 
 The following table is a chord listings for 3-note chords using the chord-naming system described above. This time, guitar chords are also included in root @"E" and @"A".
 
 The guitar chords are quoted by fret-position in the order of EADGBE strings (0 = open string, x = not played, o = optional). Example: Edim5 is 0120xo meaning the chord is held as open on top E string, 1st fret of A string, 2nd fret on D string, open on G string, not played on B string, and, optional open on bottom E string (ie not absolutely necessary).
 
 3 NOTE CHORDS	 key=C	 C	Db	 D	Eb	 E	 F	Gb	 G	Ab	 A	Bb	 B	 key=E	 key=A
 -	Abbrev	 R	b2	 2	b3	 3	 4	b5	 5	b6	 6	b7	 7	 EADGBE	 EADGBE
 Major		 R				 3			 5					 0221oo	 o0222o
 Major flat5th	(-5)	 R				 3		 b5						 0121xo	 x0122x
 minor	 min	 R			b3				 5					 0220oo	 o0221o
 minor sharp5th	 min(+5)	 R			b3					 #5				 0320xo	 x0321x
 augmented 5th	 aug5	 R				 3				#5				 0321xo	 x0322x
 diminished 5th	 dim5	 R			b3			b5						 0120xo	 x0121x
 suspended 4th	 sus4	 R					 4		 5					 0222oo	 o0223o
 aug5th sus4th	 aug5sus4	 R					 4			#5				 0322xo	 x0323x
 dim5th sus4th	 dim5sus4	 R					 4	b5						 0122xo	 x0123x
 suspended 2nd	 sus2	 R		 2					 5					 024xoo	 o0220o
 aug5th sus2nd	 aug5sus2	 R		 2						 #5				 x7455x	 x0320x
 dim5th sus2nd	 dim5sus2	 R		 2				 b5						 x7897x	 x0120x
 
 
 Shortened Chord Names
 
 At this point, I would like to introduce a short-cut for the @"added 7th" chords as well as the @"added 6th" chords (in that order of priority).
 
 The chord-naming components are:-
 BASE-CHORD + Alterations + Replacements + Additions1 + Additions2...etc
 By introducing a short-cut for 7ths and 6ths, the components becomes:-
 BASE-CHORD (+ 7ths/6ths) + Alterations + Replacements + other Additions
 Actually, the same rules still apply except that, for 7ths and 6ths, the word @"added" is not needed (ie Cmin add7 is now Cmin7). Furthermore, the alterations and replacements are declared after (eg Csus4add7 is now C7sus4, and, Cmin(+5)add7 is now Cmin7(+5)).
 
 So, what becomes of the traditional 7aug5, 7dim5 and half-dim7?
 Using root @"C":-
 - The 7aug5 or R,3,#5,b7 would be an aug5 base-chord with 7th. Name = Caug5/7.
 - The 7dim5 or R,3,b5,b7 would be a major base-chord with 7th, altered with flattened 5th. Name = C7(-5).
 - The half-dim7 or R,b3,b5,b7 would be a dim5 base-chord with an added 7th. Name = Cdim5/7
 Note - the slash (/) is used as a separator to prevent any misunderstanding. This only applies to the aug and dim base-chords (because the chord-names contain numbers).
 
 
 4-Note Chords
 
 The following table is a chord listing for 4-note chords. Note that only 7ths and 6ths are using the allowed short-cut names. All other additions have the word @"added" declared.
 
 * indicates departure from traditional chord names.
 4 NOTE CHORDS	 key=C	 C	 Db	 D	 Eb	 E	 F	 Gb	 G	 Ab	 A	 Bb	 B	 key=E	 key=A
 ~ MAJOR & MINOR	 Abbrev	 R	 b2	 2	 b3	 3	 4	 b5	 5	 b6	 6	 b7	 7	 EADGBE	 EADGBE
 6th	 6	 R				 3			 5		 6			 02212o	 o02222
 7th	 7	 R				 3			 5			 b7		 0201oo	 o0202o
 Maj 7th	 M7	 R				 3			 5				 7	 0211oo	 o0212o
 added 9th	 add9	 R		 9		 3			 5					 022102	 o0242o
 added 11th	 add11	 R				 3	 11		 5					 o764x5	 54223o
 6th flat5th*	 6(-5)	 R				 3		 b5			 6			 01212o	 x01222
 7th flat5th*	 7(-5)	 R				 3		 b5				 b7		 0101xo	 x0102x
 Maj 7th flat5th*	 M7(-5)	 R				 3		 b5					 7	 0111xo	 x0112x
 minor flat6th	 min(-6)	 R			 b3				 5	 b6				 02201o	 o02211
 minor 6th	 min6	 R			 b3				 5		 6			 02202o	 o02212
 minor 7th	 min7	 R			 b3				 5			 b7		 0200oo	 o0201o
 minor Maj 7th	 min M7	 R			 b3				 5				 7	 0210oo	 o0211o
 minor add flat9th	 min add(-9)	 R	 b9		 b3				 5					 022001	 o0231o
 minor add 9th	 min add9	 R		 9	 b3				 5					 022002	 o02212
 minor add 11th	 min add11	 R			 b3		 11		 5					 0252oo	 o0253o
 ~ AUG. & DIM.	Abbrev	 C	 Db	 D	 Eb	 E	 F	 Gb	 G	 Ab	 A	 Bb	 B	 EADGBE	 EADGBE
 aug 5th / 7th*	 aug5/7	 R				 3				 #5		 b7		 0301xo	 x0302x
 aug 5th Maj 7th*	 aug5M7	 R				 3				 #5			 7	 0311xo	 x0312x
 aug 5th add 9th	 aug5 add9	 R		 9		 3				 #5				 0341xo	 x03222
 diminished [7th]	 dim7	 R			 b3			 b5			 bb7			 01202o	 x01212
 dim 5th / 7th*	 dim5/7	 R			 b3			 b5				 b7		 0100xo	 x0101x
 dim 5th add 9th	 dim5 add9	 R		 9	 b3			 b5						 0140xo	 x01212
 ~ SUSPENDED	Abbrev	 R	 b2	 2	 b3	 3	 4	 b5	 5	 b6	 6	 b7	 7	 EADGBE	 EADGBE
 flat6th sus 4th	 (-6)sus4	 R					 4		 5	 b6				 02221o	 o02231
 6th sus 4th	 6sus4	 R					 4		 5		 6			 02222o	 o02232
 7th sus 4th	 7sus4	 R					 4		 5			 b7		 0202oo	 o0203o
 Maj7th sus 4th	 M7sus4	 R					 4		 5				 7	 0212oo	 o0213o
 sus 4th add flat9th	 sus4add(-9)	 R	 b9				 4		 5					 0232oo	 o02330
 sus 4th add 9th	 sus4add9	 R		 9			 4		 5					 0242oo	 o00200
 flat6th sus 2nd	 (-6)sus2	 R		 2					 5	 b6				 o79978	 o02201
 6th sus 2nd	 6sus2	 R		 2					 5		 6			 022422	 o02202
 7th sus 2nd	 7sus2	 R		 2					 5			 b7		 022432	 o02203
 Maj7th sus 2nd	 M7sus2	 R		 2					 5				 7	 022442	 o02204
 
 Note - For keyboards - To play a chord uninverted, notes numbered greater that 8 are assumed to be played one octave beyond the root.
 Note - For guitars - The chords shown may differ somewhat from the chord-books. The chords shown are the least inverted forms which can be easily played.
 For more on inversions, see Chords pt 2.
 
 
 Advanced Chord Names
 
 When a chord has many @"additions", it is important to be aware of the traditional chord names and how the system (used in this document) can differ from it.
 For a base-chord with an added 7th, both traditional names and the system accept the chord-name 7th. Both also accept @"added 6ths" as named 6th.
 
 Even for the added 9ths, added 11ths and added 13ths, both traditional names and the system accept that the word @"added" or @"add" must be declared.
 
 The reasons will be made clearer when you compare the traditional names and this system's names in the table below.
 Structure	 System	 Traditional	 Traditional
 -	 Chord Name	- keyboards	- guitar
 R,3,5,b7	 7th	 7th	 7th
 R,3,5,9	 add9	 add9	 add9
 R,3,5,b7,9	 7 add9	 9th	 9th
 R,3,5,b7,11	 7 add11	 7 add11	 11th
 R,3,5,b7,9,11	 7 add9 add11	 11th	 9 add11
 R,3,5,b7,13	 7 add13	 7 add13	 13th
 R,3,5,b7,9,13	 7 add9 add13	 9 add13	 9 add 13
 R,3,5,b7,9,11,13	 7 add9 add11 add13	 13th	 not playable
 
 As you can see, the system used here can be somewhat @"wordy" and long but is not ambiguous.
 
 For traditional guitar chord-names, the names 9th, 11th and 13th are just those notes added to the 7th chord.
 
 For traditional keyboard chord-names, the names 9th, 11th and 13th imply that the notes preceeding the name are accumulated (eg. 11th chord is 7 add9 add11).
 
 
 5-Note Chord Listing
 
 The following table is a chord listing for 5-note chords.
 * indicates departure from traditional chord names.
 
 5 NOTE CHORDS	 key=C	 C	 Db	 D	 Eb	 E	 F	 Gb	 G	 Ab	 A	 Bb	 B	 key=E	 key=A
 ~ MAJOR	 Abbrev	 R	 b2	 2	 b3	 3	 4	 b5	 5	 b6	 6	 b7	 7	 EADGBE	 EADGBE
 6th add 9th	 6add9	 R		 9		 3			 5		 6			 o76677	 o02422
 6th add 11th	 6add11	 R				 3	 11		 5		 6			 o76605	 552222
 [7th add] 9th	 7add9	 R		 9		 3			 5			 b7		 020102	 o02423
 7th add 11th	 7add11	 R				 3	 11		 5			 b7		 00010o	 o00020
 7th add 13th	 7add13	 R				 3			 5		 13	 b7		 02012o	 o02022
 Maj [7th add] 9th	 M7add9	 R		 9		 3			 5				 7	 021102	 o02424
 Maj 7th add 11th	 M7add11	 R				 3	 11		 5				 7	 00110o	 o00120
 Maj 7th add 13th	 M7add13	 R				 3			 5		 13		 7	 02112o	 o02122
 6th flat5 add 9*	 6(-5)add9	 R		 9		 3		 b5			 6			 o76676	 544445
 M7th flat5 add9*	 M7(-5)add9	 R		 9		 3		 b5					 7	 o76876	 546445
 M7th flat5 add13*	 M7(-5)add13	 R				 3		 b5			 13		 7	 o78899	 566675
 ~ MINOR	Abbrev	 C	 Db	 D	 Eb	 E	 F	 Gb	 G	 Ab	 A	 Bb	 B	 EADGBE	 EADGBE
 min 6th add 9th	 min6add9	 R		 9	 b3				 5		 6			 022022	 o02502
 min 6th add 11th	 min6add11	 R			 b3		 11		 5		 6			 02522x	 o02532
 min [7th add] 9th	 min7add9	 R		 9	 b3				 5			 b7		 020002	 o02413
 min 7th add 11th	 min7add11	 R			 b3		 11		 5			 b7		 020203	 o00010
 min 7th add 13th	 min7add13	 R			 b3				 5		 13	 b7		 02002o	 o02012
 min M7 add 9th	 min M7add9	 R		 9	 b3				 5				 7	 021002	 576557
 min M7 add 11th	 min M7add11	 R			 b3		 11		 5				 7	 001000	 o00110
 min M7 add 13th	 min M7add13	 R			 b3				 5		 13		 7	 021020	 o02112
 ~ AUG. & DIM.	Abbrev	 C	 Db	 D	 Eb	 E	 F	 Gb	 G	 Ab	 A	 Bb	 B	 EADGBE	 EADGBE
 aug5/ 7th add 9th*	 aug5/7add9	 R		 9		 3				 #5		 b7		 030112	 x05667
 aug5/ 7th add 11th*	 aug5/7add11	 R				 3	 11			 #5		 b7		 030214	 555665
 aug5/ 7th add13th*	 aug5/7add13	 R				 3				 #5	 13	 b7		 030120	 x03022
 dim5/ 7th add 9th*	 dim5/7add9	 R		 9	 b3			 b5				 b7		 010032	 565587
 dim5/ 7th add 11th*	 dim5/7add11	 R			 b3		 11	 b5				 b7		 010233	 565788
 dim5/ 7th add 13th*	 dim5/7add13	 R			 b3			 b5			 13	 b7		 010020	 o01012
 ~ SUSPENDED	Abbrev	 R	 b2	 2	 b3	 3	 4	 b5	 5	 b6	 6	 b7	 7	 EADGBE	 EADGBE
 6th sus 4th add 9th	 6sus4add9	 R		 9			 4		 5		 6			 022222	 o02432
 7th sus 4th add 9th	 7sus4add9	 R		 9			 4		 5			 b7		 020202	 o02433
 7th sus4 add 13th	 7sus4add13	 R					 4		 5		 13	 b7		 02022o	 o02032
 M7th sus4th add9th	 M7sus4add9	 R		 9			 4		 5				 7	 001202	 o00100
 M7th sus4th add13	 M7sus4add13	 R					 4		 5		 13		 7	 021220	 o02132
 7th sus2 add 13th	 7sus2add13	 R		 2					 5		 13	 b7		 o79779	 o02002
 M7th sus2nd add13	 M7sus2add13	 R		 2					 5		 13		 7	 o79879	 o02102
 
 
 */

//http://www.angelfire.com/in2/yala/4chords2.htm

/*
 Terms & Abbreviations Used
 
 "b" or (-) - means @"flat" note.
 "#" or (+) - means @"sharp" note.
 "R" - means @"root" note.
 Maj or @"M" - means @"Major" chord.
 min or @"m" - means @"minor" chord.
 aug - means @"augmented" chord.
 dim - means @"diminished" chord.
 sus - means @"suspended" chord.
 add - means @"added" note.
 [????] - words enclosed by square parentheses means they are sometimes omitted.
 aka - abbreviation for @"also known as".
 
 Inversions and Equivalents
 
 An inverted chord occurs when a chord is not played as a @"straight root" chord. Example: a C major triad uninverted is played as C,E,G (from lowest note to highest note). The first inversion is played as E,G,C and the second inversion is G,C,E.
 
 The same applies to non triads as well. Example: Amin7 ; Straight root chord = A,C,E,G ; 1st inversion = C,E,G,A ; 2nd inversion = E,G,A,C ; 3rd inversion = G,A,C,E.
 
 As it happens Amin7 (A,C,E,G) and C6 (C,E,G,A) are equivalents. When you play Amin7, it is also an inverted C6 (and vice-versa). As with all inversions, the basic difference is the perception of what the root note is.
 
 Using inverted equivalents is very useful especially if the straight root chord is awkward or inconvenient to play.
 
 The table below lists chords and their inverted equivalents. The @"transpose" column denotes the root of the equivalent in semitones (from the starting chord). Example: With a starting chord of Amin7, the equivalent C6 is a transpose of @"^+3/-9". All this means is that @"C" is 3 semitones UP from @"A" (or 9 semitones DOWN from @"A").
 
 Guitar chord notes within @"{" and @"}" (curly brackets) denote the root.
 
 SYMMETRICAL CHORDS
 -	Chord notes	Chord	E-A-D-G-B-E	R	b2	2	b3	3	4	b5	5	b6	6	b7	7
 transpose	 R,b3,b5,bb7	 Edim7	 x x{2}3 2 3	 R	-	-	 b3	-	-	 b5	-	-	 bb7	-	-
 ^+3/-9	 R,b3,b5,bb7	 Gdim7	 x x 2 3 2{3}	 bb7			 R			 b3			 b5
 ^+6/-6	 R,b3,b5,bb7	 Bbdim7	 x x 2{3}2 3	 b5			 bb7			 R			 b3
 ^+9/-3	 R,b3,b5,bb7	 C#dim7	 x x 2 3{2}3	 b3			 b5			 bb7			 R
 transpose	 R,3,#5	 Faug5	 x x{3}2 2 1	 R	-	-	-	 3	-	-	-	 #5	-	-	-
 ^+4/-8	 R,3,#5	 Aaug5	 x x 3{2}2 1	 #5				 R				 3
 ^+8/-4	 R,3,#5	 C#aug5	 x x 3 2{2}1	 3				 #5				 R
 3-NOTE CHORDS
 -	Chord notes	Chord	E-A-D-G-B-E	R	b2	2	b3	3	4	b5	5	b6	6	b7	7
 transpose	 R,b3,5	 Amin	 o{0}2 2 1 0	 R	-	-	 b3	-	-	-	 5	-	-	-	-
 ^+7/-5	 R,4,#5	 Eaug5sus4	 {o}0{2}2 1 0	 4			 #5				 R
 transpose	 R,2,5	 Asus2	 o{0}2 2 0 o	 R	-	 2	-	-	-	-	 5	-	-	-	-
 ^+7/-5	 R,4,5	 Esus4	 {o}0{2}2 0 o	 4		 5					 R
 transpose	 R,2,#5	 Aaug5sus2	 x{0}3 2 0 x	 R	-	 2	-	-	-	-	-	 #5	-	-	-
 ^+8/-4	 R,3,b5	 F(-5)	 x 0{3}2 0 x	 3		 b5						 R
 
 4-NOTE CHORDS
 -	Chord notes	Chord	E-A-D-G-B-E	R	b2	2	b3	3	4	b5	5	b6	6	b7	7
 transpose	 R,b3,5,b7	 Amin7	 x{0}2 0 1 0	 R	-	-	 b3	-	-	-	 5	-	-	 b7	-
 ^+7/-5	 R,b3,#5,11	 Emin(+5) add11	 x 0{2}0 1 0	 11			 #5				 R			 b3
 ^+3/-9	 R,3,5,6	 C6	 x 0 2 0{1}0	 6			 R				 3			 5
 transpose	 R,4,5,b7	 A7sus4	 x{0}2 0 3 0	 R	-	-	-	-	 4	-	 5	-	-	 b7	-
 ^+10/-2	 R,2,5,6	 G6sus2	 x 0 2{0}3 0	 2					 5		 6			 R
 ^+5/-7	 R,4,5,9	 Dsus4 add9	 x 0 2 0{3}0	 5					 R		 9			 4
 transpose	 R,2,5,b7	 A7sus2	 o{0}2 0 0 0	 R	-	 2	-	-	-	-	 5	-	-	 b7	-
 ^+7/-5	 R,b3,5,11	 Emin add11	 {o}0{2}0 0 0	 11		 5					 R			 b3
 ^+2/-10	 R,4,#5,b7	 Baug5/7sus4	 o 0 2 0{0}0	 b7		 R					 4			 #5
 transpose	 R,2,5,7	 CM7sus2	 x{3}0 0 0 x	 R	-	 2	-	-	-	-	 5	-	-	-	 7
 ^+7/-5	 R,3,5,11	 G add11	 x 3 0{0}0 x	 11		 5					 R				 3
 ^+11/-1	 R,b3,#5,b9	 Bmin(+5) add(-9)	 x 3 0 0{0}x	 b9		 b3					 #5				 R
 transpose	 R,3,5,9	 Cadd9	 x{3}2 0 3 0	 R	-	 9	-	 3	-	-	 5	-	-	-	-
 ^+4/-8	 R,b3,#5,b7	 Emin7(+5)	 x 3{2}0 3 0	 #5		 b7		 R			 b3
 ^+7/-5	 R,4,5,6	 G6sus4	 x 3 2{0}3 0	 4		 5		 6			 R
 -	Chord notes	Chord	E-A-D-G-B-E	R	b2	2	b3	3	4	b5	5	b6	6	b7	7
 transpose	 R,3,b5,6	 F6(-5)	 x x{3}4 3 5	 R	-	-	-	 3	-	 b5	-	-	 6	-	-
 ^+6/-6	 R,b3,b5,b7	 Bdim5/7	 x x 3{4}3 5	 b5				 b7		 R			 b3
 ^+9/-3	 R,b3,5,6	 Dmin6	 x x 3 4{3}5	 b3				 5		 6			 R
 ^+4/-8	 R,4,#5,9	 Aaug5sus4 add9	 x x 3 4 3{5}	 #5				 R		 9			 4
 transpose	 R,3,b5,b7	 B7(-5)	 x{2}3 2 4 x	 R	-	-	-	 3	-	 b5	-	-	-	 b7	-
 ^+6/-6	 R,3,b5,b7	 F7(-5)	 x 2{3}2 4 x	 b5				 b7		 R				 3
 transpose	 R,b3,5,b6	 Amin(-6)	 x{0}3 2 1 0	 R	-	-	 b3	-	-	-	 5	 b6	-	-	-
 ^+8/-4	 R,3,5,7	 FM7	 x 0{3}2 1 0	 3			 5				 7	 R
 ^+7/-5	 R,4,#5,b9	 Eaug5sus4 add(-9)	 x 0 3 2 1{0}	 4			 #5				 R	 b9
 transpose	 R,4,5,b9	 Esus4 add(-9)	 {0}2 3 2 0 0	 R	 b9	-	-	-	 4	-	 5	-	-	-	-
 ^+5/-7	 R,2,5,b6	 A(-6)sus2	 0 2 3{2}0 0	 5	 b6				 R		 2
 ^+1/-11	 R,3,b5,7	 FM7(-5)	 0 2{3}2 0 0	 7	 R				 3		 b5
 transpose	 R,3,#5,9	 Caug5 add9	 x{3}2 1 3 x	 R	-	 9	-	 3	-	-	-	 #5	-	-	-
 ^+4/-8	 R,3,#5,b7	 Eaug5/7	 x 3{2}1 3 x	 #5		 b7		 R				 3
 transpose	 R,4,5,b6	 A(-6)sus4	 x{0}3 2 3 0	 R	-	-	-	-	 4	-	 5	 b6	-	-	-
 ^+5/-7	 R,b3,5,9	 Dmin add9	 x 0 3 2{3}0	 5					 R		 9	 b3
 
 5-NOTE CHORDS
 -	Chord notes	Chord	E-A-D-G-B-E	R	b2	2	b3	3	4	b5	5	b6	6	b7	7
 transpose	 R,b3,5,b7,11	 Emin7add11	 {0}0 0 0 0{0}	 R	-	-	 b3	-	 11	-	 5	-	-	 b7	-
 ^+5/-7	 R,4,5,b7,9	 A7sus4 add9	 0{0}0 0 0 0	 5			 b7		 R		 9			 4
 ^+10/-2	 R,4,5,b7,9	 D6sus4 add9	 0 0{0}0 0 0	 9			 4		 5		 6			 R
 ^+3/-9	 R,3,5,6,9	 G6 add9	 0 0 0{0}0 0	 6			 R		 9		 3			 5
 ^+7/-5	 R,b3,#5,b7,11	 Bmin7(+5) add11	 0 0 0 0{0}0	 11			 #5		 b7		 R			 b3
 transpose	 R,3,5,b7,11	 G7 add11	 {3}3 3 4 3{3}	 R	-	-	-	 3	 11	-	 5	-	-	 b7	-
 ^+5/-7	 R,4,5,7,9	 CM7sus4 add9	 3{3}3 4 3 3	 5				 7	 R		 9			 4
 ^+10/-2	 R,2,5,6,#11	 F6sus2 add(+11)	 3 3{3}4 3 3	 2				 #11	 5		 6			 R
 ^+4/-8	 R,b3,b5,b6,b9	 Bdim5 add(-6) add(-9)	 3 3 3{4}3 3	 b6				 R	 b9		 b3			 b5
 transpose	 R,4,5,b7,13	 D7sus4 add13	 5{5}5 5 8 7	 R	-	-	-	-	 4	-	 5	-	 13	 b7	-
 ^+5/-7	 R,3,5,9,11	 G add9 add(-11)	 5 5{5}5 8 7	 5					 R		 9		 3	 b11
 ^+10/-2	 R,2,5,7,13	 C7sus2 add13	 5 5 5{5}8 7	 2					 5		 13		 7	 R
 ^+9/-3	 R,b3,#5,b7,b9	 Bmin7(+5) add(-9)	 5 5 5 5 8{7}	 b3					 #5		 b7		 R	 b9
 transpose	 R,b3,5,b7,b13	 Emin7 add(-13)	 {0}3 0 0 0{0}	 R	-	-	 b3	-	-	-	 5	 b13	-	 b7	-
 ^+8/-4	 R,3,5,7,9	 CM7 add9	 0{3}0 0 0 0	 3			 5				 7	 R		 9
 ^+3/-9	 R,3,5,6,11	 G6 add11	 0 3 0{0}0 0	 6			 R				 3	 11		 5
 ^+7/-5	 R,b3,#5,b9,11	 Bmin(+5) add(-9) add11	 0 3 0 0{0}0	 11			 #5				 R	 b9		 b3
 -	Chord notes	Chord	E-A-D-G-B-E	R	b2	2	b3	3	4	b5	5	b6	6	b7	7
 transpose	 R,4,#5,b7,9	 Aaug5/7sus4 add9	 x{0}0 0 0 1	 R	-	 9	-	-	 4	-	-	 #5	-	 b7	-
 ^+5/-7	 R,b3,5,6,11	 Dmin6 add11	 x 0{0}0 0 1	 5		 6			 R			 b3		 11
 ^+10/-2	 R,3,5,b7,9	 G7 add9	 x 0 0{0}0 1	 9		 3			 5			 b7		 R
 ^+2/-10	 R,b3,b5,b7,b13	 Bdim5/7 add(-13)	 x 0 0 0{0}1	 b7		 R			 b3			 b5		 b13
 ^+8/-4	 R,3,b5,6,9	 F6(-5) add9	 x 0 0 0 0{1}	 3		 b5			 6			 R		 9
 transpose	 R,3,b5,7,13	 FM7(-5) add13	 {1}0 0 2 0 0	 R	-	-	-	 3	-	 b5	-	-	 13	-	 7
 ^+4/-8	 R,4,5,b6,9	 A(-6)sus4 add9	 1{0}0 2 0 0	 b6				 R		 9			 4		 5
 ^+9/-3	 R,b3,5,6,9	 Dmin6 add9	 1 0{0}2 0 0	 b3				 5		 6			 R		 9
 ^+6/-6	 R,b3,b5,b7,11	 Bdim5/7 add11	 1 0 0 2{0}0	 b5				 b7		 R			 b3		 11
 ^+11/-1	 R,4,5,b7,b9	 E7sus4 add(-9)	 1 0 0 2 0{0}	 b9				 4		 5			 b7		 R
 transpose	 R,4,#5,b7,b9	 Baug5/7sus4 add(-9)	 x{2}5 5 5 5	 R	 b9	-	-	-	 4	-	-	 #5	-	 b7	-
 ^+1/-11	 R,3,5,7,13	 CM7add13	 x 2 5{5}5 5	 7	 R				 3			 5		 13
 ^+5/-7	 R,b3,5,b6,11	 Emin(-6) add11	 x 2 5 5{5}5	 5	 b6				 R			 b3		 11
 ^+10/-2	 R,b3,5,b7,9	 Amin7 add9	 x 2 5 5 5{5}	 9	 b3				 5			 b7		 R
 
 For guitars, inversions are a way of life. On guitar, as long as the root is the bass-note and the 3rd and 5th appear later, it is a straight root chord. For additions, as long as they appear last, it is still a straight root chord. Even if an addition appears between the 3rd and 5th, it is considered as a small inversion.
 
 The practical application of equivalents is interesting. Example: You can pass-off any song diatonic to C major (or A minor) by only using Amin7, Dmin7 and Emin7. This is because Amin7 = C6 ; Dmin7 = F6 ; Emin7 = G6 = Bmin(+5)add11 (For more on diatonics, see Chord Reference below). For guitar, I recommend using 575555, x57565 and x79787 respectively.
 
 
 More Naming Techniques
 
 A @"BiTonal Chord" is a chord played over a non-root bass. This is really a matter of perception. For example, if you were playing a Cmajor chord over a bass of @"A", then the resultant chord is Amin7 (ie A,C,E,G). We can assume this because the perceived root will be the @"A" bass-note.
 
 But what if the song has a static chord over bass progression? Or what if the song has a chord progression over a static bassline?
 
 In that instance, it is easier to use the @"Chord-over-Bass" description. Example from above would be written as C/A (ie @"Cmajor" over an @"A" root/bass). In this way, a chord progression can be described as Amin, Amin/G, Amin/F, Amin/E (which conveys the message far better and easier than standard chord-naming).
 
 Another use for the @"Chord-over-Bass" method is where a chord doesn't have a 5th note. Example: C,D,F,A (R,2,4,6) - Using traditional or the chord-name system, it would be @"C6 omit5 sus4 add9" (using @"omit" is acceptable) or cheat using C6(--5)sus2 or C(++5)sus4 add9. In Chord-over-Bass, it's just Dmin/C.
 
 
 Chord Reference (mode diatonic)
 
 It is nearly impossible to list every conceiveable chord in every root-key. Instead of repeating the chord listing from part 1 in different keys, I thought that it would be more useful to look at chords which are @"mode diatonic".
 
 In a scale, all of its notes are @"diatonic" to that scale (ie they conform with that scale). Therefore, if all the notes of a Chord happen to belong to any Scales, then the Chord is @"diatonic" to those Scales. Example: Chord @"A minor" comprises A,C,E - so the @"A minor" chord is diatonic to the scales of CMaj, Amin, FMaj, Dmin, GMaj and Emin (ie any scale with all those notes). If it does not conform, then it is @"chromatic" to that scale.
 
 Tabled below is a list of of chords which conforms to the C major and A minor scale. In music terminology, they are modal diatonic chords (Major and minor belong to a group called @"Modes"; see article on Scales). In other words, all these chords only use the white-notes on a keyboard.
 
 Chords for C Major and A minor	K E Y B O A R D	Notes	G U I T A R
 3-note MAIN	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 C	 C Major	 R		 3		 5			 C E G	 x 3 5 5 5 3	 x 3 2 0 1 0
 F	 F Major	 5			 R		 3		 F A C	 1 3 3 2 1 1	 x 8 7 5 6 5
 G	 G Major		 5			 R		 3	 G B D	 3 5 5 4 3 3	 3 2 0 0 0 3
 F (-5)					 R		 3	 b5	 F A B	 1 2 3 2 0 x
 D min	 Dm		 R		 b3		 5		 D F A	 x 5 7 7 6 5	 x x 0 2 3 1
 E min	 Em			 R		 b3		 5	 E G B	 0 2 2 0 0 0	 x 7 9 9 8 7
 A min	 Am	 b3		 5			 R		 A C E	 x 0 2 2 1 0	 5 7 7 5 5 5
 B min(+5)			 b3			 #5		 R	 B D G	 x 2 0 0 0 3
 B dim5			 b3		 b5			 R	 B D F	 x 2 3 4 3 x	 7 8 9 7 x x
 3-note SUS	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 C sus4		 R			 4	 5			 C F G	 x 3 5 5 6 3	 x 3 3 0 1 1
 D sus4			 R			 4	 5		 D G A	 x 5 7 7 8 5	 x x 0 2 3 3
 E sus4				 R			 4	 5	 E A B	 0 2 2 2 0 0
 G sus4		 4	 5			 R			 G C D	 3 5 5 5 3 3	 3 3 0 0 3 3
 A sus4			 4	 5			 R		 A D E	 x 0 2 2 3 0	 5 7 7 7 5 5
 E aug5 sus4		 #5		 R			 4		 E A C	 x 7 7 5 5 5
 A aug5 sus4			 4		 #5		 R		 A D F	 x 0 3 2 3 x
 B aug5 sus4				 4		 #5		 R	 B E G	 x 2 2 0 0 0
 B dim5 sus4				 4	 b5			 R	 B E F	 x 2 3 4 5 x
 C sus2		 R	 2			 5			 C D G	 x 3 0 0 1 x	 x 3 5 5 3 3
 D sus2			 R	 2			 5		 D E A	 x x 0 2 3 0	 x 5 7 7 5 5
 F sus2		 5			 R	 2			 F G C	 1 3 3 0 x x	 x 8 5 5 6 x
 G sus2			 5			 R	 2		 G A D	 3 0 0 0 3 3	 x x 5 2 3 3
 A sus2				 5			 R	 2	 A B E	 x 0 2 2 0 0
 A aug5 sus2					 #5		 R	 2	 A B F	 x 0 3 2 0 x
 
 
 Chords for C Major and A minor	K E Y B O A R D	Notes	G U I T A R
 4-note MAJOR	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 C6	 Cadd6	 R		 3		 5	 6		 C E G A	 x 3 5 5 5 5	 x 3 2 2 1 0
 F6	 Fadd6	 5	 6		 R		 3		 F A C D	 x x 3 5 3 5
 G6	 Gadd6		 5	 6		 R		 3	 G B D E	 3 2 0 0 0 0	 x x 5 4 3 0
 G7	 Gadd7		 5		 b7	 R		 3	 G B D F	 3 5 3 4 3 3	 3 2 0 0 0 1
 CM7	 CaddMaj7	 R		 3		 5		 7	 C E G B	 x 3 5 4 5 3	 x 3 2 0 0 0
 FM7	 FaddMaj7	 5		 7	 R		 3		 F A C E	 1 3 2 2 1 1	 x x 3 2 1 0
 C add9		 R	 9	 3		 5			 C E G D	 x 3 2 0 3 0
 G add9			 5			 R	 9	 3	 G B D A	 3 2 0 2 0 x	 x x 5 4 3 5
 C add11		 R		 3	 11	 5			 C E G F	 x 3 2 0 1 1
 G add11		 11	 5			 R		 3	 G B D C	 3 2 0 0 1 x
 F6(-5)	 F6(b5)		 6		 R		 3	 b5	 F A B D	 1 0 0 2 0 x
 FM7(-5)	 FM7(b5)			 7	 R		 3	 b5	 F A B E	 x x 3 2 0 0
 4-note MINOR	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 Amin(-6)	Amin add(-6)	 b3		 5	 b6		 R		 A C E F	 x 0 3 2 1 0	 x 0 2 2 1 1
 D min6	 Dmin add6		 R		 b3		 5	 6	 D F A B	 x x 0 2 0 1
 D min7	 Dmin add7	 b7	 R		 b3		 5		 D F A C	 x 5 7 5 6 5	 x x 0 2 1 1
 E min7	 Emin add7		 b7	 R		 b3		 5	 E G B D	 0 2 0 0 0 0
 A min7	 Amin add7	 b3		 5		 b7	 R		 A C E G	 x 0 2 0 1 0	 x 0 2 2 1 3
 E min add(-9)	 Emin add(b9)			 R	 b9	 b3		 5	 E G B F	 0 2 2 0 0 1	 0 2 3 0 o o
 D min add9			 R	 9	 b3		 5		 D F A E	 x 5 3 2 5 x
 A min add9		 b3		 5			 R	 9	 A C E B	 5 7 7 5 5 7	 x 0 2 4 1 0
 D min add11			 R		 b3	 11	 5		 D F A G	 x 5 3 2 x 3
 E min add11				 R		 b3	 11	 5	 E G B A	 0 2 5 2 o o
 A min add11		 b3	 11	 5			 R		 A C E D	 x 0 2 5 3 o
 4-note DIM5	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 B dim5/7	 Bhalf-dim7		 b3		 b5		 b7	 R	 B D F A	 x 2 3 2 3 x
 4-note SUS4	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 E(-6) sus4	 Esus4add(-6)	 b6		 R			 4	 5	 E A B C	 0 2 2 0 1 o
 A(-6) sus4	 Asus4add(-6)		 4	 5	 b6		 R		 A D E F	 o 0 2 2 1 1
 C6 sus4	 Csus4add6	 R			 4	 5	 6		 C F G A	 x 3 5 5 6 5
 D6 sus4	 Dsus4add6		 R			 4	 5	 6	 D G A B	 x 5 7 7 8 7
 G6 sus4	 Gsus4add6	 4	 5	 6		 R			 G C D E	 3 3 0 0 1 0	 3 5 5 5 5 x
 D7 sus4	 Dsus4add7	 b7	 R			 4	 5		 D G A C	 x 5 7 5 8 5	 x x 0 2 1 3
 E7 sus4	 Esus4add7		 b7	 R			 4	 5	 E A B D	 0 2 0 2 0 0
 G7 sus4	 Gsus4add7	 4	 5		 b7	 R			 G C D F	 3 5 3 5 3 3	 3 3 0 0 1 1
 A7 sus4	 Asus4add7		 4	 5		 b7	 R		 A D E G	 x 0 2 0 3 0
 CM7 sus4	 Csus4addM7	 R			 4	 5		 7	 C F G B	 x 3 3 0 0 x
 E sus4 add(-9)				 R	 b9		 4	 5	 E A B F	 o 0 2 3 3 0
 C sus4 add9		 R	 9		 4	 5			 C F G D	 x 3 3 0 3 x
 D sus4 add9			 R	 9		 4	 5		 D G A E	 x 5 5 2 5 x
 G sus4 add9		 4	 5			 R	 9		 G C D A	 3 3 0 2 x x
 A sus4 add9			 4	 5			 R	 9	 A D E B	 5 5 2 4 x x	 x 0 0 2 0 0
 4-note SUS2	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 A(-6) sus2	 Asus2add(-6)			 5	 b6		 R	 2	 A B E F	 o 0 2 2 0 1
 C6 sus2	 Csus2add6	 R	 2			 5	 6		 C D G A	 x 3 5 5 3 5
 D6 sus2	 Dsus2add6		 R	 2			 5	 6	 D E A B	 x 5 7 7 5 7	 x x 0 2 0 0
 F6 sus2	 Fsus2add6	 5	 6		 R	 2			 F G C D	 1 3 3 0 3 x	 x x 3 5 3 3
 G6 sus2	 Gsus2add6		 5	 6		 R	 2		 G A D E	 x x 5 7 5 5
 D7 sus2	 Dsus2add7	 b7	 R	 2			 5		 D E A C	 x 5 7 7 5 8	 x x 0 2 1 0
 G7 sus2	 Gsus2add7		 5		 b7	 R	 2		 G A D F	 x x 5 7 6 5
 A7 sus2	 Asus2add7			 5		 b7	 R	 2	 A B E G	 x 0 2 0 0 0
 CM7 sus2	 Csus2addM7	 R	 2			 5		 7	 C D G B	 x 3 0 0 0 x
 FM7 sus2	 Fsus2addM7	 5		 7	 R	 2			 F G C E	 x x 3 0 1 0
 
 
 Chords for C Major and A minor	K E Y B O A R D	Notes	G U I T A R
 5-note MAJOR	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 C6 add9	 C6/9	 R	 9	 3		 5	 6		 C E G A D	 x 3 2 2 3 3
 F6 add9	 F6/9	 5	 6		 R	 9	 3		 F A C D G	 1 0 0 0 1 1
 G6 add9	 G6/9		 5	 6		 R	 9	 6	 G B D E A	 3 2 2 2 3 3	 3 2 0 2 0 0
 C6 add11		 R		 3	 11	 5	 6		 C E G A F	 8 7 5 5 6 5
 G6 add11		 11	 5	 6		 R		 3	 G B D E C	 3 2 0 0 1 0
 G7 add9	 G9		 5		 b7	 R	 9	 3	 G B D F A	 3 0 0 0 0 1
 G7 add11		 11	 5		 b7	 R		 3	 G B D F C	 3 3 0 0 0 1
 G7 add13			 5	 13	 b7	 R		 3	 G B D F E	 3 5 3 4 5 3	 3 2 3 0 3 0
 CM7 add9	 CM9	 R	 9	 3		 5		 7	 C E G B D	 x 3 0 0 0 0	 x 3 5 4 3 0
 FM7 add9	 FM9	 5		 7	 R	 9	 3		 F A C E G	 x 8 5 5 5 5	 1 0 3 0 1 0
 CM7 add11		 R		 3	 11	 5		 7	 C E G B F	 o 3 2 0 0 1
 CM7 add13		 R		 3		 5	 13	 7	 C E G B A	 x 3 5 4 5 5	 x 3 2 2 0 3
 FM7 add13		 5	 13	 7	 R		 3		 F A C E D	 1 0 0 2 1 0	 1 3 2 2 3 1
 F6(-5) add9			 6		 R	 9	 3	 b5	 F A B D G	 1 0 0 0 0 1	 x 8 7 7 8 7
 FM7(-5) add9				 7	 R	 9	 3	 b5	 F A B E G	 1 0 2 0 0 o	 x 8 7 9 8 7
 FM7(-5) add13			 13	 7	 R		 3	 b5	 F A B E D	 1 0 0 2 0 0
 5-note MINOR	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 Dmin6 add9	 Dmin6/9		 R	 9	 b3		 5	 6	 D F A B E	 o 5 3 2 0 0
 Dmin6 add11			 R		 b3	 11	 5	 6	 D F A B G	 x 5 3 2 0 3
 Dmin7 add9	 Dmin9	 b7	 R	 9	 b3		 5		 D F A C E	 x 5 3 5 5 5
 Amin7 add9	 Amin9	 b3		 5		 b7	 R	 9	 A C E G B	 5 7 5 5 5 7
 Dmin7 add11		 b7	 R		 b3	 11	 5		 D F A C G	 x 5 5 5 6 5
 Emin7 add11			 b7	 R		 b3	 11	 5	 E G B D A	 0 0 0 0 0 0	 0 2 5 2 3 x
 Amin7 add11		 b3	 11	 5		 b7	 R		 A C E G D	 o 0 0 0 1 0	 x 0 5 5 3 0
 Emin7 add(-13)		 -13	 b7	 R		 b3		 5	 E G B D C	 0 2 0 0 1 o	 x 7 9 7 8 8
 Dmin7 add13	 Dmin13	 b7	 R		 b3		 5	 13	 D F A C B	 x 5 7 5 6 7
 5-note DIM/SUS	Other Names	 C	 D	 E	 F	 G	 A	 B	-	 E A D G B E	 Alternative
 Bdim5/7 add11			 b3	 11	 b5		 b7	 R	 B D F A E	 o 2 3 2 3 0	 o 2 2 2 3 1
 C6sus4 add9	 C6/9 sus4	 R	 9		 4	 5	 6		 C F G A D	 x 3 3 2 3 3	 8 8 7 7 8 x
 D6sus4 add9	 D6/9 sus4		 R	 9		 4	 5	 6	 D G A B E	 o 5 5 4 5 5	 o 5 7 0 0 0
 G6sus4 add9	 D6/9 sus4	 4	 5	 6		 R	 9		 G C D E A	 3 3 2 2 3 x	 3 0 0 0 1 0
 G7sus4 add9	 G9sus4	 4	 5		 b7	 R	 9		 G C D F A	 3 5 3 5 3 5	 3 3 0 2 1 1
 D7sus4 add9	 D9sus4	 b7	 R	 9		 4	 5		 D G A C E	 x 5 5 5 5 5
 A7sus4 add9	 A9sus4		 4	 5		 b7	 R	 9	 A D E G B	 x 0 0 0 0 0	 x 0 2 4 3 3
 G7sus4 add13		 4	 5	 13	 b7	 R			 G C D F E	 3 5 3 5 5 3
 D7sus4 add13		 b7	 R			 4	 5	 13	 D G A C B	 x 5 7 5 8 7
 CM7sus4 add9		 R	 9		 4	 5		 7	 C F G B D	 x 3 3 4 3 3	 x 3 0 0 0 1
 CM7sus4 add13		 R			 4	 5	 13	 7	 C F G B A	 x 3 3 0 0 5
 D7sus2 add13		 b7	 R	 2			 5	 13	 D E A C B	 o 5 7 5 5 7
 G7sus2 add13			 5	 13	 b7	 R	 2		 G A D F E	 3 0 3 0 3 0
 CM7sus2 add13		 R	 2			 5	 13	 7	 C D G B A	 x 3 5 4 3 5	 x 3 0 0 0 5
 
 For the guitar chords, I have tried as far as possible to present moveable chords (usually in the main guitar chord column). A moveable chord is a chord which can be transposed by moving the finger position up or down the neck. So to transpose a moveable chord up by one semitone is to move your hand (in the same hand-shape) up to the next fret.
 
 Again for guitar, many moveable chords are @"barre-chords" or @"bar-chords". This is where the index-finger acts as a @"bar" (like a @"capo") pressing down on all strings of a fret. Basically you are emulating an open chord (max.= 3 finger chord) where the index-finger represents the open strings and the remaining 3 fingers take up the chord position.
 
 
 */
