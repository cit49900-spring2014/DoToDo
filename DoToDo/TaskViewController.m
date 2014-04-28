//
//  TaskViewController.m
//  DoToDo
//
//  Created by pagr-tech on 4/23/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "TaskViewController.h"
#import "ToDoStore.h"
#import "Category.h"
#import "Task.h"
#import "TaskDetailsViewController.h"

@implementation TaskViewController
@synthesize selectedCategory;

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self tableView]reloadData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[ToDoStore sharedStore]categoryTasks:selectedCategory]count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    Task *ct = [[[ToDoStore sharedStore]categoryTasks:selectedCategory]objectAtIndex:[indexPath row]];
    
    //Add text to cell
    [[cell textLabel]setText:[ct label]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"AddTask"]){
        
        [[segue destinationViewController]setSelectedCategory:[self selectedCategory]];
    }
    if ([[segue identifier]isEqualToString:@"TaskDetails"]) {
        NSIndexPath *thisIndexPath = [self.tableView indexPathForSelectedRow];
        Task *ftask = [[[ToDoStore sharedStore]categoryTasks:[self selectedCategory]]objectAtIndex:[thisIndexPath row]];
        [[segue destinationViewController]setSelectedCategory:[self selectedCategory]];
        [[segue destinationViewController]setSelectedTask:ftask];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"TaskDetails" sender:self];
}

@end
