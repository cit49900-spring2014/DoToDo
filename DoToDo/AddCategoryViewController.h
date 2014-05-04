//
//  AddCategoryViewController.h
//  DoToDo
//
//  Created by Adam Fernung on 4/11/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCategoryViewController : UIViewController
{
    
    __weak IBOutlet UITextField *categoryName;
}

- (IBAction)addCategory:(id)sender;

@end
