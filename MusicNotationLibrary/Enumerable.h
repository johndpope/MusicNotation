@import Foundation;

@protocol Enumerable <NSObject>
- (NSEnumerator*)toEnumerator;
@end