//
//  DetailTaskViewController.h
//  DoToDo
//
//  Created by Adam Fernung on 4/17/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface DetailTaskViewController : UIViewController

@property Task *detailTask;
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *categoryID;

@end
