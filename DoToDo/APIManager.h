//
//  APIManager.h
//  jagweather
//
//  Created by Elliott, Rob on 3/10/14.
//  Copyright (c) 2014 Rob Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface APIManager : NSObject <NSURLConnectionDelegate>
{
    NSString *serviceURL;
    NSURLConnection *connectionInProgress;
    NSMutableData *jsonData;
    NSString *apiRequestString;
    NSDictionary *jsonObject;
    NSString *username;
    NSString *password;
    int connectionIdentifier; 
}



// CLASS METHOD FOR SINGLETON
+ (APIManager *)sharedManager;


- (void)validateAPIToken;
- (void)validateLogin:(NSString *)incomingUsername :(NSString *)incomingPassword;

@end
