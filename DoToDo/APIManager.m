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
        serviceURL = @"http://dotodo-rob.herokuapp.com/api/v1";
        //serviceURL = @"http://localhost:3000/api/v1";
    }
    
    return self;
}


// CUSTOM METHODS
- (void)validateLogin:(NSString *)incomingUsername :(NSString *)incomingPassword
{
    connectionIdentifier = 2;
    username = incomingUsername;
    password = incomingPassword;
    
    NSString *urlString = @"http://dotodo-rob.herokuapp.com/api/v1/users/login";
    apiRequestString = urlString;
    
    NSURL *url = [NSURL URLWithString:urlString];
   
    NSLog(@"%@", urlString);
   
   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
   
   //clear out existing connection if there is one
   if(connectionInProgress)
   {
       [connectionInProgress cancel];
       
   }
   
   //create and init the NSURLConnection
   
   connectionInProgress = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
   
   //set up our NSMutableData
   jsonData = [[NSMutableData alloc]init];
   
    // START WATCHING NSNOTIFICATION CENTER
    
    NSLog(@"%@", jsonData); 
  
}

-(void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    //if previous failure count is > 0
    //post a notification for failed login
    //kill the nsurl connection

    
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCred = [NSURLCredential credentialWithUser:username
                                                              password:password
                                                           persistence:NSURLCredentialPersistenceNone];
        
        NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"herokuapp.com" port:0 protocol:@"http" realm:nil authenticationMethod:nil];
        
        [[NSURLCredentialStorage sharedCredentialStorage]setDefaultCredential:newCred forProtectionSpace:protectionSpace];
        
        [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
        
    
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        [connection cancel];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LoginFailed" object:nil];
  
    }
    
}

-(void)validateAPIToken
{
    connectionIdentifier = 1;
    NSLog(@"validate apit token is getting ran");
    NSString *api_token;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    api_token = [prefs objectForKey:@"api_token"];

    
    apiRequestString = [NSString stringWithFormat:@"users/%@/validate_token", api_token];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", serviceURL,apiRequestString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"%@", urlString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //clear out existing connection if there is one
    if(connectionInProgress)
    {
        [connectionInProgress cancel];
        
    }
    
    //create and init the NSURLConnection
    
    connectionInProgress = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
    //set up our NSMutableData
    jsonData = [[NSMutableData alloc]init];
    
}


// DELEGATE METHODS FOR NSURLCONNECTION

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"Connection didReceiveData");
    [jsonData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"Connection finished.");
    
    jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    if(connectionIdentifier == 1)
    {
        // DO THE VALIDATE API TOKEN STUFF HERE
        
        NSLog(@"%@", jsonObject);
        
        NSString *incoming_user_id;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        incoming_user_id = [jsonObject objectForKey:@"id"];
        
        if (incoming_user_id == 0)
        {
            [prefs removeObjectForKey:@"api_token"];
        }
        
        //post a notification that we have received token validation
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"TokenValidation" object:nil];
    }
    
    else if (connectionIdentifier == 2) {
        
      //SET THE DEFAULT DATA
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:[jsonObject objectForKey:@"single_access_token"] forKey:@"api_token"];

            [[NSNotificationCenter defaultCenter]postNotificationName:@"LoginSucceeded" object:nil];

        
            NSLog(@"%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"api_token"]);
        
    }




}




@end
