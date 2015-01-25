// INCoreDataManager.m
//
// Copyright (c) 2014 Sven Korset
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "INCoreDataManager.h"
#import "INCoreData.h"

#import <CoreData/CoreData.h>


@interface INCoreDataManager ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, copy, readwrite) NSString *modelName;
@property (nonatomic, strong, readwrite) NSURL *storeUrl;
@property (nonatomic, assign) NSInteger versionForNewModel; // default is 0 = model's default version

@end


@implementation INCoreDataManager


#pragma mark - Instance creation

- (instancetype)initWithName:(NSString *)name storeLocation:(NSString *)storeLocation {
    self = [super init];
    if (self == nil) return self;
    
    self.modelName = name;

    // get store URL
    NSString *storeFile = [NSString stringWithFormat:@"%@.sqlite", self.modelName];
    NSString *storePath = [storeLocation stringByAppendingPathComponent:storeFile];
    self.storeUrl = [NSURL fileURLWithPath:storePath isDirectory:NO];
    self.versionForNewModel = 0;
    
    return self;
}

- (instancetype)initWithName:(NSString *)name version:(NSInteger)modelVersion storeLocation:(NSString *)storeLocation {
    self = [super init];
    if (self == nil) return self;
    
    self.modelName = name;
    
    // get store URL
    NSString *storeFile = [NSString stringWithFormat:@"%@.sqlite", self.modelName];
    NSString *storePath = [storeLocation stringByAppendingPathComponent:storeFile];
    self.storeUrl = [NSURL fileURLWithPath:storePath isDirectory:NO];
    self.versionForNewModel = modelVersion;
    
    return self;
}


#pragma mark - Version

- (NSInteger)storeVersion {
    return [NSManagedObjectModel versionNumberOfModelNamed:self.modelName forStoreAtUrl:self.storeUrl];
}

- (NSInteger)modelVersion {
    return [NSManagedObjectModel versionNumberOfModelNamed:self.modelName];
}

- (BOOL)storeExists {
    // the sqlite file should exist on the given path if the store has prior been created
    return [[NSFileManager defaultManager] fileExistsAtPath:self.storeUrl.path];
}


#pragma mark - Migration

- (BOOL)isMigrationNeeded {
    if (![self storeExists]) {
        // no SQLite store file found, no migration needed
        return NO;
    }
    
    // Create the persistent store coordinator which uses the current model.
    // If this fails and no store coordinator is returned then the store and the current model are incompatible
    // and therefore needs an update.
    // This approach may be more expansive than only comparing the meta data, but reading the store's meta data
    // often results in an I/O exception because of a corrupted store, thus this is safer.
    // However, if no migration is needed, which should be in most of the tries,
    // the store is already created and no extra work is done.
    return self.persistentStoreCoordinator == nil;
}

- (BOOL)performMigration:(void (^)(NSInteger fromVersion, NSInteger toVersion, BOOL successfullyMigrated))progressBlock {
    // get store and model version numbers
    NSInteger storeVersion = [self storeVersion];
    NSInteger desiredModelVersion = [self modelVersion];

    // version sanity check
    if (storeVersion == INManagedObjectModelVersionNone || desiredModelVersion <= storeVersion) {
        return NO;
    }
    
    // perform updates
    for (NSInteger nextVersion = storeVersion + 1; nextVersion <= desiredModelVersion; ++nextVersion) {
        BOOL success = [self migrateStoreToVersion:nextVersion];
        if (progressBlock != nil) {
            progressBlock(nextVersion - 1, nextVersion, success);
        }
        if (!success) {
            // migration failed
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)migrateStoreToVersion:(NSInteger)versionNumber {
    // setup
    NSError *error = nil;
    NSDictionary *options;
    NSManagedObjectModel *destinationModel = [NSManagedObjectModel modelNamed:self.modelName version:versionNumber];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:destinationModel];

    // first try to migrate with a custom mapping model
    options = [NSDictionary dictionaryWithObjectsAndKeys:@YES, NSMigratePersistentStoresAutomaticallyOption, @NO, NSInferMappingModelAutomaticallyOption, nil];
    if ([persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeUrl options:options error:&error] != nil) {
        // migration successfully
        return YES;
    }

    // no mapping model could be found, so try to use the automatic mapping model creation
    options = [NSDictionary dictionaryWithObjectsAndKeys:@YES, NSMigratePersistentStoresAutomaticallyOption, @YES, NSInferMappingModelAutomaticallyOption, nil];
    if ([persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeUrl options:options error:&error] != nil) {
        // migration successfully
        return YES;
    }
    
    // still failed to migrate, so give up
    return NO;
}


#pragma mark - Store manipulation

- (BOOL)duplicateStoreToUrl:(NSURL *)url {
    return [self.persistentStoreCoordinator migratePersistentStore:self.persistentStoreCoordinator.persistentStores.lastObject toURL:url options:nil withType:NSSQLiteStoreType error:NULL] != nil;
}

- (BOOL)deleteStore {
    // close all connections to the store
    self.persistentStoreCoordinator = nil;
    self.managedObjectContext = nil;
    self.managedObjectModel = nil;
    
    // delete all corresponding files
    NSString *matchingFilename = [NSString stringWithFormat:@"%@.sqlite", self.modelName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[self.storeUrl URLByDeletingLastPathComponent] path];
    NSDirectoryEnumerator *filesEnumerator = [fileManager enumeratorAtPath:path];
    NSString *file;
    while (file = [filesEnumerator nextObject]) {
        if ([file hasPrefix:matchingFilename]) {
            NSString *filePath = [path stringByAppendingPathComponent:file];
            if (![fileManager removeItemAtPath:filePath error:NULL]) {
                return NO;
            }
        }
    }
    return YES;
}


#pragma mark - core data stack

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    if (self.versionForNewModel > 0) {
        _managedObjectModel = [NSManagedObjectModel modelNamed:self.modelName version:self.versionForNewModel];
    } else {
        _managedObjectModel = [NSManagedObjectModel modelNamed:self.modelName];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // create the coordinator silently with no migration options, either the model is compatible or the creation failes
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if ([_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeUrl options:nil error:NULL] == nil) {
        // An error occured while adding the store, maybe a migration is needed.
        // Without a usable store, delete the coordinator to indicate it needs to be migrated.
        _persistentStoreCoordinator = nil;
    }
    return _persistentStoreCoordinator;
}


@end
