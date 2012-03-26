//
//  AHStringLengthRule.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationRule.h"

@interface AHStringLengthRule : AHValidationRule

@property(assign) NSInteger minLength; 
@property(assign) NSInteger maxLength;

+ (AHStringLengthRule *)nonemptyStringRuleWithField:(NSString *)name;

+ (AHStringLengthRule *)ruleWithField:(NSString *)name minLength:(NSInteger)minLength;

+ (AHStringLengthRule *)ruleWithField:(NSString *)name maxLength:(NSInteger)maxLength;

+ (AHStringLengthRule *)ruleWithField:(NSString *)name minLength:(NSInteger)minLength 
							maxLength:(NSInteger)maxLength;

- (BOOL)passesForValue:(id)value message:(NSString **)message;

@end
