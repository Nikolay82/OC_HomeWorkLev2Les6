//
//  CoreData.h
//  NoteBook
//
//  Created by Nikolay on 26.05.15.
//  Copyright (c) 2015 gng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreData : NSObject

- (void)saveData:(NSString*)entityName Value:(NSString *)name ForKey:(NSString *)key;

- (NSArray *)getData:(NSString*)entityName ForKey:(NSString *)key;

- (void)saveNSData: (NSString *)entityName Value: (NSData *)dataValue Key: (NSString *)key;

- (NSMutableArray *)getNSData:(NSString*)entityName ForKey:(NSString *)key;


@end
