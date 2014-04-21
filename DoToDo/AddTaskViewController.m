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
@synthesize taskDate, taskName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        // Add an observer so this ViewController watches for notifications
        [nc addObserver:self
               selector:@selector(finishedAddingTask)
                   name:NSManagedObjectContextDidSaveNotification
                 object:[[ToDoStore sharedStore] context]
         ];

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

-(IBAction)addTask:(id)sender{
    NSString *incName = [taskName text];
    NSDate *incDate = [taskDate date];
    
    Task *newTask = [[ToDoStore sharedStore]createTask];
    
    [newTask setDueDate:incDate];
    [newTask setLabel:incName];
    
}

-(void)finishedAddingTask{
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.taskName){
        [self.taskName becomeFirstResponder];
    }
return YES;
}
@end
