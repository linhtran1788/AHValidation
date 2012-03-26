//
//  AHStringLengthRule.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHStringLengthRule.h"
#import "NSObject+Validation.h"

@implementation AHStringLengthRule

@synthesize minLength, maxLength;

+ (void)addNonemptyStringRuleToObject:(id)obj keyPath:(NSString *)keyPath message:(NSString *)message 
{
	AHValidationRule *rule = [[self alloc] initWithObject:obj keyPath:keyPath minLength:[NSNumber numberWithInteger:1] 
												maxLength:nil message:message];
	[obj addValidationRule:rule];
}

+ (void)addRuleToObject:(id)obj keyPath:(NSString *)keyPath minLength:(NSNumber *)minLength 
			  maxLength:(NSNumber *)maxLength message:(NSString *)message
{
	AHValidationRule *rule = [[self alloc] initWithObject:obj keyPath:keyPath minLength:minLength 
												maxLength:maxLength message:message];
	[obj addValidationRule:rule];
}

- (id)initWithObject:(id)obj keyPath:(NSString *)keyPath minLength:(NSNumber *)minimumLength 
		   maxLength:(NSNumber *)maximumLength message:(NSString *)message
{
	if((self = [super initWithObject:obj keyPath:keyPath message:message])) {
		minLength = minimumLength;
		maxLength = maximumLength;
	}
	return self;
}

- (BOOL)passes {
	NSAssert(self.maxLength != nil || self.minLength != nil, @"Invalid configuration for string length rule");

	NSInteger length = [[self.object valueForKey:self.keyPath] length];
	
	if(self.maxLength != nil && self.minLength != nil)
		return (length >= [self.minLength integerValue] && length <= [self.maxLength integerValue]);
	else if(self.maxLength != nil)
		return (length <= [self.maxLength integerValue]);
	else if(self.minLength != nil)
		return (length >= [self.minLength integerValue]);
	else
		return YES;
}

@end
