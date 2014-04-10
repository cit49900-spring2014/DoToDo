//
//  Task.h
//  DoToDo
//
//  Created by Adam Fernung on 4/9/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSDate * completedDate;
@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSNumber * remoteID;
@property (nonatomic, retain) NSNumber * sortOrder;
@property (nonatomic, retain) Category *category;

@end
