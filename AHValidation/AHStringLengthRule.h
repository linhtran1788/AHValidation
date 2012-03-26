//
//  AHStringLengthRule.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationRule.h"

@interface AHStringLengthRule : AHValidationRule

@property(retain) NSNumber *minLength; 
@property(retain) NSNumber *maxLength;

+ (void)addNonemptyStringRuleToObject:(id)obj keyPath:(NSString *)keyPath message:(NSString *)message;

+ (void)addRuleToObject:(id)obj keyPath:(NSString *)keyPath minLength:(NSNumber *)minLength 
			  maxLength:(NSNumber *)maxLength message:(NSString *)message;

- (BOOL)passes;

@end
