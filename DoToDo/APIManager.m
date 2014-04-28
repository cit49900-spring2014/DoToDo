//
//  APIManager.m
//  jagweather
//
//  Created by Elliott, Rob on 3/10/14.
//  Copyright (c) 2014 Rob Elliott. All rights reserved.
//

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
    
    [prefs setObject:@"0kInlH0g85eUXYWc28ei" forKey:@"api_token"];
    
    api_token = [prefs objectForKey:@"api_token"];
    
    apiRequestString = [NSString stringWithFormat:@"users/validate_token/%@", api_token];
    
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
    NSLog(@"%@", jsonData);
}

- (void)validateLoginWithUsername:(NSString *)incomingUsername andPassword:(NSString *)incomingPassword
{
    username = incomingUsername;
    password = incomingPassword;
    
    apiRequestString = [NSString stringWithFormat:@"users/login"];
    
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
    
    NSLog(@"Connection finished.");
    
    jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    
    NSRange rangeValue = [apiRequestString rangeOfString:@"geolookup" options:NSCaseInsensitiveSearch];
    
   
    
}


@end
