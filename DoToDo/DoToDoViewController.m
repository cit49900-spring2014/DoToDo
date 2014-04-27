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
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [lblDevice setText:@"I'm an iPhone"];
    }
    else
    {
        [lblDevice setText:@"I'm an iPad"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"in view will appear");
    [[APIManager sharedManager]validateAPIToken]; 
    
}

- (IBAction)login:(id)sender {
    NSString *username = [NSString stringWithFormat:@"%@",[_username text]];
    NSString *password = [NSString stringWithFormat:@"%@",[_password text]];
    
//    NSLog(@"%@", username);
//    NSLog(@"%@", password); 
    
    [[APIManager sharedManager]validateLogin:username :password];
    
}

// CHECK OUT WHY VIEW FRAME IS SWITCHING BEFORE THE REQUEST IS DONE. LOOK INTO NOTIFICATION CENTER

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField setUserInteractionEnabled:YES];
    [textField resignFirstResponder];
    return YES;
}

@end
