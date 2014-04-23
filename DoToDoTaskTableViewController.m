//
//  DoToDoTaskTableViewController.m
//  dotodo
//
//  Created by Roberts, Eric Preston on 4/16/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "DoToDoTaskTableViewController.h"
#import "Category.h"
#import "Task.h"
#import "ToDoStore.h"

@implementation DoToDoTaskTableViewController
@synthesize selectedCategory;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self tableView]reloadData];
    NSLog(@"%@",[selectedCategory label]);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[ToDoStore sharedStore]TasksForCategory:selectedCategory]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    Task *aTask = [[[ToDoStore sharedStore]TasksForCategory:selectedCategory]objectAtIndex:[indexPath row]];
    
    //Add text to cell
    [[cell textLabel]setText:[aTask label]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"AddTask"]){
        
        [[segue destinationViewController]setSelectedCategory:[self selectedCategory]];
    }
}




@end
