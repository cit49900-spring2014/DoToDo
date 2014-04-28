//
//  AddTaskViewController.m
//  DoToDo
//
//  Created by Godin, Ryan Daniel on 4/7/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Task.h"
#import "ToDoStore.h"
#import "Category.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController
@synthesize selectedCategory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [taskName setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
}

-(void)dismissKeyboard{
    [taskName resignFirstResponder];
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

-(IBAction)addTask:(id)sender{
    NSString *incName = [taskName text];
    NSDate *incDate = [taskDate date];
    
    Task *newTask = [[ToDoStore sharedStore]createTask];
    NSLog(@"%@", incDate);
    [newTask setDueDate:incDate];
    [newTask setLabel:incName];
    [newTask setCategory:selectedCategory];
    [[ToDoStore sharedStore]saveChanges];
    [[self navigationController]popViewControllerAnimated:YES];
    
}



@end
