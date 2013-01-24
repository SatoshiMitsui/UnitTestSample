//
//  UnitTestSample.h
//  UnitTestSample
//
//  Created by mitsui on 13/01/10.
//  Copyright (c) 2013年 mitsui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitTestSample : NSObject
{
    int _counter;
}
@property (nonatomic, assign)int counter;

- (BOOL)testTrue;
- (BOOL)testFalse;
- (void)countUp;
- (void)countDown;
- (int)getCurrentVal;
- (void)reset;
- (void)countWithNumber:(NSInteger)num;
- (void)countByTimeWithInterval:(NSInteger)interval;
- (void)executeBlock__:(void (^)(void))block;
- (void)performBlock:(void (^)(void))block
          afterDelay:(NSNumber* )delay;
- (void)test_count;
@end
