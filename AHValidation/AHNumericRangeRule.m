//
//  AHNumericRangeRule.m
//  AHValidation
//
//  Created by Warren Moore on 3/26/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHNumericRangeRule.h"
#import "NSObject+Validation.h"

@implementation AHNumericRangeRule

@synthesize lowerBound, upperBound;

+ (void)addRuleToObject:(id)obj keyPath:(NSString *)keyPath lowerBound:(NSNumber *)lowerBound upperBound:(NSNumber *)upperBound message:(NSString *)message {
	AHValidationRule *rule = [[self alloc] initWithObject:obj keyPath:keyPath lowerBound:lowerBound upperBound:upperBound message:message];
	[obj addValidationRule:rule];
}

- (id)initWithObject:(id)obj keyPath:(NSString *)keyPath lowerBound:(NSNumber *)aLowerBound upperBound:(NSNumber *)anUpperBound message:(NSString *)message {
	if((self = [super initWithObject:obj keyPath:keyPath message:message])) {
		lowerBound = aLowerBound;
		upperBound = anUpperBound;
	}
	return self;
}

- (BOOL)passes {
	NSAssert(self.lowerBound != nil || self.upperBound != nil, @"Incorrectly configured numeric range rule");
	
	Float64 value = [[self.object valueForKey:self.keyPath] doubleValue];
	
	if(self.lowerBound != nil && self.upperBound != nil)
		return (value >= [self.lowerBound doubleValue] && value <= [self.upperBound doubleValue]);
	else if(self.lowerBound != nil)
		return (value >= [self.lowerBound doubleValue]);
	else if(self.upperBound != nil)
		return (value <= [self.upperBound doubleValue]);
	else
		return NO;
}

@end
