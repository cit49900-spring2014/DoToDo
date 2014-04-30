//
//  APIManager.m
//  jagweather
//
//  Created by Elliott, Rob on 3/10/14.
//  Copyright (c) 2014 Rob Elliott. All rights reserved.
//
//  connectionIdentifier Mappings
//  1 - Validate API Token
//  2 - Validate Login with Username
//  3 - Fetch Categories
//  4 - Fetch Tasks


#import "APIManager.h"


@implementation APIManager

// CLASS METHODS -- TO SET UP SINGLETON FUNCTIONALITY

+ (APIManager *)sharedManager
{
    static APIManager *sharedManager = nil;
    if (!sharedManager)
        sharedManager = [[super allocWithZone:nil] init];
    
    return sharedManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}

// INITIALIZER
- (id)init
{
    self = [super init];
    
    if(self)
    {
        // SET serviceURL
        serviceURL = @"http://pacific-chamber-3420.herokuapp.com/api/v1";
    }
    
    return self;
}


// CUSTOM METHODS
- (void)validateAPIToken
{
    
    NSString *api_token;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    api_token = [prefs objectForKey:@"api_token"];
    
    apiRequestString = [NSString stringWithFormat:@"users/validate_token/%@", api_token];
    connectionIdentifier = 1;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", serviceURL, apiRequestString];
    
    NSLog(@"%@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // Clear out existing connection if there is one
    if (connectionInProgress) {
        NSLog(@"There's a connection in progress.");
        [connectionInProgress cancel];
    }
    
    // Create and initiate the NSURLConnection
    connectionInProgress = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    jsonData = [[NSMutableData alloc] init];
}

- (void)validateLoginWithUsername:(NSString *)incomingUsername andPassword:(NSString *)incomingPassword
{
    username = incomingUsername;
    password = incomingPassword;
    
    apiRequestString = [NSString stringWithFormat:@"users/login"];
    connectionIdentifier = 2;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", serviceURL, apiRequestString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    
    if (connectionInProgress){
        [connectionInProgress cancel];
    }
    
    connectionInProgress = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    jsonData = [[NSMutableData alloc] init];
    
    //START WATCHING NSNOTIFICATIONCENTER
    
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(recievedLoginInformation)
               name:@"LoginValidation"
             object:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSURLCredential *credential = [NSURLCredential credentialWithUser:username password:password persistence:NSURLCredentialPersistenceNone];
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"herokuapp.com" port:0 protocol:@"http" realm:nil authenticationMethod:nil];
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credential forProtectionSpace:protectionSpace];
    
    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
}



// DELEGATE METHODS FOR NSURLCONNECTION

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Connection didReceiveData");
    [jsonData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSLog(@"Connection finished.");
    
    jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    NSLog(@"%@",jsonObject);
    
    if (connectionIdentifier == 1){
        if ([[jsonObject valueForKey:@"id"] intValue] != 0){
            NSLog(@"User is Valid");
             
            [prefs setObject:[jsonObject valueForKey:@"id"] forKey:@"user_id"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenValidated" object:nil];
        } else {
            NSLog(@"User is invalid");
            [prefs removeObjectForKey:@"api_token"];
            [prefs removeObjectForKey:@"id"];
        }
        
    }else if (connectionIdentifier == 2){
        NSLog(@"User logged in successfully.");
        [prefs setObject:[jsonObject valueForKey:@"single_access_token"] forKey:@"api_token"];
        
        NSLog(@"%@",[prefs objectForKey:@"api_token"]);
    }
    
}


@end
