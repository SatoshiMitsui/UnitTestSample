//
//  UnitTestSample.m
//  UnitTestSample
//
//  Created by mitsui on 13/01/10.
//  Copyright (c) 2013年 mitsui. All rights reserved.
//

#import "UnitTestSample.h"

@implementation UnitTestSample

@synthesize counter = _counter;

#pragma mark -init-
- (id)init
{
    self = [super init];
    if (self != nil) {
        NSLog(@"Init test target.");
        [self reset];
    }
    return self;
}

#pragma mark -test impl-
- (BOOL)testTrue
{
    return true;
}

- (BOOL)testFalse
{
    return false;
}

#pragma mark -counter impl-
- (void)countUp
{
    _counter++;
}

- (void)countDown
{
    _counter--;
}

- (int)getCurrentVal
{
    return _counter;
}

- (void)reset
{
    _counter = 0;
}

- (void)countWithNumber:(NSInteger)num
{
    for (int i=1; i <= num; i++) {
        NSLog(@"countUp %d times.", i);
        [self countUp];
    }
}

- (void)countByTimeWithInterval:(NSInteger)interval
{
    for (int i=1; i <= interval; i++) {
        [self performBlock:^(void) {
            NSLog(@"countUp %d sec.", i);
            [self countUp];
        }
                afterDelay:[NSNumber numberWithInteger:i]];
    }
}

- (void)test_count
{
    NSLog(@"count");
    [self countUp];
}

#pragma mark -blocks-
- (void)executeBlock__:(void (^)(void))block
{
    block();
    block = nil;
}

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSNumber* )delay
{
    [self performSelector:@selector(executeBlock__:)
               withObject:[block copy]
               afterDelay:[delay doubleValue]];
}
@end
