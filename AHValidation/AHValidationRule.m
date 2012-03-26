//
//  AHValidationRule.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationRule.h"

@implementation AHValidationRule

@synthesize object, keyPath, failureMessage;

- (id)initWithObject:(id)obj keyPath:(NSString *)aKeyPath message:(NSString *)message {
	if((self = [super init])) {
		object = obj;
		keyPath = aKeyPath;
		failureMessage = message;
	}
	return self;
}

- (BOOL)passes {
	return YES;
}

@end
