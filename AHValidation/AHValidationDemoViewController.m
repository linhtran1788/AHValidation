//
//  AHValidationDemoViewController.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationDemoViewController.h"
#import "AHValidation.h"
#import "UITextField+Validation.h"

@implementation AHValidationDemoViewController

@synthesize textField, passwordField, repeatPasswordField, validationMessageLabel, textFields;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.textField addValidationRule:[AHStringLengthRule nonemptyStringRuleWithField:@"username"]];
	[self.textField addValidationRule:[AHStringLengthRule ruleWithField:@"username" maxLength:50]];
	
	[self.passwordField addValidationRule:[AHStringLengthRule nonemptyStringRuleWithField:@"password"]];
	[self.passwordField addValidationRule:[AHStringLengthRule ruleWithField:@"password" maxLength:50]];
	
	[self.repeatPasswordField addValidationRule:[AHObjectEqualityRule ruleWithField:@"Repeat password" 
																	objectToCompare:self.passwordField 
																			keyPath:@"text" 
																	  comparedField:@"password"]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)performValidation {
	NSMutableArray *messages = [NSMutableArray array];
	for(UITextField *field in self.textFields)
		[messages addObjectsFromArray:[field validate]];
	
	self.validationMessageLabel.text = [messages componentsJoinedByString:@"\n"];
}

- (IBAction)validateButtonPressed:(id)sender {
	[self performValidation];
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField {
	[self performValidation];
	[aTextField resignFirstResponder];
	return YES;
}

@end
