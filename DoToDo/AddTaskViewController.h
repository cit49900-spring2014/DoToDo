//
//  AddTaskViewController.h
//  DoToDo
//
//  Created by Godin, Ryan Daniel on 4/7/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Category;

@interface AddTaskViewController : UIViewController <UITextFieldDelegate>{
    IBOutlet UITextField *taskName;
    
    IBOutlet UIDatePicker *taskDate;
    
}

@property (nonatomic) Category *selectedCategory;


- (IBAction)addTask:(id)sender;



@end
