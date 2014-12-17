// NSManagedObject+INExtensions.h
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


@interface NSManagedObject (INExtensions)

/**
 Returns the entity's name (name of class) as a string.

 @return The entity name.
*/
+ (NSString *)entityName;


/**
 Creates a new entity for a managed object context which is also connected.
 
 It is only a shortcut for NSEntityDescription's insertNewObjectForEntityForName:inManagedObjectContext:.

 @param context The context in which the object should be created.
 @return A new managed object of this class.
*/
+ (instancetype)entityInContext:(NSManagedObjectContext *)context;


/**
 Creates a new entity for a managed object context but with no connection, meaning it is not inserted into the context and therefor will not be saved when the context persists.
 
 @param context The managed object context to which the new entity belongs.
 @return A new entity object of the context's sheme but without connection to the context.
 @see addToContext:
*/
+ (instancetype)disconnectedEntity:(NSManagedObjectContext *)context;


/**
 Puts this disconnected entity into a managed object context so this entity will now be managed and saved when the context persists.
 
 @param context The context which should manage this entity.
*/
- (void)addToContext:(NSManagedObjectContext *)context;


@end
