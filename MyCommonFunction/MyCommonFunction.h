//
//  MyCommonFunction.h
//  CityToSurf
//
//  Created by Mubasher on 23/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCommonFunction : NSObject


+(NSString*)documentDirectoryFilePath:(NSString*)fileName;
+(BOOL)fileExistsInDocumentDirectory:(NSString*)fileName;

@end
