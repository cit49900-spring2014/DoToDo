//
//  ToDoStore.m
//  DoToDo
//
//  Created by Barnes, Brittany Renea on 4/7/14.
//  Copyright (c) 2014 Barnes, Brittany Renea. All rights reserved.
//

#import "ToDoStore.h"
#import "Task.h"
#import "Category.h"

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

- (id)init
{
    self = [super init];
    if (self)
    {
        allCats = [[NSMutableArray alloc] init];
        allTasks = [[NSMutableArray alloc]init];
        
        //read in the data model
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        //create an NSpersistentStoreCoordinator(Gatekeeper)
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        //Connect NS PSC to SQLITE DB
        NSString *path = [self itemArchivePath];
        
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        // CREATE AN NSERROR OBJECT
        
        NSError *error = nil;
        
        //CONNECT THE NS PSC TO THE DATABASE FILE
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error])
        {
            [NSException raise:@"Open failed!" format:@"Reason: %@",[error localizedDescription]];
        }
        
        //CREATE THE MANAGED OBJECT CONTEXT (BUCKET)
        context = [[NSManagedObjectContext alloc]init];
        //HOOK UP THE BUCKET TO THE PSC (GATEKEEPER)
        [context setPersistentStoreCoordinator:psc];
        //POPULATE OUR LOCAL ARRAY WITH ALL ITEMS FROM THE DATABASE
        [self allCategories];
        
    }
    
    return self;
}

-(NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    NSString *archivePath = [documentDirectory stringByAppendingPathComponent:@"DoToDo.sqlite"];
    
    return archivePath;
}

-(NSArray *)allCategories
{
    //GENERATE NSFETCHREQUEST (QUERY)
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //IDENTIFY OUR ENTITY (TABLE) TO PULL FORM
    NSEntityDescription *e = [[model entitiesByName]objectForKey:@"Category"];
    
    //ADD THE ENTITY (TABLE) TO THE FETCH (QUERY)
    [request setEntity:e];
    //CREATE AN ERROR OBJECT
    NSError *error;
    //FETCH THE RESULTS
    NSArray *result = [context executeFetchRequest:request
                                             error:&error];
    
    if(!result)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@",[error localizedDescription]];
    }
    allCats = [[NSMutableArray alloc]initWithArray:result];
    
    return allCats;
}

-(NSArray *)allTasks
{
    //GENERATE NSFETCHREQUEST (QUERY)
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //IDENTIFY OUR ENTITY (TABLE) TO PULL FORM
    NSEntityDescription *e = [[model entitiesByName]objectForKey:@"Task"];
    
    //ADD THE ENTITY (TABLE) TO THE FETCH (QUERY)
    [request setEntity:e];
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



-(Category *)createCategory
{
    Category *newCategory = [[Category alloc]init];
    
    return newCategory;
}

-(Task *)createTask
{
    Task *newTask = [[Task alloc]init];
    
    
    
    
    return newTask;
}

-(BOOL)saveChanges
{
    NSError *error = nil;
    if(context != nil)
    {
        if([context hasChanges] && ![context save:&error])
        {
            NSLog(@"unresolved Error");
            abort(); //Do not do this of production
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




@end
