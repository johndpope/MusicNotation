//
//  VFLinkedList.h
//  VexFlow
//
//  Created by Scott on 4/5/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;


@interface VFNode : NSObject  {
@private
    id _obj;
    VFNode *_next;
    VFNode *_prev;
};
@property (strong, nonatomic) id obj;
@property (strong, nonatomic) VFNode *next;
@property (strong, nonatomic) VFNode *prev;
- (instancetype)initWithObj:(id)obj;
@end


@interface VFLinkedList : NSObject {
@private
    VFNode *_head;
    VFNode *_first;
    VFNode *_last;
    
    unsigned int size;
}

- (id)init;                                 // init an empty list
+ (id)listWithObject:(id)anObject;          // init the linked list with a single object
- (id)initWithObject:(id)anObject;          // init the linked list with a single object
- (void)pushBack:(id)anObject;              // add an object to back of list
- (void)pushFront:(id)anObject;             // add an object to front of list
- (void)addObject:(id)anObject;             // same as pushBack
- (id)popBack;                              // remove object at end of list (returns it)
- (id)popFront;                             // remove object at front of list (returns it)
- (BOOL)removeObjectEqualTo:(id)anObject;   // removes object equal to anObject, returns (YES) on success
- (void)removeAllObjects;                   // clear out the list
- (void)dumpList;                           // dumps all the pointers in the list to NSLog
- (BOOL)containsObject:(id)anObject;        // (YES) if passed object is in the list, (NO) otherwise
- (int)count;                               // how many objects are stored
- (int)size;                                // how many objects are stored
- (int)length;                              // how many objects are stored
- (void)pushNodeBack:(VFNode *)n;            // adds a node object to the end of the list
- (void)pushNodeFront:(VFNode *)n;           // adds a node object to the beginning of the list
- (void)removeNode:(VFNode *)aNode;          // remove a given node


- (id)objectAtIndex:(const int)idx;
- (id)lastObject;
- (id)firstObject;
- (id)secondLastObject;
- (id)top;

- (VFNode *)firstNode;
- (VFNode *)lastNode;

- (NSArray *)allObjects;
- (NSArray *)allObjectsReverse;


// Insert objects
- (void)insertObject:(id)anObject beforeNode:(VFNode *)node;
- (void)insertObject:(id)anObject afterNode:(VFNode *)node;
- (void)insertObject:(id)anObject betweenNode:(VFNode *)previousNode andNode:(VFNode *)nextNode;

- (void)insertObject:(id)anObject orderedPositionByKey:(NSString *)key ascending:(BOOL)ascending;

// Prepend/append - simple references to keep my sanity
- (void)prependObject:(id)anObject;
- (void)appendObject:(id)anObject;

//- (void)replaceObjectAtIndex:(int) withObject:(id)obj;    // replaces object at a given index with the passed object

@property (readonly) VFNode *first;
@property (readonly) VFNode *last;

@end



VFNode * VFNodeMake(id obj, VFNode *next, VFNode *prev);    // convenience method for creating a LNode