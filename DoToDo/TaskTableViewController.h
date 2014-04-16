//
//  TaskTableViewController.h
//  DoToDo
//
//  Created by Barkwill, Dakota Evan on 4/16/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "Category.h"

@interface TaskTableViewController : UITableViewController
@property (nonatomic) Category *currentCategory;
@end
