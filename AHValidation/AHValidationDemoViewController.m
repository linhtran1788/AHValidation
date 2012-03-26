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

@synthesize textField, passwordField, repeatPasswordField, numberField, validationMessageLabel, textFields;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[AHStringLengthRule addRuleToObject:self.textField 
								keyPath:@"text" 
							  minLength:[NSNumber numberWithInteger:3] 
							  maxLength:[NSNumber numberWithInteger:50] 
								message:@"Username must be between 3 and 50 characters"];
	
	[AHStringLengthRule addRuleToObject:self.passwordField 
								keyPath:@"text" 
							  minLength:[NSNumber numberWithInteger:6] 
							  maxLength:[NSNumber numberWithInteger:50] 
								message:@"Password must be at least 6 characters"];
	
	[AHObjectEqualityRule addRuleToObject:self.repeatPasswordField 
								   object:self.passwordField 
								  keyPath:@"text" 
								  message:@"Repeat password must be the same as password"];
	
	[AHNumericRangeRule addRuleToObject:self.numberField
								keyPath:@"text" 
							 lowerBound:[NSNumber numberWithInt:1] 
							 upperBound:[NSNumber numberWithInt:100] 
								message:@"Number must be between 1 and 100"];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)performValidation {
	NSMutableArray *messages = [NSMutableArray array];
	for(UITextField *field in self.textFields) {
		[messages addObjectsFromArray:[field validate]];
	}
	
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
