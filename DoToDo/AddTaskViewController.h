//
//  AddTaskViewController.h
//  DoToDo
//
//  Created by Godin, Ryan Daniel on 4/7/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Category;

@interface AddTaskViewController : UIViewController
{
    
   
}
@property (weak, nonatomic) IBOutlet UITextField *taskLabel;
@property (nonatomic, weak) IBOutlet UITextField *taskName;
@property Category *category;
//date
- (IBAction)addTask:(id)sender;



@end
