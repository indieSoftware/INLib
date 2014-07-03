// INDirectories.h
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


#ifdef __cplusplus
extern "C" {
#endif


/**
 Returns the absolute path to the Documents directory: <Application_Home>/Documents
 
 The returned path is without the ending slash '/'. The Documents directory is backed up by iTunes and iCloud.
 Only documents and other data that is user-generated, or that cannot otherwise be recreated by your application, should be stored in this directory and will be automatically backed up by iCloud.
 See [Apple's guidelines for data storage](https://developer.apple.com/icloud/documentation/data-storage).

 @return The absolute path to the Documents directory.
 */
static inline NSString *INDirectoryDocuments(void) {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
    
    
/**
 Returns the absolute path to the Caches directory: <Application_Home>/Library/Caches

 This directory will not be backed up by the system and may be cleaned by the system any time.
 This directory should be used for recreatable non-user data.
 Data that can be downloaded again or regenerated should be stored in this directory.
 Examples of files you should put in the Caches directory include database cache files and downloadable content, such as that used by magazine, newspaper, and map applications.

 @return The absolute path to the Caches directory.
 */
static inline NSString *INDirectoryCaches(void) {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}


/**
 Returns the tmp directory: <Application_Home>/tmp

 This directory will not be backed up or managed in any way by the system.
 Data that is used only temporarily should be stored in this directory.
 Although these files are not backed up to iCloud, remember to delete those files when you are done with them so that they do not continue to consume space on the user’s device.

 @return The absolute path to the tmp directory.
 */
static inline NSString *INDirectoryTmp(void) {
    return NSTemporaryDirectory();
}


#ifdef __cplusplus
}
#endif
