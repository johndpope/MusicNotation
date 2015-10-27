//
//  VFText.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFText.h"

//@import AppKit;
#import <CoreText/CoreText.h>
#import "VFFont.h"
#import "VFColor.h"
#import "VFVex.h"
#import "VFPoint.h"
#import "VFBoundingBox.h"

@interface VFText ()
@property (strong, nonatomic) VFFont* font;
@end

static BOOL _dirty;   // update font prop

@implementation VFText
{
    VFColor* _color;
    NSString* _fontName;
    NSUInteger _fontSize;
    BOOL _fontItalic;
    BOOL _fontBold;
}

+ (VFText*)sharedText
{
    static VFText* sharedVFText = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedVFText = [[self alloc] init];
    });
    return sharedVFText;
}

- (instancetype)init
{
    if(self = [super init])
    {
        _dirty = YES;
        self.font = [VFFont fontWithName:@"times" size:12];
        self.color = VFColor.blackColor;
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping
    //        addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" :
    //        @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setColor:(VFColor*)color
{
    _dirty = YES;
    _color = color;
}

- (void)setFontName:(NSString*)fontName
{
    _dirty = YES;
    _fontName = fontName;
}

- (void)setFontSize:(NSUInteger)fontSize
{
    _dirty = YES;
    _fontSize = fontSize;
}

- (void)setFontItalic:(BOOL)fontItalic
{
    _dirty = YES;
    _fontItalic = fontItalic;
}

- (void)setFontBold:(BOOL)fontBold
{
    _dirty = YES;
    _fontBold = fontBold;
}

+ (void)setFont:(VFFont*)font;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

//======================================================================================================================

+ (void)setBold:(BOOL)bold;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

+ (void)setItalic:(BOOL)italic;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

+ (void)setColor:(VFColor*)color;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

+ (void)drawSimpleText:(CGContextRef)ctx atPoint:(VFPoint*)point withText:(NSString*)text;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

+ (void)drawSimpleText:(CGContextRef)ctx withFont:(VFFont*)font atPoint:(VFPoint*)point withText:(NSString*)text;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

+ (void)drawSimpleText:(CGContextRef)ctx atPoint:(VFPoint*)point withHeight:(float)h withText:(NSString*)text;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

// draw text with core text
+ (void)drawSimpleText:(CGContextRef)ctx atPoint:(VFPoint*)point withBounds:(CGRect)bounds withText:(NSString*)text;
{
    // http://www.raywenderlich.com/4147/core-text-tutorial-for-ios-making-a-magazine-app

    CGContextSaveGState(ctx);

    // Flip the coordinate system
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(bounds.origin.x + point.x, bounds.origin.y - point.y, bounds.size.width,
                                         bounds.size.height));

    NSAttributedString* attString = [[NSAttributedString alloc] initWithString:text];

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);

    CTFrameDraw(frame, ctx);

    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);

    CGContextRestoreGState(ctx);
}

// draw text with app kit
// app kit drawing is simpler than core text but offers fewer options
// http://iosfonts.com/
+ (void)drawTextWithContext:(CGContextRef)ctx
                    atPoint:(VFPoint*)point
                 withBounds:(VFBoundingBox*)bounds
                   withText:(NSString*)text
               withFontName:(NSString*)fontName
                   fontSize:(NSUInteger)fontSize;
{
    // write the text at the top
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTTextAlignmentJustified;   // kCTTextAlignmentLeft;//
                                                            // kCTTextAlignmentCenter;

    // http://proquest.safaribooksonline.com.ezproxy.lib.utah.edu/book/programming/mobile/9781449365783/vdot-interface/ch23_html?query=((nsattributedstring))#X2ludGVybmFsX0h0bWxWaWV3P3htbGlkPTk3ODE0NDkzNjU3ODMlMkZjaDIzczAxX2h0bWwmcXVlcnk9KChuc2F0dHJpYnV0ZWRzdHJpbmcpKQ==

    VFFont* font1 = [VFFont fontWithName:fontName size:fontSize];
    //    VFFont *font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25];
    NSMutableAttributedString* title =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:@{
                                                   NSParagraphStyleAttributeName : paragraphStyle,
                                                   NSFontAttributeName : font1,
                                               }];
    [title addAttribute:NSUnderlineStyleAttributeName
                  value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                  range:NSMakeRange(6, 9)];

    //    [title  addAttribute:NSBackgroundColorAttributeName
    //                   value:[VFColor colorWithRed:0.803 green:0.805 blue:0.892
    //                   alpha:0.500]
    //                   range:NSMakeRange(0, title.length)];

    //    title boundingRectWithSize:(NSSize) options:(NSStringDrawingOptions)
    [title drawInRect:bounds.rect];

    //
    //    CGContextSetLineWidth(ctx, 1.0f);
    //    [title drawAtPoint:point.CGPoint];
}

+ (CGSize)measureText:(NSString*)text;
{
    // TODO: incorrect implementation
    return CGSizeMake(text.length, 1);
}

+ (CGSize)measureText:(NSString*)text withFont:(VFFont*)font
{
    // TODO: incorrect implementation
    return CGSizeMake(text.length, 1);
}

@end

@implementation LoremIpsum
{
    NSArray* _words;
}

- (id)init
{
    if((self = [super init]))
    {
        _words = [@"lorem,ipsum,dolor,sit,amet,consectetuer,adipiscing,elit," @"integer,in,mi,a,mauris,"
            @"ornare,sagittis,suspendisse,potenti,suspendisse,dapibus,dignissim," @"dolor,nam,"
            @"sapien,tellus,tempus,et,tempus,ac,tincidunt,in,arcu," @"duis,dictum,proin,magna,"
            @"nulla,pellentesque,non,commodo,et,iaculis,sit,amet,mi,mauris," @"condimentum,massa,"
            @"ut,metus,donec,viverra,sapien,mattis,rutrum," @"tristique,lacus,eros,semper,tellus,"
            @"et,molestie,nisi,sapien,eu,massa,vestibulum,ante,ipsum,primis,in," @"faucibus,orci,"
            @"luctus,et,ultrices,posuere,cubilia,curae;,fusce," @"erat,tortor,mollis,ut,accumsan,"
            @"ut,lacinia,gravida,libero,curabitur,massa,felis,accumsan,feugiat," @"convallis,sit,"
            @"amet,porta,vel,neque,duis,et,ligula,non,elit," @"ultricies,rutrum,suspendisse,"
            @"tempor,quisque,posuere,malesuada,velit,sed,pellentesque,mi,a,purus," @"integer,"
            @"imperdiet,orci,a,eleifend,mollis,velit,nulla,iaculis," @"arcu,eu,rutrum,magna,quam,"
            @"sed,elit,nullam,egestas,integer,interdum,purus,nec,mauris,vestibulum," @"ac,mi,in,"
            @"nunc,suscipit,dapibus,duis,consectetuer,ipsum,et," @"pharetra,sollicitudin,metus,"
            @"turpis,facilisis,magna,vitae,dictum,ligula,nulla,nec,mi,nunc,ante," @"urna,gravida,"
            @"sit,amet,congue,et,accumsan,vitae,magna,praesent," @"luctus,nullam,in,velit,"
            @"praesent,est,curabitur,turpis,class,aptent,taciti,sociosqu,ad,litora," @"torquent,"
            @"per,conubia,nostra,per,inceptos,hymenaeos,cras," @"consectetuer,nibh,in,lacinia,"
            @"ornare,turpis,sem,tempor,massa,sagittis,feugiat,mauris,nibh,non," @"tellus,"
            @"phasellus,mi,fusce,enim,mauris,ultrices,turpis,eu," @"adipiscing,viverra,justo,"
            @"libero,ullamcorper,massa,id,ultrices,velit,est,quis,tortor,quisque," @"condimentum,"
            @"lacus,volutpat,nonummy,accumsan,est,nunc,imperdiet," @"magna,vulputate,aliquet,nisi,"
            @"risus,at,est,aliquam,imperdiet,gravida,tortor,praesent,interdum," @"accumsan,ante,"
            @"vivamus,est,ligula,consequat,sed,pulvinar,eu," @"consequat,vitae,eros,nulla,elit,"
            @"nunc,congue,eget,scelerisque,a,tempor,ac,nisi,morbi,facilisis," @"pellentesque,"
            @"habitant,morbi,tristique,senectus,et,netus,et," @"malesuada,fames,ac,turpis,egestas,"
            @"in,hac,habitasse,platea,dictumst,suspendisse,vel,lorem,ut,ligula," @"tempor,"
            @"consequat,quisque,consectetuer,nisl,eget,elit,proin,quis," @"mauris,ac,orci,"
            @"accumsan,suscipit,sed,ipsum,sed,vel,libero,nec,elit,feugiat,blandit," @"vestibulum,"
            @"purus,nulla,accumsan,et,volutpat,at,pellentesque,vel," @"urna,suspendisse,nonummy,"
            @"aliquam,pulvinar,libero,donec,vulputate,orci,ornare,bibendum," @"condimentum,lorem,"
            @"elit,dignissim,sapien,ut,aliquam,nibh,augue," @"in,turpis,phasellus,ac,eros,"
            @"praesent,luctus,lorem,a,mollis,lacinia,leo,turpis,commodo,sem,in," @"lacinia,mi,"
            @"quam,et,quam,curabitur,a,libero,vel,tellus,mattis," @"imperdiet,in,congue,neque,ut,"
            @"scelerisque,bibendum,libero,lacus,ullamcorper,sapien,quis,aliquet," @"massa,velit,"
            @"vel,orci,fusce,in,nulla,quis,est,cursus,gravida,in," @"nibh,lorem,ipsum,dolor,sit,"
            @"amet,consectetuer,adipiscing,elit,integer,fermentum,pretium,massa," @"morbi,feugiat,"
            @"iaculis,nunc,aenean,aliquam,pretium,orci,cum," @"sociis,natoque,penatibus,et,magnis,"
            @"dis,parturient,montes,nascetur,ridiculus,mus,vivamus,quis,tellus,vel," @"quam,"
            @"varius,bibendum,fusce,est,metus,feugiat,at,porttitor,et," @"cursus,quis,pede,nam,ut,"
            @"augue,nulla,posuere,phasellus,at,dolor,a,enim,cursus,vestibulum,duis," @"id,nisi,"
            @"duis,semper,tellus,ac,nulla,vestibulum,scelerisque," @"lobortis,dolor,aenean,a,"
            @"felis,aliquam,erat,volutpat,donec,a,magna,vitae,pede,sagittis," @"lacinia,cras,"
            @"vestibulum,diam,ut,arcu,mauris,a,nunc,duis," @"sollicitudin,erat,sit,amet,turpis,"
            @"proin,at,libero,eu,diam,lobortis,fermentum,nunc,lorem,turpis," @"imperdiet,id,"
            @"gravida,eget,aliquet,sed,purus,ut,vehicula,laoreet," @"ante,mauris,eu,nunc,sed,sit,"
            @"amet,elit,nec,ipsum,aliquam,egestas,donec,non,nibh,cras,sodales," @"pretium,massa,"
            @"praesent,hendrerit,est,et,risus,vivamus,eget,pede," @"curabitur,tristique,"
            @"scelerisque,dui,nullam,ullamcorper,vivamus,venenatis,velit,eget,enim," @"nunc,eu,"
            @"nunc,eget,felis,malesuada,fermentum,quisque,magna," @"mauris,ligula,felis,luctus,a,"
            @"aliquet,nec,vulputate,eget,magna,quisque,placerat,diam,sed,arcu," @"praesent,"
            @"sollicitudin,aliquam,non,sapien,quisque,id,augue,class," @"aptent,taciti,sociosqu,"
            @"ad,litora,torquent,per,conubia,nostra,per,inceptos,hymenaeos,etiam," @"lacus,lectus,"
            @"mollis,quis,mattis,nec,commodo,facilisis,nibh,sed," @"sodales,sapien,ac,ante,duis,"
            @"eget,lectus,in,nibh,lacinia,auctor,fusce,interdum,lectus,non,dui," @"integer,"
            @"accumsan,quisque,quam,curabitur,scelerisque,imperdiet," @"nisl,suspendisse,potenti,"
            @"nam,massa,leo,iaculis,sed,accumsan,id,ultrices,nec,velit,suspendisse," @"potenti,"
            @"mauris,bibendum,turpis,ac,viverra,sollicitudin,metus," @"massa,interdum,orci,non,"
            @"imperdiet,orci,ante,at,ipsum,etiam,eget,magna,mauris,at,tortor,eu," @"lectus,"
            @"tempor,tincidunt,phasellus,justo,purus,pharetra,ut," @"ultricies,nec,consequat,vel,"
            @"nisi,fusce,vitae,velit,at,libero,sollicitudin,sodales,aenean,mi," @"libero,ultrices,"
            @"id,suscipit,vitae,dapibus,eu,metus,aenean," @"vestibulum,nibh,ac,massa,vivamus,"
            @"vestibulum,libero,vitae,purus,in,hac,habitasse,platea,dictumst," @"curabitur,"
            @"blandit,nunc,non,arcu,ut,nec,nibh,morbi,quis,leo,vel," @"magna,commodo,rhoncus,"
            @"donec,congue,leo,eu,lacus,pellentesque,at,erat,id,mi,consequat," @"congue,praesent,"
            @"a,nisl,ut,diam,interdum,molestie,fusce,suscipit," @"rhoncus,sem,donec,pretium,"
            @"aliquam,molestie,vivamus,et,justo,at,augue,aliquet,dapibus," @"pellentesque,felis,"
            @"morbi,semper,in,venenatis,imperdiet,neque," @"donec,auctor,molestie,augue,nulla,id,"
            @"arcu,sit,amet,dui,lacinia,convallis,proin,tincidunt,proin,a,ante," @"nunc,imperdiet,"
            @"augue,nullam,sit,amet,arcu,quisque,laoreet," @"viverra,felis,lorem,ipsum,dolor,sit,"
            @"amet,consectetuer,adipiscing,elit,in,hac,habitasse,platea,dictumst," @"pellentesque,"
            @"habitant,morbi,tristique,senectus,et,netus,et," @"malesuada,fames,ac,turpis,egestas,"
            @"class,aptent,taciti,sociosqu,ad,litora,torquent,per,conubia,nostra," @"per,inceptos,"
            @"hymenaeos,nullam,nibh,sapien,volutpat,ut,placerat," @"quis,ornare,at,lorem,class,"
            @"aptent,taciti,sociosqu,ad,litora,torquent,per,conubia,nostra,per," @"inceptos,"
            @"hymenaeos,morbi,dictum,massa,id,libero,ut,neque," @"phasellus,tincidunt,nibh,ut,"
            @"tincidunt,lacinia,lacus,nulla,aliquam,mi,a,interdum,dui,augue,non," @"pede,duis,"
            @"nunc,magna,vulputate,a,porta,at,tincidunt,a,nulla,praesent,facilisis,"
            @"suspendisse,sodales,feugiat,purus,cras,et,justo,a,mauris,mollis," @"imperdiet,morbi,"
            @"erat,mi,ultrices,eget,aliquam,elementum,iaculis," @"id,velit,in,scelerisque,enim,"
            @"sit,amet,turpis,sed,aliquam,odio,nonummy,ullamcorper,mollis,lacus," @"nibh,tempor,"
            @"dolor,sit,amet,varius,sem,neque,ac,dui,nunc,et,est," @"eu,massa,eleifend,mollis,"
            @"mauris,aliquet,orci,quis,tellus,ut,mattis,praesent,mollis," @"consectetuer,quam,"
            @"nulla,nulla,nunc,accumsan,nunc,sit,amet," @"scelerisque,porttitor,nibh,pede,lacinia,"
            @"justo,tristique,mattis,purus,eros,non,velit,aenean,sagittis,commodo," @"erat,"
            @"aliquam,id,lacus,morbi,vulputate,vestibulum,elit" componentsSeparatedByString:@","];
    }
    return self;
}

- (NSString*)randomWord;
{
    int randomIndex = random() % [_words count];
    return [_words objectAtIndex:randomIndex];
}

- (NSString*)words:(NSUInteger)count;
{
    if(count == 0)
        return @"";

    NSString* words;
    @autoreleasepool
    {
        NSString* collectedWords = [self randomWord];
        for(NSUInteger i = 0; i < count; i++)
        {
            collectedWords = [collectedWords stringByAppendingString:@" "];
            collectedWords = [collectedWords stringByAppendingString:[self randomWord]];
        }

        words = [collectedWords copy];
    }

    return words;
}

- (NSString*)sentences:(NSUInteger)count;
{
    NSMutableString* result = [NSMutableString string];
    for(NSUInteger i = 0; i < count; i++)
    {
        long numberOfWords = random() % 10 + 10;   // range from 10-20 words
        NSMutableString* sentence = [[self words:numberOfWords] mutableCopy];
        NSString* firstChar = [sentence substringWithRange:NSMakeRange(0, 1)];
        firstChar = [firstChar uppercaseString];
        [sentence replaceCharactersInRange:NSMakeRange(0, 1) withString:firstChar];
        [result appendString:sentence];

        if(i + 1 == count)
        {   // last sentence
            [result appendString:@"."];
        }
        else
        {
            [result appendString:@". "];
        }
    }
    return result;
}

@end

@implementation NSString (Size)

- (CGSize)attributedSizeWithFont:(VFFont*)font
{
    return [self attributedSizeWithFont:font maxWidth:CGFLOAT_MAX];
}

- (CGSize)attributedSizeWithFont:(VFFont*)font maxWidth:(CGFloat)width
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    NSAttributedString* attributedText =
        [[NSAttributedString alloc] initWithString:self
                                        attributes:@{
                                            NSFontAttributeName : font,
                                            NSForegroundColorAttributeName : VFColor.blackColor,
                                            NSParagraphStyleAttributeName : style
                                        }];

#if TARGET_OS_IPHONE
    // TODO: implement size for iphone
    CGRect textRect = CGRectZero;   // [attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    //               options:(NSStringDrawingUsesLineFragmentOrigin)];
#elif TARGET_OS_MAC
    CGRect textRect = [attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                   options:(NSStringDrawingUsesLineFragmentOrigin)];
#endif

    CGSize size = textRect.size;
    size.height = ceilf(size.height);
    size.width = ceilf(size.width);

    return size;
}
@end
