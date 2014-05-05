//
//  AddTaskViewController.m
//  DoToDo
//
//  Created by Godin, Ryan Daniel on 4/7/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController
@synthesize currentCategory, taskName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [taskName setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"%@", [currentCategory label]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnSubmit:(id)sender
{
    Task *newTask = [[ToDoStore sharedStore] createTask];
    [newTask setLabel:[taskName text]];
    [newTask setCategory:currentCategory];
    [[ToDoStore sharedStore] saveChanges];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
