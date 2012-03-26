//
//  AHValidationRule.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHValidationRule : NSObject

@property(unsafe_unretained) id object;
@property(copy) NSString *keyPath;
@property(copy) NSString *failureMessage;

- (id)initWithObject:(id)obj keyPath:(NSString *)keyPath message:(NSString *)message;

- (BOOL)passes;

@end
