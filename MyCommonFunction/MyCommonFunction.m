//
//  MyCommonFunction.m
//  CityToSurf
//
//  Created by Mubasher on 23/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "MyCommonFunction.h"

@implementation MyCommonFunction


+ (BOOL)fileExistsInDocumentDirectory:(NSString*)fileName
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (NSString*)documentDirectoryFilePath:(NSString*)fileName
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

@end
