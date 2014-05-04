//
//  Category.h
//  DoToDo
//
//  Created by Adam Fernung on 4/9/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSNumber * remoteID;
@property (nonatomic, retain) NSNumber * sortOrder;
@property (nonatomic, retain) NSSet *tasks;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end
