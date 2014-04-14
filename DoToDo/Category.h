//
//  Category.h
//  DoToDo
//
//  Created by pagr-tech on 4/14/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString *label;
@property (nonatomic) int remoteID;
@property (nonatomic) double sortOrder;

@end
