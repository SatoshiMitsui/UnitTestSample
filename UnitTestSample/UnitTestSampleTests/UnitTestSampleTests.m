//
//  UnitTestSampleTests.m
//  UnitTestSampleTests
//
//  Created by mitsui on 13/01/10.
//  Copyright (c) 2013年 mitsui. All rights reserved.
//

#import "UnitTestSampleTests.h"
#import <OCMock.h>
#import <SenTestingKitAsync.h>

@implementation UnitTestSampleTests

#pragma mark -properties-
@synthesize target = _target;
@synthesize mock = _mock;

#pragma mark -constants-
static NSString* const kAsyncValid = @"1";
static NSString* const kAsyncInvalid = @"2";
static NSString* const kAsyncVerify = @"1";
static NSInteger const kConuntMax = 100;
static float const kDelay = 5.0;
static NSInteger const kInterval = 10;
static NSInteger const kTime = 5;

#pragma mark -default methods-
- (void)setUp
{
    [super setUp];
    NSLog(@"Now \'setUp\'.");
    _target = [[UnitTestSample alloc] init];
    // mock for test
    _mock = [OCMockObject partialMockForObject:_target];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    NSLog(@"Now \'tearDown\'.\n\n");
    _target = nil;
    _mock = nil;
    [super tearDown];
}

#pragma mark -test methods-
- (void)test_Pass
{
    NSLog(@"Normal Test Pass");
    STAssertTrue([_target testTrue], @"Assertion should be raised.");
}
/*
- (void)test_Fail
{
    NSLog(@"Normal Test Fail");
    STAssertTrue([_target testFalse], @"Assertion should be raised.");
}*/

- (void)test_count_max
{
    for (int i=0; i<kConuntMax; i++) {
        [_target countUp];
    }
    STAssertEquals(_target.counter, kConuntMax, @"counter is not correct.");
}

#pragma mark -OCMock test methods-
- (void)test_OCMock_Pass {
    id mock = [OCMockObject mockForClass:NSString.class];
    // setUp stub
    [[[mock stub] andReturn:@"mocktest"] lowercaseString];
    // execute
    NSString *returnValue = [mock lowercaseString];
    // verify
    STAssertEqualObjects(@"mocktest",
                         returnValue,
                         @"Should have returned the expected string.");
}

- (void)test_OCMock_Fail {
    id mock = [OCMockObject mockForClass:NSString.class];
    // setUp stub
    [[[mock stub] andReturn:@"mocktest"] lowercaseString];
    // execute
    NSString *returnValue = [mock lowercaseString];
    // verify
    STAssertEqualObjects(@"mocktest",
                         returnValue,
                         @"Should have returned the expected string.");
}

// OCMock and Async
// --------------------------
// now being explored.
// --------------------------
/*
- (void)test_OCMock_countWithNumber_Pass_Async
{
    // expect
    //[[[_mock expect] andForwardToRealObject] countUp];
    // execute
    [_target countWithNumber:kTime];
    // verify
    //[_mock verify];
    [self performSelector:@selector(verifyMockSelector:)
               withObject:nil
               afterDelay:kInterval];
}

- (void)test_OCMock_countByTime_Pass_Async
{
    // expect
    [[_mock expect] performBlock:OCMOCK_ANY
                      afterDelay:OCMOCK_ANY];
    [[_mock expect] executeBlock__:OCMOCK_ANY];
    [[_mock expect] countUp];
    
    // execute
    [_target countByTimeWithInterval:kInterval];
    
    // verify
    [self performSelector:@selector(verifyMockSelector:)
               withObject:nil
               afterDelay:11];
}*/

- (void)test_mock_default
{
    // expect
    [[_mock expect] countUp];
    // execute
    [_target test_count];
    // verify
    [_mock verify];
}

#pragma -Async test methods-
- (void)test_Selector_Async_FailToWait
{
    [self performSelector:@selector(myOtherSelector:)
               withObject:kAsyncInvalid
               afterDelay:kDelay];
    
    //sleep(6); // this is not worked
}

- (void)test_Selector_Pass_Async
{
    [self performSelector:@selector(myOtherSelector:)
                withObject:kAsyncValid
                afterDelay:kDelay];
}

- (void)test_Selector_Fail_Async
{
    [self performSelector:@selector(myOtherSelector:)
               withObject:kAsyncValid
               afterDelay:kDelay];
}

- (void)test_countByTime_Pass_Async
{
    // execute
    [_target countByTimeWithInterval:kInterval];
    // verify
    [self performSelector:@selector(verifySelector:)
               withObject:nil
               afterDelay:kInterval];
}

#pragma mark -Selector-
- (void)verifySelector:(NSString* )value
{
    STAssertEquals(_target.counter, kInterval, @"Expecting the number is %d", kInterval);
    STSuccess();
}

- (void)verifyMockSelector:(NSString* )value
{
    NSLog(@"verify for async");
    [[_mock expect] countUp];
    [_mock countWithNumber:kTime];
    [_mock verify];
    STSuccess();
}

- (void)myOtherSelector:(NSString* )value
{
    STAssertEqualObjects(value, kAsyncVerify, @"Expecting the number is %@.", kAsyncVerify);
    STSuccess();
}

@end
