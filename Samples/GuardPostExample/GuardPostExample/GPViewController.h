//
//  GPViewController.h
//  GuardPostExample
//
//  Created by Sam Davies on 28/07/2013.
//  Copyright (c) 2013 sammyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *lblValid;
@property (weak, nonatomic) IBOutlet UILabel *lblDidYouMean;
@property (weak, nonatomic) IBOutlet UIButton *btnValidate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actIndicator;

- (IBAction)btnValidatePressed:(id)sender;

@end
