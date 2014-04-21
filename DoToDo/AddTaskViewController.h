//
//  AddTaskViewController.h
//  DoToDo
//
//  Created by Godin, Ryan Daniel on 4/7/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"
#import "Task.h"
#import "ToDoStore.h"

@interface AddTaskViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *taskName;

@property (nonatomic, retain) Category *currentCategory;

- (IBAction)btnSubmit:(id)sender;



//date



@end
