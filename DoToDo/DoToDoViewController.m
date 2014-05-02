//
//  DoToDoViewController.m
//  DoToDo
//
//  Created by Elliott, Rob on 4/2/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "DoToDoViewController.h"
#import "APIManager.h"
#import "CategorysViewController.h"

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

    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    //if there's an api token in user defaults
    
    if([prefs objectForKey:@"api_token"])
    {
        //executle validation to validate it
        [[APIManager sharedManager]validateAPIToken];

        //register as an observer
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(receivedTokenValidation)
                   name:@"TokenValidation"
                 object:nil];
    }else{
        
        //user is going to enter username /password (stay on this screen)
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(loginFailed)
                   name:@"LoginFailed"
                 object:nil];
        
        NSNotificationCenter *nc2 = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(loginSucceed)
                   name:@"LoginSucceeded"
                 object:nil];

    }
    
    
}

- (IBAction)login:(id)sender {
    NSString *username1 = [NSString stringWithFormat:@"%@",[username text]];
    NSString *password1 = [NSString stringWithFormat:@"%@",[password text]];
    
    NSLog(@"%@", username1);
    NSLog(@"%@", password1);
   
    [[APIManager sharedManager] validateLogin:username1 :password1];
    
}

-(void)loginSucceed
{
    NSLog(@"in login succeeded");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if ([prefs objectForKey:@"api_token"]) {
//        CategorysViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
//        [self.navigationController pushViewController:newVC animated:YES];
        
        [self performSegueWithIdentifier:@"loginSegue" sender:self]; 
    }
    
}

-(void)loginFailed
{
    [lblfail setHidden:NO];
    
}

-(void)receivedTokenValidation
{
    NSLog(@"in TokenValidation function");
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

       if([prefs objectForKey:@"api_token"])
       {
//           CategorysViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
//           [self.navigationController pushViewController:newVC animated:YES];
           
           [self performSegueWithIdentifier:@"loginSegue" sender:self]; 
           
       }
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField setUserInteractionEnabled:YES];
    [textField resignFirstResponder];
    return YES;
}



@end
