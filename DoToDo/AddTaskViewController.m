//
//  AddTaskViewController.m
//  DoToDo
//
//  Created by Godin, Ryan Daniel on 4/7/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Category.h"
#import "Task.h"
#import "ToDoStore.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController
@synthesize selectedCategory;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [taskNameField setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

- (IBAction)btnSubmit:(id)sender {
    
    Task *newTask = [[ToDoStore sharedStore]createTask];
    
    [newTask setLabel:[taskNameField text]];
    
    //Insert Date
    
    [newTask setCategory:selectedCategory];
    
    [[ToDoStore sharedStore]saveChanges];
    
    [[self navigationController]popViewControllerAnimated:YES];
    
}
@end
