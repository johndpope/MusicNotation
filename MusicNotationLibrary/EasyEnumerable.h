@import Foundation;
#import "Enumerable.h"

@interface EasyEnumerable : NSObject <Enumerable>
+ (EasyEnumerable*)with:(NSEnumerator* (^)())aConvertToEnumerator;
@end