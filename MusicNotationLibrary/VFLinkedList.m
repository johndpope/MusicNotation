//
//  VFLinkedList.m
//  VexFlow
//
//  Created by Scott on 4/5/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFLinkedList.h"

@implementation VFNode
- (instancetype)initWithObj:(id)obj; {
    self = [super init];
    if (self) {
        _obj = obj;
    }
    return self;
}
@end

@implementation VFLinkedList

- (id)init; {
    
    if ((self = [super init]) == nil) return nil;
    
    _first = _last = nil;
    size = 0;
    
    return self;
}


+ (id)listWithObject:(id)anObject; {
    VFLinkedList *n = [[VFLinkedList alloc] initWithObject:anObject];
    return n;
}


- (id)initWithObject:(id)anObject {
    
    if ((self = [super init]) == nil) return nil;
    
    VFNode *n = VFNodeMake(anObject, nil, nil);
    
    _first = _last = n;
    size = 1;
    
    return self;
}


- (void)pushBack:(id)anObject {
    
    if (anObject == nil) return;
    
    VFNode *n = VFNodeMake(anObject, nil, _last);
    
    if (size == 0) {
        _first = _last = n;
    } else {
        _last.next = n;
        _last = n;
    }
    
    size++;
    
}


- (id)lastObject {
    return _last ? _last.obj : nil;
}


- (id)firstObject {
    return _first ? _first.obj : nil;
}


- (id)secondLastObject {
    
    if (_last && _last.prev) {
        return _last.prev.obj;
    }
    
    return nil;
    
}


- (VFNode *)firstNode {
    return _first;
}


- (VFNode *)lastNode {
    return _last;
}


- (id)top {
    return [self lastObject];
}


- (void)pushFront:(id)anObject {
    
    if (anObject == nil) return;
    
    VFNode *n = VFNodeMake(anObject, _first, nil);
    
    if (size == 0) {
        _first = _last = n;
        _last = n;
    } else {
        _first.prev = n;
        _first = n;
    }
    
    size++;
    
}


- (void)prependObject:(id)anObject {
    [self pushFront:anObject];
}


- (void)appendObject:(id)anObject {
    [self pushBack:anObject];
}


- (void)insertObject:(id)anObject beforeNode:(VFNode *)node {
    [self insertObject:anObject betweenNode:node.prev andNode:node];
}


- (void)insertObject:(id)anObject afterNode:(VFNode *)node {
    [self insertObject:anObject betweenNode:node andNode:node.next];
}


- (void)insertObject:(id)anObject betweenNode:(VFNode *)previousNode andNode:(VFNode *)nextNode {
    
    if (anObject == nil) return;
    
    VFNode *n = VFNodeMake(anObject, nextNode, previousNode);
    
    if (previousNode) {
        previousNode.next = n;
    } else {
        _first = n;
    }
    
    if (nextNode) {
        nextNode.prev = n;
    } else {
        _last = n;
    }
    
    size++;
    
}


- (void)addObject:(id)anObject {
    [self pushBack:anObject];
}


- (void)pushNodeBack:(VFNode *)n {
    
    if (size == 0) {
        _first = _last = VFNodeMake(n.obj, nil, nil);
    } else {
        _last.next = VFNodeMake(n.obj, nil, _last);
        _last = _last.next;
    }
    
    size++;
    
}


- (void)pushNodeFront:(VFNode *)n {
    
    if (size == 0) {
        _first = _last = VFNodeMake(n.obj, nil, nil);
    } else {
        _first.prev = VFNodeMake(n.obj, _first, nil);
        _first = _first.prev;
    }
    
    size++;
}


// With support for negative indexing!
- (id)objectAtIndex:(const int)inidx {
    
    int idx = inidx;
    
    // they've given us a negative index
    // we just need to convert it positive
    if (inidx < 0) idx = size + inidx;
    
    if (idx >= size || idx < 0) return nil;
    
    VFNode *n = nil;
    
    if (idx > (size / 2)) {
        // loop from the back
        int curridx = size - 1;
        for (n = _last; idx < curridx; --curridx) n = n.prev;
        return n.obj;
    } else {
        // loop from the front
        int curridx = 0;
        for (n = _first; curridx < idx; ++curridx) n = n.next;
        return n.obj;
    }
    
    return nil;
    
}


- (id)popBack {
    
    if (size == 0) return nil;

    id ret = _last;
    [self removeNode:_last];
    return ret;
}


- (id)popFront {
    
    if (size == 0) return nil;
    
    id ret = _first;
    [self removeNode:_first];
    return ret;
}


- (void)removeNode:(VFNode *)aNode {
    
    if (size == 0) return;
    
    if (size == 1) {
        // delete first and only
        _first = _last = nil;
    } else if (aNode.prev == nil) {
        // delete first of many
        _first = _first.next;
        _first.prev = nil;
    } else if (aNode.next == nil) {
        // delete last
        _last = _last.prev;
        _last.next = nil;
    } else {
        // delete in the middle
        VFNode *tmp = aNode.prev;
        tmp.next = aNode.next;
        tmp = aNode.next;
        tmp.prev = aNode.prev;
    }
    
    aNode.obj = nil;
    free((__bridge void *)(aNode));
    size--;
    
    
}


- (BOOL)removeObjectEqualTo:(id)anObject {
    
    VFNode *n = nil;
    
    for (n = _first; n; n=n.next) {
        if (n.obj == anObject) {
            [self removeNode:n];
            return YES;
        }
    }
    
    return NO;
    
}


- (void)removeAllObjects {
    
    VFNode *n = _first;
    
    while (n) {
        VFNode *next = n.next;
        n.obj = nil;
        n = next;
    }
    
    _first = _last = nil;
    size = 0;
}


- (void)dumpList {
    VFNode *n = nil;
    for (n = _first; n; n=n.next) {
        NSLog(@"%p", n);
    }
}


- (void)insertObject:(id)anObject orderedPositionByKey:(NSString *)key ascending:(BOOL)ascending {
    assert(0); // currently not implemented
}


- (int)count  { return size; }
- (int)size   { return size; }
- (int)length { return size; }


- (BOOL)containsObject:(id)anObject {
    
    VFNode *n = nil;
    
    for (n = _first; n; n=n.next) {
        if (n.obj == anObject) return YES;
    }
    
    return NO;
    
}


- (NSArray *)allObjects {
    
    NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:size];
    VFNode *n = nil;
    
    for (n = _first; n; n=n.next) {
        [ret addObject:n.obj];
    }
    
    return [NSArray arrayWithArray:ret];
}


- (NSArray *)allObjectsReverse {
    
    NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:size];
    VFNode *n = nil;
    
    for (n = _last; n; n=n.prev) {
        [ret addObject:n.obj];
    }
    
    return [NSArray arrayWithArray:ret];
}


- (void)dealloc {
    [self removeAllObjects];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"CKLinkedList with %d objects", size];
}


@end

VFNode * VFNodeMake(id obj, VFNode *next, VFNode *prev) {
    VFNode *n = [[VFNode alloc]init];
    n.next = next;
    n.prev = prev;
    return n;
};
