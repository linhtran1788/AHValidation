//
//  AHRegexRule.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHRegexRule.h"

@implementation AHRegexRule

@synthesize regex;

+ (AHRegexRule *)ruleWithField:(NSString *)name expression:(NSString *)expr {
	return [[self alloc] initWithField:name expression:expr];
}

- (id)initWithField:(NSString *)name expression:(NSString *)expr {
	if((self = [super init])) {
		NSError *error = nil;
		NSInteger regexOptions = NSRegularExpressionCaseInsensitive | NSRegularExpressionAnchorsMatchLines;
		self.regex = [NSRegularExpression regularExpressionWithPattern:expr options:regexOptions error:&error];
		if(error || (self.regex == nil)) {
			return nil;
		}
	}
	
	return self;
}

- (BOOL)passesForValue:(id)value message:(NSString **)message {
	NSRange searchRange = NSMakeRange(0, [value length]);
	NSRange matchedRange = [regex rangeOfFirstMatchInString:value 
													options:0 
													  range:searchRange];
	
	if(matchedRange.length == 0) {
		*message = [NSString stringWithFormat:@"%d does not match the expected format", 
					[self.name capitalizedString]];
		return NO;
	}
	
	return YES;
}

@end
