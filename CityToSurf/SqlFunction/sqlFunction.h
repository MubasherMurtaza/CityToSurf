//
//  sqlFunction.h
//  sqlQuery
//
//  Created by Zain Ali on 10/02/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"


@interface sqlFunction : NSObject{
}

+(void) copyDatabaseIfNeeded;
+(NSString *) getDBPath;
+(NSString *) getDBPathForSql;
+(void) genrateDB;
+(sqlite3_stmt *) getStatement:(NSString *) SQLStrValue;
+(BOOL)InsUpdateDelData:(NSString*)SqlStr;

+(BOOL)itemExistsInDatabase:(NSString*)tableName FieldName:(NSString*)fieldName Value:(NSString*)value;
+(BOOL)itemExistsInDatabase:(NSString*)tableName Value:(NSString*)value;
+(void)closeconnection;
+(NSString *) documentDirectoryFilePath:(NSString*)fileName;

@end



