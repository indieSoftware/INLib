// NSManagedObjectModel+INExtension.h
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


#import <CoreData/CoreData.h>


/// Constant with the value of 0 to indicate no valid model version.
/// The core data model 'MyModel' has to have versions named like 'MyModel_1.xcdatamodel', 'MyModel_2.xcdatamodel', etc.
static NSInteger const INManagedObjectModelVersionNone = 0;


@interface NSManagedObjectModel (INExtension)

/// @name Model instance creation methods

/**
 Class method for creating a managed object model with a given name.
 
 @param modelName The name of the model.
 @return A new managed object model instance.
*/
+ (instancetype)modelNamed:(NSString *)modelName;

/**
 Class method for creating a managed object model with a specific version number.
 
 The different mode versions (xcdatamodel file names) have to be named 'ModelName_X' where X is the version number.
 
 @param modelName The name of the model in general without any version number.
 @param versionNumber A positive number beginning with 1 for the initial version.
 @return A new managed object model instance.
*/
+ (instancetype)modelNamed:(NSString *)modelName version:(NSInteger)versionNumber;


/// @name Comparision

/**
 Compares this model with an other.
 
 Two models are considered as equal when their entity dictionareis have the same content.
 
 @param otherModel The other model to compare with.
 @return True if both models are equal otherwise false.
*/
- (BOOL)isEqualToModel:(NSManagedObjectModel *)otherModel;

/**
 Returns true if the given SQLite store can be opened with this model.
 
 @param storeUrl The URL to a SQLite store.
 @return True if the model and store are compatible, otherwise false.
*/
- (BOOL)isCompatibleWithStoreAtUrl:(NSURL *)storeUrl;


/// @name Model version

/**
 Returns an array of URLs to the different version files of one model.
 
 The model version names have to be of the type 'ModelName_X' with X is the version number.
 
 @param modelName The name of the model.
 @return An array of NSURL objects.
*/
+ (NSArray *)versionUrlsForModelName:(NSString *)modelName;

/**
 Returns the version number of the model which can manage a specific store.

 The model version names (xcdatamodel file names) have to be of the type 'ModelName_X' with X is the version number.
 
 @param modelName The name of the model.
 @param storeUrl The URL to the SQLite store.
 @return The version number (1 or greater) or INManagedObjectModelVersionNone (0) if no compatible model with the propper naming convention could be found.
*/
+ (NSInteger)versionNumberOfModelNamed:(NSString *)modelName forStoreAtUrl:(NSURL *)storeUrl;

/**
 Returns the current version number of the given model.
 
 The model version names (xcdatamodel file names) have to be of the type 'ModelName_X' with X is the version number.
 
 @param modelName The name of the model.
 @return The version number (1 or greater) or INManagedObjectModelVersionNone (0) if no compatible model with the propper naming convention could be found.
 */
+ (NSInteger)versionNumberOfModelNamed:(NSString *)modelName;


@end
