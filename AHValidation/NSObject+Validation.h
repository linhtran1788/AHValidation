//
//  NSObject+Validation.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidation.h"

@interface NSObject (Validation)

@property(strong) NSMutableArray *validationRules;

- (void)addValidationRule:(AHValidationRule *)rule;

- (void)removeValidationRule:(AHValidationRule *)rule;

- (void)removeAllValidationRules;

- (NSArray *)validate;

@end
