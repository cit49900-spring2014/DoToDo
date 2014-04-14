//
//  DoToDoAddCategoryViewController.m
//  DoToDo
//
//  Created by Eric Roberts on 4/14/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "DoToDoAddCategoryViewController.h"
#import "Category.h"
#import "ToDoStore.h"
@interface DoToDoAddCategoryViewController ()

@end

@implementation DoToDoAddCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [categoryTextField setDelegate:self];
        
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"TextFieldShouldReturn called");
    [textField resignFirstResponder];
    
    return NO;
}


- (IBAction)SubmitButton:(id)sender {
    Category *newCategory = [[ToDoStore sharedStore]createCategory];
    
    [newCategory setLabel:[categoryTextField text]];
    
    [[ToDoStore sharedStore]saveChanges];
    
    [[self navigationController]popViewControllerAnimated:YES];
}


@end
