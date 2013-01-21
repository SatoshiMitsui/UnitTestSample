//
//  UnitTestSampleTests.h
//  UnitTestSampleTests
//
//  Created by mitsui on 13/01/10.
//  Copyright (c) 2013年 mitsui. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "UnitTestSample.h"

@interface UnitTestSampleTests : SenTestCase
{
    int _testCounter;
    UnitTestSample* _target;
    id _mock;
}

@property (nonatomic, strong) UnitTestSample* target;
@property (nonatomic, strong) id mock;

@end
