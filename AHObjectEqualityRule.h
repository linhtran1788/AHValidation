//
//  AHObjectEqualityRule.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationRule.h"

@interface AHObjectEqualityRule : AHValidationRule

@property(unsafe_unretained) id objectToCompare;

+ (void)addRuleToObject:(id)obj1 object:(id)obj2 keyPath:(NSString *)keyPath message:(NSString *)message;

@end
