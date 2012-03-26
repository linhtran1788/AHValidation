//
//  AHValidationDemoViewController.h
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHValidationDemoViewController : UIViewController <UITextFieldDelegate>

@property(strong) IBOutlet UITextField *textField;
@property(strong) IBOutlet UITextField *passwordField;
@property(strong) IBOutlet UITextField *repeatPasswordField;
@property(strong) IBOutlet UITextField *numberField;
@property(strong) IBOutlet UILabel *validationMessageLabel;

@property(strong) IBOutletCollection(UITextField) NSArray *textFields;

- (IBAction)validateButtonPressed:(id)sender;

@end
