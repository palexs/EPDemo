//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.

#import "FakeNotificationCenter.h"

@interface FakeNotificationCenter ()
{
    NSMutableDictionary *_observers;
}
@end

@implementation FakeNotificationCenter

- (id)init
{
    self = [super init];
    if (self) {
        _observers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addObserver:(NSObject *)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    // Add code here
}

- (void)removeObserver:(NSObject *)observer
{
    [[_observers copy] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isEqual:observer]) {
            [_observers removeObjectForKey:key];
        }
    }];
}

- (BOOL)hasObject:(id)observer forNotification:(NSString *)aName
{
    return [[_observers objectForKey:aName] isEqual:observer];
}

@end
