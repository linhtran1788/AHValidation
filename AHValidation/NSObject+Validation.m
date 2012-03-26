//
//  NSObject+Validation.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "NSObject+Validation.h"
#import <objc/runtime.h>

static char * const AHValidationRulesArrayKey = "AHValidationRulesArray";

@implementation NSObject (Validation)

- (NSMutableArray *)validationRules {
	NSMutableArray *rules = objc_getAssociatedObject(self, AHValidationRulesArrayKey);
	if(rules == nil)
		self.validationRules = rules = [NSMutableArray array];
	return rules;
}

- (void)setValidationRules:(NSMutableArray *)validationRules {
	objc_setAssociatedObject(self, AHValidationRulesArrayKey, 
							 validationRules, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addValidationRule:(AHValidationRule *)rule {
	if(self.validationRules == nil)
		self.validationRules = [NSMutableArray array];
	[self.validationRules addObject:rule];
}

- (void)removeValidationRule:(AHValidationRule *)rule {
	[self.validationRules removeObject:rule];
}

- (void)removeAllValidationRules {
	[self.validationRules removeAllObjects];
}

- (NSArray *)validate {
	NSMutableArray *messages = [NSMutableArray array];
	for(AHValidationRule *rule in self.validationRules) {
		if(![rule passes])
			[messages addObject:rule.failureMessage];
	}
	return messages;
}

@end
