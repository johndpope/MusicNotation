@import Foundation;

@interface Queue : NSObject
- (BOOL)isEmpty;

- (id)remove;

- (void)add:(id)item;

+ (Queue*)queue;

@end