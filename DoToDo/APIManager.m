//
//  APIManager.m
//  DoToDo
//
//  Created by Leadbetter, Lucas W on 4/23/14.
//  Copyright (c) 2014 Elliott, Rob. All rights reserved.
//

#import "APIManager.h"
#import "ToDoStore.h"
#import "Category.h"
#import "Task.h"

@implementation APIManager

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
        
    }
    
    return self;
}

-(void)apiLogin:(NSString *)incUsername password:(NSString *)incPassword{
    password = incPassword;
    username = incUsername;
    NSString *loginURL = @"/users/login";
    NSString *urlString = [NSString stringWithFormat:@"http://dotodo-rob.herokuapp.com/api/v1%@",loginURL];
    NSURL *url = [NSURL URLWithString:urlString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // Clear out existing connection if there is one
    if (connectionInProgress) {
        NSLog(@"There's a connection in progress.");
        [connectionInProgress cancel];
    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(receivedLoginInformation)
               name:@"LoginValidation"
             object:nil];
    
    
    // Create and initiate the NSURLConnection
    connectionInProgress = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    jsonData = [[NSMutableData alloc] init];
    NSLog(@"%@",jsonObject);
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    if([challenge previousFailureCount]==0){
        NSURLCredential *newCredential;
        newCredential = [NSURLCredential credentialWithUser:username
                                                   password:password
                                                persistence:NSURLCredentialPersistenceNone];
        NSURLProtectionSpace *ps = [[NSURLProtectionSpace alloc] initWithHost:@"herokuapp.com" port:0 protocol:@"http" realm:nil authenticationMethod:nil];
        
        
        [[NSURLCredentialStorage sharedCredentialStorage]setDefaultCredential:newCredential forProtectionSpace:ps];
        
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
    }
    
}
-(void)validateAPIToken{
    NSString *api_token;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    api_token = [prefs objectForKey:@"api_token"];
    
}

// CUSTOM METHODS
- (void)apiLookupCategories{
    
    //apiRequestString = [NSString stringWithFormat:@"geolookup/q/%@.json", [incomingLocation postalCode]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", serviceURL, apiKey, apiRequestString];
    
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


- (void)saveCategories{
    // GET THE LOCATION DICTIONARY FROM JSON
    NSDictionary *location = [jsonObject objectForKey:@"location"];
    
    NSLog(@"%@", location);
    
    // UPDATE THE WEATHER LOCATION OBJECT WITH DATA FROM THE LOCATION
    /*
    [incomingLocation setCity:[location objectForKey:@"city"]];
    [incomingLocation setState:[location objectForKey:@"state"]];
    [incomingLocation setCountryName:[location objectForKey:@"country_name"]];
    [incomingLocation setPostalCode:[location objectForKey:@"zip"]];
    double thisLat = [[location objectForKey:@"lat"] doubleValue];
    [incomingLocation setLatitude:thisLat];
    double thisLon = [[location objectForKey:@"lon"] doubleValue];
    [incomingLocation setLongitude:thisLon];
    
    [[WeatherLocationStore sharedStore] saveChanges];
     */
}

-(void)saveSat{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[jsonObject valueForKey:@"single_access_token"]);
    [prefs setObject:[jsonObject valueForKey:@"single_access_token"] forKey:@"api_token"];
    [prefs synchronize];
    NSLog(@"Saved API token");
}

-(void)apiLookupTasks{
    
    //apiRequestString = [NSString stringWithFormat:@"forecast/conditions/q/%@.json",[incomingLocation postalCode]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", serviceURL,apiKey, apiRequestString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //NSLog(@"%@", urlString);
    
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


- (void)saveTasks{
    /*
    NSDictionary *observations = [jsonObject objectForKey:@"current_observation"];
    int16_t tempF = round([[observations objectForKey:@"temp_f"] doubleValue]);
    [incomingLocation setTempF:tempF];
    [incomingLocation setRelativeHumidity:[[observations objectForKey:@"relative_humidity"] intValue]];
    [incomingLocation setWeather:[observations objectForKey:@"weather"]];
    [incomingLocation setWind:[observations objectForKey:@"wind_string"]];
    NSDictionary *forecast = [jsonObject objectForKey:@"forecast"];
    NSDictionary *simpleForecast = [forecast objectForKey:@"simpleforecast"];
    NSArray *forecastDay = [simpleForecast objectForKey:@"forecastday"];
    NSDictionary *currentDay = [forecastDay objectAtIndex:0];
    NSDictionary *high = [currentDay objectForKey:@"high"];
    NSString *highTemp = [high objectForKey:@"fahrenheit"];
    NSDictionary *low = [currentDay objectForKey:@"low"];
    NSString *lowTemp = [low objectForKey:@"fahrenheit"];
    [incomingLocation setHigh:[highTemp intValue]];
    [incomingLocation setLow:[lowTemp intValue]];
    
    // STORE THE CHANGES TO THE DATABASE
    [[WeatherLocationStore sharedStore] saveChanges];
     */
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
    
    //NSString *jsonCheck = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@", jsonCheck);
    
    jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
    NSRange rangeValue = [apiRequestString rangeOfString:@"single_access_token" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.location == !NSNotFound) {
        
        [self saveSat];
        
    }
    
    else {
        
        NSLog(@"%@",[jsonObject objectForKey:@"single_access_token"]);
        NSLog(@"Geolookup data found");
        //[self saveLocation];
        
    }
    
}

@end
