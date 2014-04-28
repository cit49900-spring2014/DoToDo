//
//  DoToDoViewController.m
//  DoToDo
//
//  Created by Elliott, Rob on 4/2/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "DoToDoViewController.h"

@interface DoToDoViewController ()

@end

@implementation DoToDoViewController
@synthesize lblDevice,txtUsername,txtPassword;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [lblDevice setText:@"I'm an iPhone"];
    }
    else
    {
        [lblDevice setText:@"I'm an iPad"];
    }
    
    [[APIManager sharedManager]apiLogin:@"lleadbet" password:@"iphone"];
    [txtUsername setDelegate:self];
    [txtPassword setDelegate:self];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"TextFieldShouldReturn called");
    [textField resignFirstResponder];
    
    return NO;
}

@end
