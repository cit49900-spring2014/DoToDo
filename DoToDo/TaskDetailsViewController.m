//
//  TaskDetailsViewController.m
//  DoToDo
//
//  Created by pagr-tech on 4/23/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "TaskDetailsViewController.h"
#import "Category.h"
#import "Task.h"
#import "ToDoStore.h"

@interface TaskDetailsViewController ()

@end

@implementation TaskDetailsViewController
@synthesize lblActive,lblCat,lblDue,lblID,lblName,lblStart,selectedCategory,selectedTask;

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
    lblID.text = [[NSString alloc]initWithFormat:@"%d",[selectedTask remoteID]];
    lblDue.text = [[NSString alloc]initWithFormat:@"%@",[selectedTask dueDate]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
