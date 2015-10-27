//  OCHamcrest by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2014 hamcrest.org. See LICENSE.txt

@import Foundation;


@interface NSInvocation (OCHamcrest)

+ (NSInvocation *)och_invocationWithTarget:(id)target selector:(SEL)selector;
+ (NSInvocation *)och_invocationOnObjectOfType:(Class)aClass selector:(SEL)selector;
- (id)och_invoke;

@end
