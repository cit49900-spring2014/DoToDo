//
//  APIManager.h
//  jagweather
//
//  Created by Elliott, Rob on 3/10/14.
//  Copyright (c) 2014 Rob Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"


@interface APIManager : NSObject
{
    NSString *serviceURL;
    NSURLConnection *connectionInProgress;
    NSMutableData *jsonData;
    NSString *apiRequestString;
    NSDictionary *jsonObject;
    NSString *username;
    NSString *password;
    int connectionIdentifier;
    Category *currentCategory;
}


// CLASS METHOD FOR SINGLETON
+ (APIManager *)sharedManager;

- (void)validateAPIToken;
- (void)validateLoginWithUsername:(NSString *)incomingUsername andPassword:(NSString *)incomingPassword;
- (void)fetchCategories;
- (void)fetchTasksByCategory:(Category *)incomingCategory;

@end
