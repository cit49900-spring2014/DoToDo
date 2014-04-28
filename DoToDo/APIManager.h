//
//  APIManager.h
//  DoToDo
//
//  Created by Roberts, Eric Preston on 4/23/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface APIManager : NSObject
{
    NSString *serviceURL;
    NSURLConnection *connectionInProgress;
    NSMutableData *jsonData;
    NSString *apiRequestString;
    NSDictionary *jsonObject;
    
}


//CLASS METHOD FOR SINGLETON
+(id)sharedManager;

-(void)validateAPIToken;
-(void)validateLogin:(NSString *)incomingUserName
                    :(NSString *)incomingPassword;




@end
