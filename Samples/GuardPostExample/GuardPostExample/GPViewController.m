//
//  GPViewController.m
//  GuardPostExample
//
//  Created by Sam Davies on 28/07/2013.
//  Copyright (c) 2013 sammyd. All rights reserved.
//

#import "GPViewController.h"
#import <GPGuardPost.h>

@interface GPViewController ()

@end

@implementation GPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Setup GPGuardPost with the API Key. We pull this in from a plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GPSettings" ofType:@"plist"];
    NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [GPGuardPost setPublicAPIKey:settings[@"MailGunPublicAPIKey"]];
}


- (IBAction)btnValidatePressed:(id)sender {
    // Bin off the keyboard
    [self.emailField resignFirstResponder];
    // Start the spinner
    [self.actIndicator startAnimating];
    
    // Send the email address off for validation
    [GPGuardPost validateAddress:self.emailField.text success:^(BOOL validity, NSString *suggestion) {
        // Hide the spinner
        [self.actIndicator stopAnimating];
        
        // Update the validity label
        if(validity) {
            self.lblValid.text = @"VALID";
            self.lblValid.textColor = [UIColor greenColor];
        } else {
            self.lblValid.text = @"INVALID";
            self.lblValid.textColor = [UIColor redColor];
        }
        self.lblValid.hidden = NO;
        
        // And now check for suggestions:
        if(suggestion) {
            self.lblDidYouMean.text = [NSString stringWithFormat:@"Did you mean %@?", suggestion];
            self.lblDidYouMean.hidden = NO;
        }
    } failure:^(NSError *error) {
        // Hide the spinner
        [self.actIndicator stopAnimating];
        self.lblValid.textColor = [UIColor orangeColor];
        self.lblValid.text = @"Error";
        self.lblValid.hidden = NO;
        self.lblDidYouMean.hidden = YES;
        NSLog(@"There was an error: %@", [error localizedDescription]);
    }];
}

#pragma mark - UITextFieldDelegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Empty the text field
    self.emailField.text = nil;
    // Hide the result fields
    self.lblValid.hidden = YES;
    self.lblDidYouMean.hidden = YES;
}

@end
