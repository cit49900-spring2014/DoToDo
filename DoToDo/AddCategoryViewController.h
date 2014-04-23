//
//  AddCategoryViewController.h
//  DoToDo
//
//  Created by Leadbetter, Lucas W on 4/21/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCategoryViewController : UIViewController <UITextFieldDelegate>{
    IBOutlet UITextField *categoryName;
}

- (IBAction)addCategory:(id)sender;

@end
