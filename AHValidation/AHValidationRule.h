//
//  AHValidationRule.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning Ongoing thoughts. I think I'd prefer to initialize each rule with an object/keypath combination as well as a custom failure message.

@interface AHValidationRule : NSObject

@property(copy) NSString *name;

- (id)initWithField:(NSString *)name;

- (BOOL)passesForValue:(id)value message:(NSString **)message;

@end
