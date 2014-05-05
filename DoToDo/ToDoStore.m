//
//  ToDoStore.m
//  DoToDo
//
//  Created by Barnes, Brittany Renea on 4/7/14.
//  Copyright (c) 2014 Barnes, Brittany Renea. All rights reserved.
//

#import "ToDoStore.h"

@implementation ToDoStore
@synthesize context;

+ (ToDoStore *)sharedStore
{
    static ToDoStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}


// INITIALIZERS
- (id)init
{
    self = [super init];
    if (self)
    {
        allCats = [[NSMutableArray alloc] init];
        allTasks = [[NSMutableArray alloc] init];
        
        // CREATE NSMANAGEDOBJECTMODEL (MAP)
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        // CREATE AN NSPERSISTENTSTORECOORDINATOR (GATEKEEPER)
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // CONNECT NS PSC (GATEKEEPER) TO SQLITE DB
        NSString *path = [self itemArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        // CREATE AN NSERROR OBJECT
        NSError *error = nil;
        
        // CONNECT THE NS PSC (GATEKEEPER) TO THE DATABASE FILE
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error])
        {
            [NSException raise:@"Open failed!" format:@"Reason: %@", [error localizedDescription]];
        }
        
        // CREATE THE MANAGED OBJECT CONTEXT (BUCKET)
        context = [[NSManagedObjectContext alloc] init];
        
        // HOOK UP THE BUCKET TO THE PSC (GATEKEEPER)
        [context setPersistentStoreCoordinator:psc];
        
        // POPULATE OUR LOCAL ARRAY WITH ALL ITEMS FROM THE DATABASE
        [self loadAllCategories];
        [self loadAllTasks];
        
        
        
    }
    
    return self;
}

- (NSArray *)allCategories
{
    [self loadAllCategories];
    
    return allCats;
}
- (NSArray *)allTasks
{
    [self loadAllTasks];
    
    return allTasks;
}

- (NSArray *)tasksForCategory:(Category *)incomingCategory;
{
    //GENERATE NSFETCHREQUEST (QUERY)
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //IDENTIFY OUR ENTITY (TABLE) TO PULL FORM
    NSEntityDescription *e = [[model entitiesByName]objectForKey:@"Task"];
    
    //PERFORM PREDICATE
    NSPredicate *categoryFilter = [NSPredicate predicateWithFormat:@"category = %@",incomingCategory];
    
    //ADD THE ENTITY (TABLE) TO THE FETCH (QUERY)
    [request setEntity:e];
    
    [request setPredicate:categoryFilter];
    //CREATE AN ERROR OBJECT
    NSError *error;
    //FETCH THE RESULTS
    NSArray *result = [context executeFetchRequest:request
                                             error:&error];
    
    if(!result)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@",[error localizedDescription]];
    }
    allTasks= [[NSMutableArray alloc]initWithArray:result];
    
    return allTasks;
}


- (Category *)createCategory
{
    
    // Make a new location from a specific entity
    Category *category = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
    
    [allCats addObject:category];
    
    // Return the object back to the caller
    return category;
    
    
}

- (Task *)createTask
{
    
    // Make a new location from a specific entity
    Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:context];
    
    [allTasks addObject:task];
    
    // Return the object back to the caller
    return task;
    
    
}


- (BOOL)saveChanges
{
    NSError *error = nil;
    if (context != nil)
    {
        if ([context hasChanges] && ![context save:&error])
        {
            NSLog(@"Unresolved error");
            abort(); // Don't do this in production.
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return NO;
    }
}



- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    NSString *archivePath = [documentDirectory stringByAppendingPathComponent:@"DoToDo.sqlite"];
    
    return archivePath;
}

- (void)loadAllCategories
{
    
    // GENERATE NSFETCHREQUEST (QUERY)
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // IDENTIFY OUR ENTITY (TABLE) TO PULL FROM
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Category"]; 
    
    // ADD THE ENTITY (TABLE) TO THE FETCH (QUERY)
    [request setEntity:e];
    
    // CREATE AN ERROR OBJECT
    NSError *error;
    
    // DO IT!  FETCH THE RESULTS
    NSArray *result = [context executeFetchRequest:request
                                             error:&error];
    
    if (!result)
    {
        [NSException raise:@"Fetch failed!" format:@"Reason: %@", [error localizedDescription]];
    }
    
    // Is this line correct??!
    allCats = [[NSMutableArray alloc] initWithArray:result];
    
}
- (void)loadAllTasks
{
    
    // GENERATE NSFETCHREQUEST (QUERY)
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // IDENTIFY OUR ENTITY (TABLE) TO PULL FROM
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Task"]; // WeatherLocation is our table name
    
    // ADD THE ENTITY (TABLE) TO THE FETCH (QUERY)
    [request setEntity:e];
    
    // CREATE AN ERROR OBJECT
    NSError *error;
    
    // DO IT!  FETCH THE RESULTS
    NSArray *result = [context executeFetchRequest:request
                                             error:&error];
    
    if (!result)
    {
        [NSException raise:@"Fetch failed!" format:@"Reason: %@", [error localizedDescription]];
    }
    
    // Is this line correct??!
    allTasks = [[NSMutableArray alloc] initWithArray:result];
    
}





@end
