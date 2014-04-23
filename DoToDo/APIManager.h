//
//  APIManager.h
//  DoToDo
//
//  Created by Leadbetter, Lucas W on 4/23/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Category;
@class Task;

@interface APIManager : NSObject{
    NSString *serviceURL;
    NSURLConnection *connectionInProgress;
    NSMutableData *jsonData;
    NSString *apiRequestString;
    NSDictionary *jsonObject;
    NSString *apiKey;
}

// CLASS METHOD FOR SINGLETON
+ (APIManager *)sharedManager;

-(void)apiLogin:(NSString *)username password:(NSString *)password;
-(void)apiLookupCategories;
-(void)apiLookupTasks;

@end
