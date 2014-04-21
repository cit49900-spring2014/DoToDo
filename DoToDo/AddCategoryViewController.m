//
//  AddCategoryViewController.m
//  DoToDo
//
//  Created by Leadbetter, Lucas W on 4/21/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "AddCategoryViewController.h"
#import "Category.h"
#import "ToDoStore.h"

@interface AddCategoryViewController ()

@end

@implementation AddCategoryViewController
@synthesize categoryName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        // Add an observer so this ViewController watches for notifications
        [nc addObserver:self
               selector:@selector(finishedAddingCategory)
                   name:NSManagedObjectContextDidSaveNotification
                 object:[[ToDoStore sharedStore] context]
         ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [categoryName setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addCategory:(id)sender{
    NSString *incName = [categoryName text];
    
    Category *nc = [[ToDoStore sharedStore]createCategory];
    
    [nc setLabel:incName];
}

-(void)finishedAddingCategory{
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [categoryName resignFirstResponder];
    return YES;
}
@end
