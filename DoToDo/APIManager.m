//
//  APIManager.m
//  DoToDo
//
//  Created by Roberts, Eric Preston on 4/23/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager


//Get the shared instance and create it if neccessary

static APIManager *sharedManager = nil;
+(APIManager *)sharedManager {
    if (sharedManager == nil) {
        sharedManager = [[super allocWithZone:NULL]init];
    }
    return sharedManager;
}

-(id)init
{
    self = [super init];
    
    if(self)
    {
        //set ServiceURL
        serviceURL = @"http://dotodo-rob.herokuapp.com/api/v1/";
        
    }
    return self;
}


-(void)validateAPIToken
{
    NSString *api_token;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    api_token = [prefs objectForKey:@"api_token"];
    
    apiRequestString = [NSString stringWithFormat:@"users/%@/validate_token", api_token];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@.json",serviceURL,apiRequestString];


    NSLog(@"%@", urlString);
}

@end