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
	NSDictionary *object = [NSDictionary dictionaryWithObject:@"abc" forKey:@"text"];
	AHValidationRule *rule = [[AHValidationRule alloc] initWithObject:object keyPath:@"text" message:@"Generic validation failed"];
	STAssertTrue([rule passes], @"Generic validation rule should pass for any object.");
}

- (void)testTooShortStringFailsLengthValidation {
	NSDictionary *object = [NSDictionary dictionaryWithObject:@"abc" forKey:@"text"];
	[AHStringLengthRule addRuleToObject:object keyPath:@"text" minLength:[NSNumber numberWithInteger:5] maxLength:nil message:@"Text must be at least 5 characters"];
	STAssertTrue([[object validate] count] > 0, @"String with fewer characters than required should fail validation");
}

- (void)testTooLongStringFailsLengthValidation {
	NSDictionary *object = [NSDictionary dictionaryWithObject:@"abcdefghij" forKey:@"text"];
	[AHStringLengthRule addRuleToObject:object keyPath:@"text" minLength:nil maxLength:[NSNumber numberWithInteger:5] message:@"Text must have 5 or fewer characters"];
	STAssertTrue([[object validate] count] > 0, @"String with more characters than allowed should fail validation");
}

- (void)testNonmatchingStringFailsRegexValidation {
	NSDictionary *object = [NSDictionary dictionaryWithObject:@"abcd" forKey:@"text"];
	[AHRegexRule addRuleToObject:object keyPath:@"text" expression:@"abbc" message:@"Text must match the required format"];
	STAssertTrue([[object validate] count] > 0, @"String not matching regex should fail validation");
}

@end
