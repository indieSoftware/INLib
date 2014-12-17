// NSManagedObjectModel+INExtension.m
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


#import "NSManagedObjectModel+INExtension.h"


@implementation NSManagedObjectModel (INExtension)

#pragma mark - Model instance creation methods

+ (instancetype)modelNamed:(NSString *)modelName {
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
}

+ (instancetype)modelNamed:(NSString *)modelName version:(NSInteger)versionNumber {
    NSString *subdir = [NSString stringWithFormat:@"%@.momd", modelName];
    NSString *fileName = [NSString stringWithFormat:@"%@_%ld", modelName, (long)versionNumber];
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"mom" subdirectory:subdir];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    return model;
}


#pragma mark - Comparision

- (BOOL)isEqualToModel:(NSManagedObjectModel *)otherModel {
    if (self == otherModel) {
        return YES;
    }
    return [self.entitiesByName isEqualToDictionary:otherModel.entitiesByName];
}

- (BOOL)isCompatibleWithStoreAtUrl:(NSURL *)storeUrl {
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self];
    return nil != [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:NULL];
}


#pragma mark - Model version

+ (NSArray *)versionUrlsForModelName:(NSString *)modelName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *subdir = [NSString stringWithFormat:@"%@.momd", modelName];
    NSMutableArray *versionUrls = [NSMutableArray array];
    NSInteger versionNumber = INManagedObjectModelVersionNone;
    while (true) {
        NSString *fileName = [NSString stringWithFormat:@"%@_%ld", modelName, (long)(versionNumber + 1)];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mom" inDirectory:subdir];
        if ([fileManager fileExistsAtPath:filePath]) {
            versionNumber++;
            [versionUrls addObject:[NSURL fileURLWithPath:filePath]];
        } else {
            break;
        }
    }
    return versionUrls;
}

+ (NSInteger)versionNumberOfModelNamed:(NSString *)modelName forStoreAtUrl:(NSURL *)storeUrl {
    NSArray *versionUrls = [self versionUrlsForModelName:modelName];
    for (NSURL *modelUrl in versionUrls) {
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
        if ([model isCompatibleWithStoreAtUrl:storeUrl]) {
            NSArray *pathComponents = modelUrl.pathComponents;
            NSString *fileName = [[pathComponents lastObject] stringByDeletingPathExtension];
            NSArray *fileComponents = [fileName componentsSeparatedByString:@"_"];
            NSString *version = [fileComponents lastObject];
            return [version integerValue];
        }
    }
    return INManagedObjectModelVersionNone;
}

+ (NSInteger)versionNumberOfModelNamed:(NSString *)modelName {
    NSManagedObjectModel *targetModel = [self modelNamed:modelName];
    NSArray *versionUrls = [self versionUrlsForModelName:modelName];
    for (NSURL *modelUrl in versionUrls) {
        NSManagedObjectModel *versionModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
        if ([versionModel isEqualToModel:targetModel]) {
            NSArray *pathComponents = modelUrl.pathComponents;
            NSString *fileName = [[pathComponents lastObject] stringByDeletingPathExtension];
            NSArray *fileComponents = [fileName componentsSeparatedByString:@"_"];
            NSString *version = [fileComponents lastObject];
            return [version integerValue];
        }
    }
    return INManagedObjectModelVersionNone;
}


@end
