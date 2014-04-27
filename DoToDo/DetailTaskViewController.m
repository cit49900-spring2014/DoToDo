//
//  DetailTaskViewController.m
//  DoToDo
//
//  Created by Adam Fernung on 4/17/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController
@synthesize detailTask;

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
    
    NSString *date = [NSString stringWithFormat:@"%@",[detailTask dueDate]]; 
    
    [[self navigationItem] setTitle:[detailTask label]];
    [_taskName setText:[detailTask label]];
    [_dueDate setText:date];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
