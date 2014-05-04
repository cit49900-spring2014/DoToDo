//
//  CategoryTableViewController.m
//  DoToDo
//
//  Created by Barkwill, Dakota Evan on 4/14/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "ToDoStore.h"
#import "TaskTableViewController.h"
#import "APIManager.h"

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)reloadCategories
{
    [[self tableView] reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(reloadCategories) name:@"addedCategory" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self tableView] reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return [[[ToDoStore sharedStore] allCategories] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    // Check for reusable cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    // If there is no reusable cell, create one
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    // Set the text on the cell
    Category *cat = [[[ToDoStore sharedStore] allCategories] objectAtIndex:[indexPath row]];
    
    
    [[cell textLabel] setText:[cat label]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
//    
//    TaskTableViewController *taskViewController = [[TaskTableViewController alloc] init];
//    // ...
//    // Pass the selected object to the new view controller.
//    
//    [taskViewController setCurrentCategory:[[[ToDoStore sharedStore] allCategories] objectAtIndex:[indexPath row]]];
    
    //[self.navigationController pushViewController:taskViewController animated:YES];
    [self performSegueWithIdentifier:@"ViewTasks" sender:self];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ViewTasks"])
    {
        NSIndexPath *thisIndexPath = [self.tableView indexPathForSelectedRow];
        
        [[APIManager sharedManager] fetchTasksByCategory:[[[ToDoStore sharedStore] allCategories] objectAtIndex: [thisIndexPath row]]];
        
        [[segue destinationViewController] setCurrentCategory:[[[ToDoStore sharedStore] allCategories] objectAtIndex: [thisIndexPath row]]];
       
    }
}



@end
