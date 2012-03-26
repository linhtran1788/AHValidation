//
//  AHValidationTests.m
//  AHValidationTests
//
//  Created by Warren Moore on 3/24/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationTests.h"
#import "AHValidation.h"

@implementation AHValidationTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBaseValidationRulePassesForBaseObject {
	AHValidationRule *rule = [[AHValidationRule alloc] init];
	AHValidationValue *value = [AHValidationValue valueNamed:@"object" withObject:[[NSObject alloc] init]];
	NSString *message = nil;
	STAssertTrue([rule passesForValue:value message:&message], @"Generic validation rule should pass for any object.");
}

- (void)testTooShortStringFailsLengthValidation {
	AHStringLengthRule *rule = [AHStringLengthRule ruleWithMinimumLength:5];
	AHValidationValue *value = [AHValidationValue valueNamed:@"string" withObject:@"abc"];
	NSString *message = nil;
	STAssertFalse([rule passesForValue:value message:&message], @"String with fewer characters than required should fail validation");
}

- (void)testTooLongStringFailsLengthValidation {
	AHStringLengthRule *rule = [AHStringLengthRule ruleWithMaximumLength:5];
	AHValidationValue *value = [AHValidationValue valueNamed:@"string" withObject:@"abcdefghij"];
	NSString *message = nil;
	STAssertFalse([rule passesForValue:value message:&message], @"String with more characters than allowed should fail validation");
}

- (void)testNonmatchingStringFailsRegexValidation {
	AHRegexRule *rule = [AHRegexRule ruleWithExpression:@"abbc"];
	STAssertNotNil(rule, @"AHRegexRule factory method should return an object");
	AHValidationValue *value = [AHValidationValue valueNamed:@"string" withObject:@"abcd"];
	NSString *message = nil;
	STAssertFalse([rule passesForValue:value message:&message], @"String not matching regex should fail validation");
}

@end
