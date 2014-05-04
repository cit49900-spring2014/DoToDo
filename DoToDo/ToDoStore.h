//
//  ToDoStore.h
//  DoToDo
//
//  Created by Barnes, Brittany Renea on 4/7/14.
//  Copyright (c) 2014 Barnes, Brittany Renea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"
#import "Task.h"

@interface ToDoStore : NSObject
{
    NSMutableArray *allTasks;
    NSMutableArray *allCats;
    NSManagedObjectModel *model;
}

@property NSManagedObjectContext *context;

// Class method
+ (ToDoStore *)sharedStore;

// Instance methods
-(NSArray *)allCategories;
-(NSArray *) allTasks:category;
-(Category *)createCategory;
-(Task *)createTask;
- (BOOL)saveChanges;
@end
