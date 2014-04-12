//
//  AddCategoryViewController.m
//  DoToDo
//
//  Created by Adam Fernung on 4/11/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "AddCategoryViewController.h"
#import "ToDoStore.h"


@interface AddCategoryViewController ()

@end

@implementation AddCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addCategory:(id)sender {
    
    Category *newCat = [[ToDoStore sharedStore] createCategory];
    NSString *name = [_categoryName text];
    
    [newCat setLabel:name];
    
    [[ToDoStore sharedStore] saveChanges]; 

}
@end
