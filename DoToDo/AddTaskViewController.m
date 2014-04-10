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

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"add task view controller end up loading...sweet"); 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTask:(id)sender {
    
    Task *newTask = [[ToDoStore sharedStore]createTask];
    
    [newTask setLabel:@"some boring task"];
    
    [[ToDoStore sharedStore]saveChanges]; 
    
    
    NSLog(@"you added a task");
}
@end
