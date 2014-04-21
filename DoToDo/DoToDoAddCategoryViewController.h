//
//  DoToDoAddCategoryViewController.h
//  DoToDo
//
//  Created by Eric Roberts on 4/14/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoToDoAddCategoryViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *categoryTextField;
    
}

- (IBAction)SubmitButton:(id)sender;

@end
