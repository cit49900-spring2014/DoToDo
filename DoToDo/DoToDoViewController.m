//
//  DoToDoViewController.m
//  DoToDo
//
//  Created by Elliott, Rob on 4/2/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "DoToDoViewController.h"
#import "CategoryTableViewController.h"
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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    
    if ([prefs objectForKey:@"api_token"]){
        [[APIManager sharedManager] validateAPIToken];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(api_validated) name:@"tokenValidated" object:nil];
        [nc addObserver:self selector:@selector(api_invalid) name:@"tokenInvalidated" object:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [[APIManager sharedManager] validateLoginWithUsername:[txtUsername text] andPassword:[txtPassword text]];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(login_success) name:@"loginValid" object:nil];
    [nc addObserver:self selector:@selector(login_fail) name:@"loginInvalid" object:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)api_validated
{
    [[APIManager sharedManager] fetchCategories];
    [self performSegueWithIdentifier:@"CategoriesVC" sender:[NSNotificationCenter defaultCenter]];
    
}

- (void)login_success
{
    [[APIManager sharedManager] fetchCategories];
    [self performSegueWithIdentifier:@"CategoriesVC" sender:[NSNotificationCenter defaultCenter]];
}

- (void)login_fail
{
    [txtMessage setText:@"Login unsuccessful.\nPlease try again."];
}

- (void)api_invalid
{
    [txtMessage setText:@"You have been logged out.\nPlease login to continue."];
}


@end
