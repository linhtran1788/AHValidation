//
//  AHNumericRangeRule.h
//  AHValidation
//
//  Created by Warren Moore on 3/26/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationRule.h"

@interface AHNumericRangeRule : AHValidationRule

@property(strong) NSNumber *lowerBound;
@property(strong) NSNumber *upperBound;

+ (void)addRuleToObject:(id)obj keyPath:(NSString *)keyPath lowerBound:(NSNumber *)lowerBound upperBound:(NSNumber *)upperBound message:(NSString *)message;

@end
