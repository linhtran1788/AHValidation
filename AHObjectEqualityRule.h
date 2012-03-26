//
//  AHObjectEqualityRule.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationRule.h"

@interface AHObjectEqualityRule : AHValidationRule

@property(strong) id objectToCompare;
@property(copy) NSString *keyPathToCompare;
@property(copy) NSString *comparedObjectName;

+ (AHObjectEqualityRule *)ruleWithField:(NSString *)name 
						objectToCompare:(id)obj 
								keyPath:(NSString *)keypath 
						  comparedField:(NSString *)comparedObjectName;

@end
