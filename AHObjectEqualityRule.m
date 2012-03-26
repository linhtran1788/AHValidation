//
//  AHObjectEqualityRule.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHObjectEqualityRule.h"

@implementation AHObjectEqualityRule

@synthesize objectToCompare, keyPathToCompare, comparedObjectName;

+ (AHObjectEqualityRule *)ruleWithField:(NSString *)name 
						objectToCompare:(id)obj 
								keyPath:(NSString *)keypath 
						  comparedField:(NSString *)comparedObjectName 
{
	return [[self alloc] initWithField:(NSString *)name 
					   objectToCompare:obj keyPath:keypath 
					comparedObjectName:comparedObjectName];
}

- (id)initWithField:(NSString *)name 
	objectToCompare:(id)obj 
			keyPath:(NSString *)keypath 
 comparedObjectName:(NSString *)comparedName 
{
	if((self = [super initWithField:name])) {
		objectToCompare = obj;
		keyPathToCompare = keypath;
		comparedObjectName = comparedName;
	}
	return self;
}

- (BOOL)passesForValue:(id)value message:(NSString **)message {
	id valueToCompare = [self.objectToCompare valueForKeyPath:self.keyPathToCompare];
	if(![value isEqual:valueToCompare]) {
		*message = [NSString stringWithFormat:@"%@ must be the same as %@", 
					[self.name capitalizedString], self.comparedObjectName];
		return NO;
	}
	
	return YES;
}

@end
