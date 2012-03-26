//
//  AHObjectEqualityRule.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHObjectEqualityRule.h"
#import "NSObject+Validation.h"

@implementation AHObjectEqualityRule

@synthesize objectToCompare;

+ (void)addRuleToObject:(id)obj1 object:(id)obj2 keyPath:(NSString *)keyPath message:(NSString *)message {
	AHValidationRule *rule = [[self alloc] initWithObject:obj1 object:obj2 keyPath:keyPath message:message];
	[obj1 addValidationRule:rule];
}

- (id)initWithObject:(id)obj1 
			  object:(id)obj2 
			 keyPath:(NSString *)aKeyPath 
			 message:(NSString *)message 
{
	if((self = [super initWithObject:obj1 keyPath:aKeyPath message:message])) {
		objectToCompare = obj2;
	}
	return self;
}

- (BOOL)passes {
	return [[self.object valueForKey:self.keyPath] isEqual:[self.objectToCompare valueForKeyPath:self.keyPath]];
}

@end
