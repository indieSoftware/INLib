// INCoreDataManager.h
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


@class NSManagedObjectContext;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;


/**
 A core data manager which creates and handles the model, it's versions, the context and a SQLite store and its coordinator.
 
 Create the manager with the initWithName:storeLocation: method and the name of the model to manage.
 The model's name is the name of the directory in the project with the xcdatamodeld extension
 while the version files of a model are those inside of this directory and have a xcdatamodel extension.
 It is mandatory that the version files follow a naming convention in which they have the same name as the model's version itself
 followed by an underscore and the version number without leading zeros.
 
 Only SQLite stores are supported and only one per model.
 The store file will be named the same as the model and will resists in the given folder of the app indicated when calling the init method, i.e. 'Documents/MyModel.sqlite'.
 Beware of the other files corresponding to the store on iOS 7+, which have the extensions 'sqlite-shm' and 'sqlite.wal'.
 
 As an example if the model is named 'MyModel' the model's directory is 'MyModel.xcdatamodeld'.
 The initial version is therefore called 'MyModel_1.xcdatamodel' and is found inside of 'MyModel.xcdatamodeld'.
 After updating the core data model a new version is created and gets the name 'MyModel_2.xcdatamodel' which will be the current one.
 An outdated store can then be migrated either with a custom mapping model or via automatic.
 This works automatically, however if a custom mapping model is available it will be prefered.
 The migration even works over multiple versions, so it is possible to automatically migrate a store from version 1 to 3 when the migration from 1 to 2 and 2 to 3 work.
 
 Check if a given store needs to be migrated and perform the migration if necessary before using the core data stack.
 By accessing the model, context or the store coordinator properties the corresponding instances will be created and returned.
 
    INCoreDataManager *manager = [[INCoreDataManager alloc] initWithName:@"MyModel" storeLocation:INDirectoryDocuments()];
    if ([manager isMigrationNeeded]) {
        if (![manager performMigration:^(NSInteger fromVersion, NSInteger toVersion, BOOL successfullyMigrated) {
            NSLog(@"Store from %ld to %ld %@", (long)fromVersion, (long)toVersion, (successfullyMigrated ? @"migrated" : @"not migrated"));
        }]) {
            NSLog(@"Migration failed!");
        }
    } else if (![manager storeExists]) {
        NSLog(@"Store version %ld will be created", (long)[manager modelVersion]);
    }
*/
@interface INCoreDataManager : NSObject

/// @name Initializer

/**
 Initializes the manager with a model name and a store location.
 
 The manager handles the model, context and a store coordinator, thus the store is of the type SQLite.
 The model's name is the name of the directory in the project with the xcdatamodeld extension.
 The store location is the folder in which the store will be created, mostly the documents folder of the app.

 As an example the following call will use the core data model 'MyModel' and the store at /Documents/MyModel.sqlite.
 
    INCoreDataManager *manager = [[INCoreDataManager alloc] initWithName:@"MyModel" storeLocation:INDirectoryDocuments()];

 @param name The model's name.
 @param storeLocation The directory of the SQLite store file(s).
 @return The initialized instance.
 */
- (instancetype)initWithName:(NSString *)name storeLocation:(NSString *)storeLocation;

/**
 Initializes the manager with a model name and a store location.
 
 This method does the same as initWithName:storeLocation: except that it sets the desired model to a specific version.
 
 @param name The model's name.
 @param modelVersion The model's version number greater than 0. If 0 the model's default version will be used.
 @param storeLocation The directory of the SQLite store file(s).
 @return The initialized instance.
 @see initWithName:storeLocation:
 */
- (instancetype)initWithName:(NSString *)name version:(NSInteger)modelVersion storeLocation:(NSString *)storeLocation;

/// The model's name.
@property (nonatomic, copy, readonly) NSString *modelName;

/// The URL to the SQLite store.
@property (nonatomic, strong, readonly) NSURL *storeUrl;


/// @name Core Data Stack

/// The currently managed object context.
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
/// The currently managed object model.
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
/// The currently used persistent store coordinator.
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


/// @name Versions

/**
 Returns the current store's model version.
 
 May be used to get the store's version before migrating it.
 
 @return The store's model version or INManagedObjectModelVersionNone if there is no store or no compatible model.
*/
- (NSInteger)storeVersion;


/**
 Returns the currently used model's version.
 
 @return The current model's version.
*/
- (NSInteger)modelVersion;


/// @name Migration

/**
 Returns true if a SQLite store file could be found on disc.
 
 @return True if a SQLite store file exists, otherwise false.
*/
- (BOOL)storeExists;


/**
 Returns true if there is a SQLite store file and the current model can't be used for it, thus the store needs to be updated.
 
 When creating a manager instance for a specific model version the persistent store coordinator for this model version will be also created,
 so calling isMigrationNeeded on the manager for a lower model version will return NO for a store with the specific version.
 
 @return True if the store needs to be migrated to a newer version.
*/
- (BOOL)isMigrationNeeded;


/**
 Performs a migration of a SQLite store.
 
 There has to be a SQLite store file on disc and with a lower version than the current model.
 To be sure that a migration is needed check prior with isMigrationNeeded.
 
 The migration will automatically apply from version to version in single version steps, i.e. from 1 to 2 and then from 2 to 3.
 If more steps are needed, i.e. from 1 to 3, the migration will automatically do the steps inbetween.
 
 If a custom migration mapping model is available it will be automatically used and prefered, otherwise an automatic mapping model will be used if possible.

 The progress block will be called after each migration step with the version and the migration outcome.
 This is only for logging or another feedback possibility, but may also be nilif not needed, because there is no action needed.
 
 @param progressBlock The block which will be called after each migration step with the store version before migrating and the store version to which to migrate along with the migration outcome as a boolean flag. May be nil.
 @return True if the migration could be performed without any errors, otherwise false.
*/
- (BOOL)performMigration:(void (^)(NSInteger fromVersion, NSInteger toVersion, BOOL successfullyMigrated))progressBlock;


/// @name Store manipulation

/**
 Duplicates the current store files to another location.
 
 Before calling this method any pending modifications should be saved.
 
 This is done by copying any files on disc directly to the new location instead of using `[NSPersistentStoreCoordinator migratePersistentStore:toURL:options:withType:error:]`, because we want to continue the old store and not the new migrated one.
 Each file at the current store's location with the same name of the model name will be copied, which will be not only the .sqlite file, but also the .sqlite-shm and .sqlite-wal files.
 
 @param url The URL which includes the new store's file name.
 @return True if the store could be duplicated, false if an error occured.
*/
- (BOOL)duplicateStoreToUrl:(NSURL *)url;


/**
 Deletes the corresponding SQLite store file(s).
 
 Each file at the store's directory which begins with the model's name and followed by '.sqlite' will be deleted.
 This will not only delete the .sqlite file itself, but also the .sqlite-shm and .sqlite-wal files.
 Other files or in subdirectories will not be affected.
 
 @return False if an error occured while deleting the files, otherwise true.
*/
- (BOOL)deleteStore;


@end
