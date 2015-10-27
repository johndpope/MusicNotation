//  OCHamcrest by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2014 hamcrest.org. See LICENSE.txt

#import "HCGenericTestFailureHandler.h"

#import "HCTestFailure.h"

#import "VFVex.h"


@implementation HCGenericTestFailureHandler

- (BOOL)willHandleFailure:(HCTestFailure *)failure
{
    return YES;
}

- (void)executeHandlingOfFailure:(HCTestFailure *)failure;
{
//    NSException *exception = [self createExceptionForFailure:failure];
//    [exception raise];
//    [VFLog LogError:exception.reason];
    
    NSString *failureReason = [NSString stringWithFormat:@"%@:%lu: matcher error: %@",
                               failure.fileName,
                               (unsigned long)failure.lineNumber,
                               failure.reason];
    [VFLog logError:[self fileNameFromPath:failureReason]];
}

- (NSException *)createExceptionForFailure:(HCTestFailure *)failure
{
    NSString *failureReason = [NSString stringWithFormat:@"%@:%lu: matcher error: %@",
                                                         failure.fileName,
                                                         (unsigned long)failure.lineNumber,
                                                         failure.reason];
    return [NSException exceptionWithName:@"Hamcrest Error" reason:failureReason userInfo:nil];
}

- (NSString *)fileNameFromPath:(NSString *)path {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"/(\\w)*.m" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:path options:NSMatchingCompleted range:NSMakeRange(0, [path length])];
//    NSString *modifiedString = [regex stringByReplacingMatchesInString:path options:0 range:NSMakeRange(0, result.range.location) withTemplate:@""];
    NSString *modifiedString = [path substringFromIndex:result.range.location + 1];
    return modifiedString;
    
}

@end
