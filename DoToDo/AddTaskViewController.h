//
//  AddTaskViewController.h
//  DoToDo
//
//  Created by Godin, Ryan Daniel on 4/7/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *taskName;
//date
- (IBAction)addTask:(id)sender;



@end
