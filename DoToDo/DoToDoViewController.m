//
//  DoToDoViewController.m
//  DoToDo
//
//  Created by Elliott, Rob on 4/2/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "DoToDoViewController.h"
#import "APIManager.h"

@interface DoToDoViewController ()

@end

@implementation DoToDoViewController
@synthesize lblDevice;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [txtPassword setDelegate:self];
    [txtUsername setDelegate:self];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[APIManager sharedManager] validateAPIToken];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    NSLog(@"Login Clicked");
    [[APIManager sharedManager] validateLoginWithUsername:[txtUsername text] andPassword:[txtPassword text]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
