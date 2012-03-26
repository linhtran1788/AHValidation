//
//  AHRegexRule.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHRegexRule.h"
#import "NSObject+Validation.h"

@implementation AHRegexRule

@synthesize regex;

+ (void)addRuleToObject:(id)obj keyPath:(NSString *)keyPath expression:(NSString *)expr message:(NSString *)message
{
	AHValidationRule *rule = [[self alloc] initWithObject:obj keyPath:keyPath expression:expr message:message];
	[obj addValidationRule:rule];
}

- (id)initWithObject:(id)obj 
			 keyPath:(NSString *)keyPath 
		  expression:(NSString *)expr 
			 message:(NSString *)message
{
	if((self = [super initWithObject:obj keyPath:keyPath message:message]))
	{
		NSError *error = nil;
		NSInteger regexOptions = NSRegularExpressionCaseInsensitive | NSRegularExpressionAnchorsMatchLines;
		self.regex = [NSRegularExpression regularExpressionWithPattern:expr 
															   options:regexOptions 
																 error:&error];
		if(error || (self.regex == nil)) {
			return nil;
		}
	}
	
	return self;
}

- (BOOL)passes {
	id value = [self.object valueForKey:self.keyPath];
	NSRange searchRange = NSMakeRange(0, [value length]);
	NSRange matchedRange = [regex rangeOfFirstMatchInString:value 
													options:0 
													  range:searchRange];	
	return (matchedRange.length != 0);
}

@end
