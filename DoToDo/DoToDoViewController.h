//
//  DoToDoViewController.h
//  DoToDo
//
//  Created by Elliott, Rob on 4/2/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DoToDoViewController : UIViewController
{
    
    __weak IBOutlet UITextField *username;
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UILabel *lblfail;
}


@property (weak, nonatomic) IBOutlet UILabel *lblDevice;
- (IBAction)login:(id)sender;
-(void)receivedTokenValidation;
-(void)loginFailed;
-(void)loginSucceed; 

@end
