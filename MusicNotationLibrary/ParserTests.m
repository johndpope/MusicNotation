//
//  ParserTests.m
//  VexFlow
//
//  Created by Scott on 6/10/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "ParserTests.h"
#import "VexFlowTestHelpers.h"

#import <CoreParse/CoreParse.h>
#import <CoreParse/NSArray+Functional.h>
#import "TokeniserDelegate.h"
#import "ParserDelegate.h"
#import "Expression.h"

@implementation ParserTests
- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [[self class] basicParser];
    //    [self runTest:@"Basic"  func:@selector(basic:withTitle:)];
}




- (ViewStaffStruct*)setupContextWithSize:(VFUIntSize*)size withParent:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    NSUInteger w = size.width;
    NSUInteger h = size.height;

    w = w != 0 ? w : 350;
    h = h != 0 ? h : 150;

    [VFFont setFont:@" 10pt Arial"];

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h) withParent:parent withTitle:title];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

+ (int)basicParser
{
    CPTokeniser* tokeniser = [[CPTokeniser alloc] init];
    [tokeniser addTokenRecogniser:[CPNumberRecogniser numberRecogniser]];
    [tokeniser addTokenRecogniser:[CPWhiteSpaceRecogniser whiteSpaceRecogniser]];
    [tokeniser
        addTokenRecogniser:[CPQuotedRecogniser quotedRecogniserWithStartQuote:@"/*" endQuote:@"*/" name:@"Comment"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"+"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"-"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"*"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"/"]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@"("]];
    [tokeniser addTokenRecogniser:[CPKeywordRecogniser recogniserForKeyword:@")"]];

    TokeniserDelegate* tDelegate = [[TokeniserDelegate alloc] init];
    [tokeniser setDelegate:tDelegate];

    CPTokenStream* tokenStream = [tokeniser tokenise:@"5 + (2.0 / 5.0 + 9) * 8"];
    NSLog(@"tokenStream: %@", tokenStream);

    // clang-format off
    NSString* expressionGrammar =
        @"Expression ::= term@<Term>   | expr@<Expression> op@<AddOp> term@<Term>;\n"
        @"Term       ::= fact@<Factor> | fact@<Factor>     op@<MulOp> term@<Term>;\n"
        @"Factor     ::= num@'Number'  | '(' expr@<Expression> ')';" @"AddOp      ::= '+' | '-';\n"
        @"MulOp      ::= '*' | '/';\n";
    // clang-format on

    NSError* err = nil;
    CPGrammar* g = [CPGrammar grammarWithStart:@"Expression" backusNaurForm:expressionGrammar error:&err];
    if(nil == g)
    {
        NSLog(@"Error creating grammar:");
        NSLog(@"%@", err);
        return 0;
    }
    CPParser* parser = [CPLALR1Parser parserWithGrammar:g];

    ParserDelegate* pDelegate = [[ParserDelegate alloc] init];
    [parser setDelegate:pDelegate];

    NSLog(@"ANSWER %3.1f", [(Expression*)[parser parse:tokenStream] value]);
    return 1;
}

- (void)basic:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(750, 195) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
//        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

    };
}

- (void)vexTabTokens
{
    // clang-format off
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
    
    / * Commands * /
    <notes>[!]                { this.begin('command'); return "!" }
    <command>[!]              { this.begin('notes'); return "!" }
    <command>[^!]+            return 'COMMAND'
    
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
    
    / * Articulations * /
    <notes>[b]                return 'b'
    <notes>[s]                return 's'
    <notes>[h]                return 'h'
    <notes>[p]                return 'p'
    <notes>[t]                return 't'
    <notes>[T]                return 'T'
    <notes>[-]                return '-'
    <notes>[_]                return '_'
    
    / * Decorators * /
    <notes>[v]                return 'v'
    <notes>[V]                return 'V'
    <notes>[u]                return 'u'
    <notes>[d]                return 'd'
    
    / * Time values * /
    <notes,text>[0-9]+        return 'NUMBER'
    <notes,text>[q]           return 'q'
    <notes,text>[w]           return 'w'
    <notes,text>[h]           return 'h'
    <notes,text>[d]           return 'd'
    
    / * Slash notation * /
    <notes>[S]                return 'S'
    
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
    
    
    */
    // clang-format on
}

- (void)vexTabGrammar
{
    // clang-format off
    /*
     
    e:
      maybe_vextab EOF
        {
          return $1;
        }
      ;

    maybe_vextab
      :
        { $$ = null }
      | vextab
        { $$ = $1 }
      ;

    vextab
      : stave
        { $$ = [$1] }
      | vextab stave
        { $$ = [].concat($1, $2) }
      ;

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

    voice
      : TABSTAVE
      | STAVE
      | VOICE
      ;

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

    stave_additions
      : TEXT text
        {$$ = {text: $2, notes: [], slurs: []}}
      | NOTES notes
        {$$ = {notes: $2, text: [], slurs: []}}
      | SLUR maybe_options
        {$$ = {slurs: $2, notes: [], text: []}}
      ;

    maybe_options
      :
        { $$ = null }
      | options
        { $$ = $1 }
      ;

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

    text
      : STR
        { $$ = [{text: $1, _l: @1.first_line, _c: @1.first_column}] }
      | text ',' STR
        { $$ = [].concat($1, {text: $3, _l: @3.first_line, _c: @3.first_column}) }
      ;

    notes
      : lingo
        { $$ = $1 }
      | notes lingo
        { $$ = [].concat($1, $2)  }
      ;

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

    bar
      : '|'         { $$ = 'single' }
      | '=' '|' '|' { $$ = 'double' }
      | '=' '|' '=' { $$ = 'end' }
      | '=' ':' '|' { $$ = 'repeat-end' }
      | '=' '|' ':' { $$ = 'repeat-begin' }
      | '=' ':' ':' { $$ = 'repeat-both' }
      ;

    line
      : frets maybe_decorator '/' string
        {
          _.extend(_.last($1), {decorator: $2})
          _.each($1, function(fret) { fret['string'] = $4 })
          $$ = $1
        }
      ;

    chord_line
      : line
        { $$ = $1 }
      | chord_line '.' line
        { $$ = [].concat($1, $3) }
      ;

    chord
      : '(' chord_line ')' maybe_decorator
        { $$ = [{chord: $2, decorator: $4}] }
      | articulation '(' chord_line ')' maybe_decorator
        { $$ = [{chord: $3, articulation: $1, decorator: $5}] }
      ;

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

    time
      : ':' time_values maybe_dot
        { $$ = {time: $2, dot: $3} }
      ;

    time_values
      : time_unit maybe_slash { $$ = $1 + $2 }
      ;

    time_unit
      : NUMBER  { $$ = $1 }
      | 'w'     { $$ = $1 }  // whole note
      | 'h'     { $$ = $1 }  // half note
      | 'q'     { $$ = $1 }  // quarter note
      ;

    maybe_dot
      :         { $$ = false }
      | 'd'     { $$ = true }
      ;

    maybe_slash
      :       { $$ = '' }
      | 'S'   { $$ = 's' }
      ;

    string
      : NUMBER
        { $$ = $1 } }
      ;

    articulation
      : '-' { $$ = '-' }
      | 's' { $$ = 's' }  // slide
      | 't' { $$ = 't' }  // tap
      | 'T' { $$ = 'T' }  // tie
      | 'b' { $$ = 'b' }  // bend
      | 'h' { $$ = 'h' }  // hammer-on
      | 'p' { $$ = 'p' }  // pull-off
      ;

    maybe_decorator
      : 'v' { $$ = 'v' }  // vibrato
      | 'V' { $$ = 'V' }  // harsh vibrato
      | 'u' { $$ = 'u' }  // up stroke/bow
      | 'd' { $$ = 'd' }  // down stroke/bow
      |     { $$ = null }
      ;

    tuplets
      : '^' NUMBER '^'            { $$ = {tuplet: $2} }
      | '^' NUMBER ',' NUMBER '^' { $$ = {tuplet: $2, notes: $4} }
      ;

    annotations
      : '$' annotation_words '$'  { $$ = $2 }
      ;

    annotation_words
      : WORD
        { $$ = [$1] }
      | annotation_words ',' WORD
        { $$ = [].concat($1, $3) }
      ;

    command
      : '!' COMMAND '!'  { $$ = $2 }
      ;

    rest
      : '#' '#'             { $$ = {position: 0} }
      | '#' NUMBER '#'      { $$ = {position: $2} }
      | '#' '-' NUMBER '#'  { $$ = {position: $3 * -1} }
      ;

    abc
      : ABC abc_accidental accidental_type
        { $$ = {key: $1, accidental: $2, accidental_type: $3} }
      ;

    abc_accidental
      : '#'                 { $$ = "#" }   // sharp
      | '#' '#'             { $$ = "##" }  // double sharp
      | '@'                 { $$ = "b" }   // flat
      | '@' '@'             { $$ = "bb" }  // double flat
      | 'n'                 { $$ = "n" }   // natural
      |
      ;

    accidental_type
      :                    { $$ = null; }   // standard
      | '~'                { $$ = "c" }    // cautionary
      ;
     
     */
    // clang-format on
}

- (void)setUpView
{
    /*

$ = require('jquery')
Vex = require('vexflow')
Artist = require('./artist.coffee')
VexTab = require('./vextab.coffee')

Vex.Flow.TabDiv = function(sel, options) {
  if (arguments.length > 0) this.init(sel, options);
}

Vex.Flow.TabDiv.SEL = ".vex-tabdiv";
Vex.Flow.TabDiv.ERROR_NOCANVAS =
  "<b>This browser does not support HTML5 Canvas</b><br/>" +
  "Please use a modern browser such as <a href='http://google.com/chrome'>" +
  "Google Chrome</a> or <a href='http://firefox.com'>Firefox</a>.";

Vex.Flow.TabDiv.prototype.init = function(sel, options) {
  this.sel = sel;

  // Grab code and clear tabdiv
  this.code = $(sel).text();
  $(sel).empty();
  if ($(sel).css("position") == "static") {
    $(sel).css("position", "relative");
  }

  // Get tabdiv properties
  this.width = parseInt($(sel).attr("width")) || 400;
  this.height = parseInt($(sel).attr("height")) || 200;
  this.scale = parseFloat($(sel).attr("scale")) || 1.0;

  // If the Raphael.js sources are included, then use Raphael, else
  // resort to HTML5 Canvas.
  if (typeof (Raphael) == "undefined") {
    this.canvas = $('<canvas></canvas>').addClass("vex-canvas");
    $(sel).append(this.canvas);
    this.renderer = new Vex.Flow.Renderer(this.canvas[0],
        Vex.Flow.Renderer.Backends.CANVAS);
  } else {
    this.canvas = $('<div></div>').addClass("vex-canvas");
    $(sel).append(this.canvas);
    this.renderer = new Vex.Flow.Renderer(this.canvas[0],
        Vex.Flow.Renderer.Backends.RAPHAEL);
  }

  this.ctx_sel = $(sel).find(".vex-canvas");
  this.renderer.resize(this.width, this.height);
  this.ctx = this.renderer.getContext();
  this.ctx.setBackgroundFillStyle(this.ctx_sel.css("background-color"));
  this.ctx.scale(this.scale, this.scale);

  // Grab editor properties
  this.editor = $(sel).attr("editor") || "";
  this.show_errors = $(sel).attr("show-errors") || "";
  this.editor_width= $(sel).attr("editor_width") || this.width;
  this.editor_height= $(sel).attr("editor_height") || 200;

  var that = this;
  if (this.editor == "true") {
    this.text_area = $('<textarea></textarea>').addClass("editor").
      val(this.code);
    this.editor_error = $('<div></div>').addClass("editor-error");
    $(sel).append($('<p/>')).append(this.editor_error);
    $(sel).append($('<p/>')).append(this.text_area);
    this.text_area.width(this.editor_width);
    this.text_area.height(this.editor_height);
    this.text_area.keyup(function() {
        if (that.timeoutID) window.clearTimeout(that.timeoutID);
        that.timeoutID =
          window.setTimeout(function() {
            // Draw only if code changed
            if (that.code != that.text_area.val()) {
              that.code = that.text_area.val();
              that.redraw()
            }
          }, 250);
    });
  } if (this.show_errors == "true") {
    this.editor_error = $('<div></div>').addClass("editor-error");
    $(sel).append($('<p/>')).append(this.editor_error);
  }

  // Initialize parser.
  this.artist = new Artist(10, 0, this.width, {scale: this.scale});
  this.parser = new VexTab(this.artist);

  if (Vex.Flow.Player) {
    opts = {};
    if (options) opts.soundfont_url = options.soundfont_url;
    this.player = new Vex.Flow.Player(this.artist, opts);
  }

  this.redraw();
}

Vex.Flow.TabDiv.prototype.redraw = function() {
  var that = this;
  Vex.BM("Total render time: ", function() {
      that.parse(); that.draw();});

  return this;
}

Vex.Flow.TabDiv.prototype.drawInternal = function() {
  if (!this.parser.isValid()) return this;
  return this.artist.draw(this.renderer);
}

Vex.Flow.TabDiv.prototype.parseInternal = function() {
  try {
    this.artist.reset();
    this.parser.reset();
    this.parser.parse(this.code);
    this.editor_error.empty();
  } catch (e) {
    if (this.editor_error) {
      this.editor_error.empty();
      this.editor_error.append(
          $('<div></div>').addClass("text").html(
            "Sucky VexTab: " + e.message));
    }
  }
  return this;
}

Vex.Flow.TabDiv.prototype.parse = function() {
  var that = this;
  Vex.BM("Parse time: ", function() { that.parseInternal(); });
  return this;
}

Vex.Flow.TabDiv.prototype.draw = function() {
  var that = this;
  Vex.BM("Draw time: ", function() { that.drawInternal(); });
  return this;
}

// Automatic initialization.
Vex.Flow.TabDiv.start = function() {
  $(Vex.Flow.TabDiv.SEL).each(function(index) {
      new Vex.Flow.TabDiv(this);
  });
}

$(function() {if (Vex.Flow.TabDiv.SEL) { Vex.Flow.TabDiv.start() }});

module.exports = {
  Div: Vex.Flow.TabDiv,
  VexTab: VexTab,
  Artist: Artist,
  Flow: Vex.Flow
}
     */
}

@end
