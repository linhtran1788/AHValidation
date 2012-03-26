//
//  AHRegexRule.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationRule.h"

@interface AHRegexRule : AHValidationRule

// The compiled regular expression object
@property(strong) NSRegularExpression *regex;

+ (AHRegexRule *)ruleWithField:(NSString *)name expression:(NSString *)expr;

@end
