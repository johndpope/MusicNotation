//
//  VFJison.m
//  MusicApp
//
//  Created by Scott on 6/10/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFJison.h"

@implementation VFJison
/*

%{
  var _ = require("underscore");
%}

%lex
%s notes text slur annotations options command
%%
 */

+ (CPTokeniser*)getTokeniser
{
    /*

    [tokeniser addTokenRecogniser:[CPNumberRecogniser numberRecogniser]];
    [tokeniser addTokenRecogniser:[CPWhiteSpaceRecogniser whiteSpaceRecogniser]];

    */

    CPTokeniser* tokeniser = [[CPTokeniser alloc] init];

    NSCharacterSet *identifierCharacters = [NSCharacterSet characterSetWithCharactersInString:
                                            @"abcdefghijklmnopqrstuvwxyz"
                                            @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                            @"0123456789-_"];
    NSCharacterSet *initialIdCharacters = [NSCharacterSet characterSetWithCharactersInString:
                                           @"abcdefghijklmnopqrstuvwxyz"
                                           @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                           @"_-"];
    tokeniser = [[CPTokeniser alloc] init];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"notes"     invalidFollowingCharacters:identifierCharacters]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"tabstave"      invalidFollowingCharacters:identifierCharacters]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"stave" invalidFollowingCharacters:identifierCharacters]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"voice"     invalidFollowingCharacters:identifierCharacters]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"options"     invalidFollowingCharacters:identifierCharacters]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"text"   invalidFollowingCharacters:identifierCharacters]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"slur"      invalidFollowingCharacters:identifierCharacters]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"text"     invalidFollowingCharacters:identifierCharacters]];
    
    /*
    <INITIAL>"notes"              { this.begin('notes'); return 'NOTES'; }
    <INITIAL>"tabstave"           { this.begin('options'); return 'TABSTAVE'; }
    <INITIAL>"stave"              { this.begin('options'); return 'STAVE'; }
    <INITIAL>"voice"              { this.begin('options'); return 'VOICE'; }
    <INITIAL>"options"            { this.begin('options'); return 'OPTIONS'; }
    <INITIAL>"text"               { this.begin('text'); return 'TEXT'; }
    <INITIAL>"slur"               { this.begin('options'); return 'SLUR'; }
    <INITIAL,options>[^\s=]+      return 'WORD'

    / * Annotations * /
    <notes>[$]                { this.begin('annotations'); return "$" }
    <annotations>[$]          { this.begin('notes'); return "$" }
    <annotations>[^,$]+       return 'WORD'
     */

    // commands
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"!"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"^!"]];
    
    /*
    / * Commands * /
    <notes>[!]                { this.begin('command'); return "!" }
    <command>[!]              { this.begin('notes'); return "!" }
    <command>[^!]+            return 'COMMAND'
     */

    [tokeniser
        addTokenRecogniser:[CPQuotedRecogniser quotedRecogniserWithStartQuote:@"/ *" endQuote:@"* /" name:@"Comment"]];

    // text lines
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"/"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"+"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@":"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"="]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"("]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@")"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"["]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"]"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"^"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@","]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"|"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"."]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"#"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"@"]];
    
    /*
    / * Text Lines * /
    <text>[^,\r\n]+           return 'STR'

    "/"                       return '/'
    "+"                       return '+'
    ":"                       return ':'
    "="                       return '='
    "("                       return '('
    ")"                       return ')'
    "["                       return '['
    "]"                       return ']'
    "^"                       return '^'
    ","                       return ','
    "|"                       return '|'
    "."                       return '.'
    "#"                       return '#'
    "@"                       return '@'

    / * These are valid inside fret/string expressions only * /
     */

    // articulations
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"b"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"s"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"h"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"p"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"t"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"T"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"-"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"_"]];
    /*
    / * Articulations * /
    <notes>[b]                return 'b'
    <notes>[s]                return 's'
    <notes>[h]                return 'h'
    <notes>[p]                return 'p'
    <notes>[t]                return 't'
    <notes>[T]                return 'T'
    <notes>[-]                return '-'
    <notes>[_]                return '_'
     */

    // decorators
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"v"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"V"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"u"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"d"]];
    
    /*
    / * Decorators * /
    <notes>[v]                return 'v'
    <notes>[V]                return 'V'
    <notes>[u]                return 'u'
    <notes>[d]                return 'd'
     */

    // time values
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"q"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"w"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"h"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"d"]];
    
    /*
    / * Time values * /
    <notes,text>[0-9]+        return 'NUMBER'
    <notes,text>[q]           return 'q'
    <notes,text>[w]           return 'w'
    <notes,text>[h]           return 'h'
    <notes,text>[d]           return 'd'
     */

    // slash notation
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"S"]];
    /*
    / * Slash notation * /
    <notes>[S]                return 'S'
     */

    
    /*
    / * ABC * /
    <notes>[A-GXLR]           return 'ABC'
    <notes>[n]                return 'n'
    <notes>[~]                return '~'

    / * Newlines reset your state * /
    [\r\n]+               { this.begin('INITIAL'); }
    \s+                   / * skip whitespace * /
    <<EOF>>               return 'EOF'
    .                     return 'INVALID'

    /lex

    %start e

    %%
     */
    return tokeniser;
}

/*
e:
  maybe_vextab EOF
    {
      return $1;
    }
  ;
 */

/*
maybe_vextab
  :
    { $$ = null }
  | vextab
    { $$ = $1 }
  ;
 */

/*
vextab
  : stave
    { $$ = [$1] }
  | vextab stave
    { $$ = [].concat($1, $2) }
  ;
 */

/*
stave
  : voice maybe_options stave_data
    { $$ = {
        element: $1,
        options: $2,
        notes: $3.notes,
        text: $3.text,
        _l: @1.first_line,
        _c: @1.first_column
      }
    }
  | voice maybe_options
    { $$ = {
        element: $1,
        options: $2,
        _l: @1.first_line,
        _c: @1.first_column
      }
    }
  | OPTIONS options {
      $$ = {
        element: "options",
        params: $2,
        _l: @1.first_line,
        _c: @1.first_column
      }
    }
  ;
 */

/*
voice
  : TABSTAVE
  | STAVE
  | VOICE
  ;
 */

/*
stave_data
  : stave_additions
    { $$ = $1 }
  | stave_data stave_additions
    {
      var text = [].concat($1.text, $2.text);
      var notes = [].concat($1.notes, $2.notes);
      var slurs = [].concat($1.slurs, $2.slurs)
      $$ = {text: text, notes: notes, slurs: slurs};
    }
  ;
 */

/*
stave_additions
  : TEXT text
    {$$ = {text: $2, notes: [], slurs: []}}
  | NOTES notes
    {$$ = {notes: $2, text: [], slurs: []}}
  | SLUR maybe_options
    {$$ = {slurs: $2, notes: [], text: []}}
  ;
 */

/*
maybe_options
  :
    { $$ = null }
  | options
    { $$ = $1 }
  ;
 */

/*
options
  : WORD '=' WORD
    { $$ = [{
        key: $1,
        value: $3,
        _l: @1.first_line,
        _c: @1.first_column
      }]
    }
  | options WORD '=' WORD
    { $$ = [].concat($1, [{
        key: $2,
        value: $4,
        _l: @2.first_line,
        _c: @2.first_column
        }])
    }
  ;
 */

/*
text
  : STR
    { $$ = [{text: $1, _l: @1.first_line, _c: @1.first_column}] }
  | text ',' STR
    { $$ = [].concat($1, {text: $3, _l: @3.first_line, _c: @3.first_column}) }
  ;
 */

/*
notes
  : lingo
    { $$ = $1 }
  | notes lingo
    { $$ = [].concat($1, $2)  }
  ;
 */

/*
lingo
  : line
    { $$ = $1 }
  | chord
    { $$ = $1 }
  | time
    { $$ = $1 }
  | bar
    { $$ = [{
        command: "bar",
        type: $1,
        _l: @1.first_line,
        _c: @1.first_column
        }]
    }
  | '['
    { $$ = [{
        command: "open_beam",
        _l: @1.first_line,
        _c: @1.first_column
      }]
    }
  | ']'
    { $$ = [{
        command: "close_beam",
        _l: @1.first_line,
        _c: @1.first_column
      }]
    }
  | tuplets
    { $$ = [{
        command: "tuplet",
        params: $1,
        _l: @1.first_line,
        _c: @1.first_column
      }]
    }
  | annotations
    { $$ = [{
        command: "annotations",
        params: $1,
        _l: @1.first_line,
        _c: @1.first_column
      }]
    }
  | command
    { $$ = [{
        command: "command",
        params: $1,
        _l: @1.first_line,
        _c: @1.first_column
      }]
    }
  | rest
    {
    $$ = [{
        command: "rest",
        params: $1
      }]
    }
  ;
 */

/*
bar
  : '|'         { $$ = 'single' }
  | '=' '|' '|' { $$ = 'double' }
  | '=' '|' '=' { $$ = 'end' }
  | '=' ':' '|' { $$ = 'repeat-end' }
  | '=' '|' ':' { $$ = 'repeat-begin' }
  | '=' ':' ':' { $$ = 'repeat-both' }
  ;
 */

/*
line
  : frets maybe_decorator '/' string
    {
      _.extend(_.last($1), {decorator: $2})
      _.each($1, function(fret) { fret['string'] = $4 })
      $$ = $1
    }
  ;
 */

/*
chord_line
  : line
    { $$ = $1 }
  | chord_line '.' line
    { $$ = [].concat($1, $3) }
  ;
 */

/*
chord
  : '(' chord_line ')' maybe_decorator
    { $$ = [{chord: $2, decorator: $4}] }
  | articulation '(' chord_line ')' maybe_decorator
    { $$ = [{chord: $3, articulation: $1, decorator: $5}] }
  ;
 */

/*
frets
  : NUMBER
    { $$ = [{
        fret: $1,
        _l: @1.first_line,
        _c: @1.first_column}]
    }
  | abc
    { $$ = [{abc: $1, _l: @1.first_line, _c: @1.first_column}]}
  | abc NUMBER '_' NUMBER
    { $$ = [{abc: $1, octave: $2,
             fret: $4, _l: @1.first_line, _c: @1.first_column}]}
  | articulation timed_fret
    { $$ = [_.extend($2, {articulation: $1})] }
  | frets maybe_decorator articulation timed_fret
    {
      _.extend(_.last($1), {decorator: $2})
      _.extend($4, {articulation: $3})
      $1.push($4)
      $$ = $1
    }
  ;
 */

/*
timed_fret
  : ':' time_values maybe_dot ':' NUMBER
    { $$ = {
      time: $2, dot: $3, fret: $5,
      _l: @1.first_line, _c: @1.first_column}}
  | NUMBER
    { $$ = {fret: $1, _l: @1.first_line, _c: @1.first_column} }
  | ':' time_values maybe_dot ':' abc
    { $$ = {time: $2, dot: $3, abc: $5}}
  | ':' time_values maybe_dot ':' abc NUMBER '_' NUMBER
    { $$ = {time: $2, dot: $3, abc: $5, octave: $6, fret: $8}}
  | abc
    { $$ = {abc: $1, _l: @1.first_line, _c: @1.first_column} }
  | abc NUMBER '_' NUMBER
    { $$ = {abc: $1, octave: $2,
            fret: $4, _l: @1.first_line, _c: @1.first_column} }
  ;
 */

/*
time
  : ':' time_values maybe_dot
    { $$ = {time: $2, dot: $3} }
  ;
 */

/*
time_values
  : time_unit maybe_slash { $$ = $1 + $2 }
  ;
 */

/*
time_unit
  : NUMBER  { $$ = $1 }
  | 'w'     { $$ = $1 }  // whole note
  | 'h'     { $$ = $1 }  // half note
  | 'q'     { $$ = $1 }  // quarter note
  ;
 */

/*
maybe_dot
  :         { $$ = false }
  | 'd'     { $$ = true }
  ;
 */

/*
maybe_slash
  :       { $$ = '' }
  | 'S'   { $$ = 's' }
  ;
 */

/*
string
  : NUMBER
    { $$ = $1 } }
  ;
 */

/*
articulation
  : '-' { $$ = '-' }
  | 's' { $$ = 's' }  // slide
  | 't' { $$ = 't' }  // tap
  | 'T' { $$ = 'T' }  // tie
  | 'b' { $$ = 'b' }  // bend
  | 'h' { $$ = 'h' }  // hammer-on
  | 'p' { $$ = 'p' }  // pull-off
  ;
 */

/*
maybe_decorator
  : 'v' { $$ = 'v' }  // vibrato
  | 'V' { $$ = 'V' }  // harsh vibrato
  | 'u' { $$ = 'u' }  // up stroke/bow
  | 'd' { $$ = 'd' }  // down stroke/bow
  |     { $$ = null }
  ;
 */

/*
tuplets
  : '^' NUMBER '^'            { $$ = {tuplet: $2} }
  | '^' NUMBER ',' NUMBER '^' { $$ = {tuplet: $2, notes: $4} }
  ;
 */

/*
annotations
  : '$' annotation_words '$'  { $$ = $2 }
  ;
 */

/*
annotation_words
  : WORD
    { $$ = [$1] }
  | annotation_words ',' WORD
    { $$ = [].concat($1, $3) }
  ;
 */

/*
command
  : '!' COMMAND '!'  { $$ = $2 }
  ;
 */

/*
rest
  : '#' '#'             { $$ = {position: 0} }
  | '#' NUMBER '#'      { $$ = {position: $2} }
  | '#' '-' NUMBER '#'  { $$ = {position: $3 * -1} }
  ;
 */

/*
abc
  : ABC abc_accidental accidental_type
    { $$ = {key: $1, accidental: $2, accidental_type: $3} }
  ;
 */

/*
abc_accidental
  : '#'                 { $$ = "#" }   // sharp
  | '#' '#'             { $$ = "##" }  // double sharp
  | '@'                 { $$ = "b" }   // flat
  | '@' '@'             { $$ = "bb" }  // double flat
  | 'n'                 { $$ = "n" }   // natural
  |
  ;
 */

/*
accidental_type
 :                    { $$ = null; }   // standard
 | '~'                { $$ = "c" }    // cautionary
 ;

*/
@end
