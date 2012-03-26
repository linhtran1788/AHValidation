//
//  AHValidationDemoViewController.m
//  AHValidation
//
//  Created by Warren Moore on 3/25/12.
//  Copyright (c) 2012 Auerhaus Development, LLC. All rights reserved.
//

#import "AHValidationDemoViewController.h"
#import "AHValidation.h"

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
	
	[AHStringLengthRule addNonemptyStringRuleToObject:self.textField keyPath:@"text" message:@"Username cannot be empty"];
	[AHStringLengthRule addRuleToObject:self.textField keyPath:@"text" minLength:nil maxLength:[NSNumber numberWithInteger:50] message:@"Username must be fewer than 50 characters"];

	[AHStringLengthRule addNonemptyStringRuleToObject:self.passwordField keyPath:@"text" message:@"Password cannot be empty"];
	[AHStringLengthRule addRuleToObject:self.passwordField keyPath:@"text" minLength:nil maxLength:[NSNumber numberWithInteger:50] message:@"Password must be fewer than 50 characters"];
	
	[AHObjectEqualityRule addRuleToObject:self.repeatPasswordField object:self.passwordField keyPath:@"text" message:@"Repeat password must be the same as password"];
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
