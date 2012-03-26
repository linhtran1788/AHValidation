//
//  AHRegexRule.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationRule.h"

@interface AHRegexRule : AHValidationRule

@property(strong) NSRegularExpression *regex;

+ (void)addRuleToObject:(id)obj keyPath:(NSString *)keyPath expression:(NSString *)expr message:(NSString *)message;

@end
