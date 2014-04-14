//
//  AddCategoryViewController.h
//  DoToDo
//
//  Created by Barkwill, Dakota Evan on 4/14/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoStore.h"
#import "Category.h"

@interface AddCategoryViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtCategoryName;

- (IBAction)btnSubmit:(id)sender;


@end
