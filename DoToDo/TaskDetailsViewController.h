//
//  TaskDetailsViewController.h
//  DoToDo
//
//  Created by pagr-tech on 4/23/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;
@class Category;
@interface TaskDetailsViewController : UIViewController{
}
@property (weak, nonatomic) IBOutlet UILabel *lblID;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDue;
@property (weak, nonatomic) IBOutlet UILabel *lblStart;
@property (weak, nonatomic) IBOutlet UILabel *lblCat;
@property (weak, nonatomic) IBOutlet UILabel *lblActive;
@property (nonatomic) Task *selectedTask;
@property (nonatomic) Category *selectedCategory;

@end
