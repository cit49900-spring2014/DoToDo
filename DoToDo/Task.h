//
//  Task.h
//  DoToDo
//
//  Created by pagr-tech on 4/14/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Category;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSDate *completedDate;
@property (nonatomic, retain) NSDate *createdDate;
@property (nonatomic, retain) NSDate *dueDate;
@property (nonatomic) int16_t remoteID;
@property (nonatomic) double sortOrder;
@property (nonatomic, retain) Category *category;

@end
