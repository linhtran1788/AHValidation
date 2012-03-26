//
//  AHValidationRule.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationRule.h"

@implementation AHValidationRule

@synthesize name;

- (id)initWithField:(NSString *)aName {
	if((self = [super init])) {
		name = aName;
	}
	return self;
}

- (BOOL)passesForValue:(id)value message:(NSString **)message {
	*message = nil;
	return YES;
}

@end
