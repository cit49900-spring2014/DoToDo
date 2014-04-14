//
//  Task.h
//  DoToDo
//
//  Created by pagr-tech on 4/14/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSDate *completedDate;
@property (nonatomic, retain) NSDate *createdDate;
@property (nonatomic, retain) NSDate *dueDate;
@property (nonatomic) int remoteID;
@property (nonatomic) double sortOrder;

@end
