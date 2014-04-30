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
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(api_validated) name:@"tokenValidated" object:nil];
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

- (void)api_validated
{
    NSLog(@"Finally got there!");
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ViewTasks"])
    {
        
        [[segue destinationViewController]];
        
    }
}
@end
