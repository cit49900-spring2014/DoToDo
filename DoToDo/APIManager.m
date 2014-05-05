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
#import "Category.h"
#import "Task.h"
#import "ToDoStore.h"


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
    
}

- (void)fetchCategories
{
    apiRequestString = [NSString stringWithFormat:@"categories"];
    connectionIdentifier = 3;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *categories = [[ToDoStore sharedStore] allCategories];
    
    NSString *currentCategories = @"";
    
    for(Category *category in categories){
        currentCategories = [NSString stringWithFormat:@"%@ids[]=%hd&",currentCategories,[category remoteID]];
    }
    
    NSLog(@"%@",currentCategories);
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@?%@", serviceURL, [prefs objectForKey:@"api_token"], apiRequestString,currentCategories];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (connectionInProgress){
        [connectionInProgress cancel];
    }
    
    connectionInProgress = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    jsonData = [[NSMutableData alloc] init];
}

- (void)fetchTasksByCategory:(Category *)incomingCategory
{
    apiRequestString = [NSString stringWithFormat:@"tasks?catid=%hd",[incomingCategory remoteID]];
    connectionIdentifier = 4;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *tasks = [[ToDoStore sharedStore] tasksForCategory:incomingCategory];
    
    NSString *currentTasks = @"";
    
    for(Task *task in tasks){
        currentTasks = [NSString stringWithFormat:@"%@ids[]=%hd&",currentTasks,[task remoteID]];
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@&%@", serviceURL, [prefs objectForKey:@"api_token"], apiRequestString,currentTasks];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (connectionInProgress){
        [connectionInProgress cancel];
    }
    
    connectionInProgress = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    jsonData = [[NSMutableData alloc] init];
    
    currentCategory = incomingCategory;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSURLCredential *credential = [NSURLCredential credentialWithUser:username password:password persistence:NSURLCredentialPersistenceNone];
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"herokuapp.com" port:0 protocol:@"http" realm:nil authenticationMethod:nil];
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credential forProtectionSpace:protectionSpace];
    
    if ([challenge previousFailureCount] == 0){
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    }else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginInvalid" object:nil];
    }
}



// DELEGATE METHODS FOR NSURLCONNECTION

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jsonData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    
    if (connectionIdentifier == 1){
        if ([[jsonObject valueForKey:@"id"] intValue] != 0){
            NSLog(@"User is Valid");
             
            [prefs setObject:[jsonObject valueForKey:@"id"] forKey:@"user_id"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenValidated" object:nil];
        } else {
            NSLog(@"User is invalid");
            [prefs removeObjectForKey:@"api_token"];
            [prefs removeObjectForKey:@"id"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenInvalidated" object:nil];
        }
        
    }else if (connectionIdentifier == 2){
        NSLog(@"User logged in successfully.");
        [prefs setObject:[jsonObject valueForKey:@"single_access_token"] forKey:@"api_token"];
        [prefs setObject:[jsonObject valueForKey:@"username"] forKey:@"username"];
        
        NSLog(@"%@",[prefs objectForKey:@"api_token"]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginValid" object:nil];
    }else if (connectionIdentifier == 3){
        NSLog(@"Categories");
        NSArray *allCategories = [NSArray arrayWithObject:jsonObject];
        for (NSArray *category in [allCategories objectAtIndex:0]){
            Category *newCategory = [[ToDoStore sharedStore] createCategory];
            [newCategory setLabel:[category valueForKey:@"label"]];
            [newCategory setRemoteID:[[category valueForKey:@"id"] integerValue]];
            [[ToDoStore sharedStore] saveChanges];
            
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addedCategory" object:nil];
    }else if (connectionIdentifier == 4){
        NSArray *allTasks = [NSArray arrayWithObject:jsonObject];
        for (NSArray *task in [allTasks objectAtIndex:0]){
            Task *newTask = [[ToDoStore sharedStore] createTask];
            [newTask setLabel:[task valueForKey:@"label"]];
            [newTask setRemoteID:[[task valueForKey:@"id"] integerValue]];
            [newTask setCategory:currentCategory];
            [[ToDoStore sharedStore] saveChanges];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addedTask" object:nil];
    }
    
}


@end
