//
//  CoreData.m
//  NoteBook
//
//  Created by Nikolay on 26.05.15.
//  Copyright (c) 2015 gng. All rights reserved.
//

#import "CoreData.h"
#import "AppDelegate.h"


@implementation CoreData


- (NSManagedObjectContext *)managedObjectContext {
    
    NSManagedObjectContext * context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        
        context = [delegate managedObjectContext];
        
    }
    
    return context;
}

- (void)saveData:(NSString*)entityName Value:(NSString *)value ForKey:(NSString *)key {
    
    NSManagedObject * newObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    
    [newObject setValue:value forKey:key];
    
    NSError * error = nil;
    
    if (![[self managedObjectContext] save:&error]) {
        
        NSLog(@"Error = %@ ", error);
        
    }
    
}

- (NSArray *)getData:(NSString*)entityName ForKey:(NSString *)key {
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    NSFetchRequest * requestData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription * entityData = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    
    [requestData setEntity:entityData];
    
    NSError * error = nil;
    
    NSArray * arrayData = [[self managedObjectContext] executeFetchRequest:requestData error:&error];
    
    for (NSManagedObject * obj in arrayData) {
        
        NSString * value = [obj valueForKey:key];
        
        [array addObject:value];
        
    }
    
    return array;
    
}

- (void)saveNSData: (NSString *)entityName Value: (NSData *)dataValue Key: (NSString *)key {
    
    NSManagedObject * newObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    
    [newObject setValue:dataValue forKey:key];
    
    NSError * error = nil;
    
    if (![[self managedObjectContext] save:&error]) {
        
        NSLog(@"Error = %@ ", error);
        
    }
    
}

- (NSMutableArray *)getNSData:(NSString*)entityName ForKey:(NSString *)key {
    
    NSMutableArray * arrayData = [[NSMutableArray alloc] init];
    
    NSData * data = [[NSData alloc] init];
    
    NSFetchRequest * requestData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription * entityData = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    
    [requestData setEntity:entityData];
    
    NSError * error = nil;
    
    NSArray * arrayObject = [[self managedObjectContext] executeFetchRequest:requestData error:&error];
    
    for (NSManagedObject * obj in arrayObject) {
        
        data = [obj valueForKey:key];
        
        [arrayData addObject:data];
        
    }
    
    return arrayData;
    
}

-(void) deleteAllData: (NSString *) entityName {
    
    NSFetchRequest * requestData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription * entityData = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    
    [requestData setEntity:entityData];
    
    NSError * error = nil;
    
    NSArray * arrayData = [[self managedObjectContext] executeFetchRequest:requestData error:&error];
    
    for (NSManagedObject * obj in arrayData) {
        
        
        [[self managedObjectContext] deleteObject:obj];
        
    }
    
}


@end
