//
//  AHStringLengthRule.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#define AHValidationDefaultMinimumLength (-1)
#define AHValidationDefaultMaximumLength (NSIntegerMax)

#import "AHStringLengthRule.h"

@implementation AHStringLengthRule

@synthesize minLength, maxLength;

+ (AHStringLengthRule *)nonemptyStringRuleWithField:(NSString *)name {
	return [self ruleWithField:name minLength:1];
}

+ (AHStringLengthRule *)ruleWithField:(NSString *)name 
							minLength:(NSInteger)minLength 
{
	return [[self alloc] initWithField:name 
							 minLength:minLength 
							 maxLength:AHValidationDefaultMaximumLength];
}

+ (AHStringLengthRule *)ruleWithField:(NSString *)name 
							maxLength:(NSInteger)maxLength 
{
	return [[self alloc] initWithField:name 
							 minLength:AHValidationDefaultMinimumLength 
							 maxLength:maxLength];
}

+ (AHStringLengthRule *)ruleWithField:(NSString *)name 
							minLength:(NSInteger)minLength 
							maxLength:(NSInteger)maxLength  
{
	return [[self alloc] initWithField:name 
							 minLength:minLength 
							 maxLength:maxLength];
}

- (id)initWithField:(NSString *)name 
		  minLength:(NSInteger)minimumLength 
		  maxLength:(NSInteger)maximumLength
{
	if((self = [super initWithField:name]))
	{
		minLength = minimumLength;
		maxLength = maximumLength;
	}
	return self;
}

- (BOOL)passesForValue:(id)value message:(NSString **)message {
	NSInteger length = [value length];
	*message = nil;
	
	if(self.maxLength < AHValidationDefaultMaximumLength && 
	   self.minLength > AHValidationDefaultMinimumLength)
	{
		if(length > self.maxLength || length < self.minLength)
		{
			*message = [NSString stringWithFormat:@"%@ must be between %d and %d characters long", 
						[self.name capitalizedString], self.minLength, self.maxLength];
			return NO;
		}
	} 
	else if(self.maxLength < AHValidationDefaultMaximumLength)
	{
		if(length > self.maxLength) 
		{
			*message = [NSString stringWithFormat:@"%@ must be no more than %d characters long", 
						[self.name capitalizedString], self.maxLength];
			return NO;
		}
	}
	else if(self.minLength > AHValidationDefaultMinimumLength)
	{
		if(self.minLength == 1 && length < self.minLength)
		{
			*message = [NSString stringWithFormat:@"%@ cannot be empty", [self.name capitalizedString]];
			return NO;
		}
		else if(length < self.minLength) 
		{
			*message = [NSString stringWithFormat:@"%@ must be at least %d characters long", 
						[self.name capitalizedString], self.minLength];
			return NO;
		}
	}
	else
	{
		NSAssert(self.maxLength < AHValidationDefaultMaximumLength || 
				 self.minLength > AHValidationDefaultMinimumLength, 
				 @"Incorrectly configured validation rule");
		return NO;
	}
	
	return YES;
}

@end
