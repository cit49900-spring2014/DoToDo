//
//  DoToDoViewController.h
//  DoToDo
//
//  Created by Elliott, Rob on 4/2/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoToDoViewController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *txtUsername;
    
    __weak IBOutlet UITextField *txtPassword;
}


@property (weak, nonatomic) IBOutlet UILabel *lblDevice;

- (IBAction)login:(id)sender;
@end
