//
//  CategoryViewController.m
//  DoToDo
//
//  Created by Leadbetter, Lucas W on 4/21/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "CategoryViewController.h"
#import "ToDoStore.h"
#import "Category.h"
#import "TaskViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self tableView]reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[ToDoStore sharedStore] allCategories] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    // Configure the cell...
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    Category *cat = [[[ToDoStore sharedStore]allCategories]objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[cat label]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ViewTasks" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"ViewTasks"]){
            NSIndexPath *thisIndexPath = [self.tableView indexPathForSelectedRow];
        
            Category *fcat = [[[ToDoStore sharedStore]allCategories]objectAtIndex:[thisIndexPath row]];
        
            [[segue destinationViewController] setSelectedCategory:fcat];
    }
}

@end
