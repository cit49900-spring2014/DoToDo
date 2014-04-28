//
//  Task.h
//  DoToDo
//
//  Created by Eric Roberts on 4/13/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Task : NSManagedObject

@property (nonatomic) NSTimeInterval completedDate;
@property (nonatomic) NSTimeInterval createdDate;
@property (nonatomic) NSTimeInterval dueDate;
@property (nonatomic, retain) NSString * label;
@property (nonatomic) int16_t remoteID;
@property (nonatomic) double sortOrder;
@property (nonatomic, retain) Category *category;

@end
