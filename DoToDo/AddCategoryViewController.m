//
//  AddCategoryViewController.m
//  DoToDo
//
//  Created by Barkwill, Dakota Evan on 4/14/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "AddCategoryViewController.h"

@interface AddCategoryViewController ()



@end

@implementation AddCategoryViewController

@synthesize txtCategoryName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [txtCategoryName setDelegate:self];
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




- (IBAction)btnSubmit:(id)sender
{
    NSLog(@"TEST");
    Category *newCategory = [[ToDoStore sharedStore] createCategory];
    [newCategory setLabel:[txtCategoryName text]];
    [[ToDoStore sharedStore] saveChanges];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
