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
#import "Category.h"
#import "ToDoStore.h"
#import "Task.h"

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
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    
    if ([prefs objectForKey:@"api_token"]){
        [[APIManager sharedManager] validateAPIToken];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(api_validated) name:@"tokenValidated" object:nil];
        [nc addObserver:self selector:@selector(api_invalid) name:@"tokenInvalidated" object:nil];
        [txtPassword setHidden:true];
        [txtUsername setHidden:true];
        [txtMessage setText:[NSString stringWithFormat:@"Logged in as:\n %@ \n ...", [prefs objectForKey:@"username"]]];
        [btnLogin setTitle:@"Log Out" forState:UIControlStateNormal];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs objectForKey:@"api_token"]){
        [txtPassword setHidden:true];
        [txtUsername setHidden:true];
        [txtMessage setText:[NSString stringWithFormat:@"Logged in as:\n %@ \n ...", [prefs objectForKey:@"username"]]];
        [btnLogin setTitle:@"Log Out" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if ([prefs valueForKey:@"api_token"]) {
        
        [self logOutUser];
        
    }else{
        [[APIManager sharedManager] validateLoginWithUsername:[txtUsername text] andPassword:[txtPassword text]];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(login_success) name:@"loginValid" object:nil];
        [nc addObserver:self selector:@selector(login_fail) name:@"loginInvalid" object:nil];
    }
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

- (void)logOutUser
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs removeObjectForKey:@"api_token"];
    [prefs removeObjectForKey:@"id"];
    [prefs removeObjectForKey:@"username"];
    
    for (Category *category in [[ToDoStore sharedStore] allCategories]){
        [[[ToDoStore sharedStore] context] deleteObject:category];
    }
    
    for (Task *task in [[ToDoStore sharedStore] allTasks]){
        [[[ToDoStore sharedStore] context] deleteObject:task];
    }
    
    [txtPassword setHidden:false];
    [txtUsername setHidden:false];
    
    [txtMessage setText:@"Logged Out"];
    [btnLogin setTitle:@"Log In" forState:UIControlStateNormal];
}


@end
