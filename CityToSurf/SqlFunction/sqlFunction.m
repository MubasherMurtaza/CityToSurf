//
//  sqlFunction.m
//  sqlQuery
//
//  Created by Zain Ali on 10/02/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "sqlFunction.h"
#import <QuartzCore/QuartzCore.h>

@implementation sqlFunction

#define databaseName @"CityToSurf.sqlite"
static sqlite3 *database = nil;

#pragma mark -
#pragma mark DB_STUFF

+(void) copyDatabaseIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    NSLog(@"DB Path: %@", dbPath);
    
    if(!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

+(NSString *) getDBPath {
    
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDir);
    //	return [documentsDir stringByAppendingPathComponent:@"AnwaltTestDB.sqlite"];
    return [documentsDir stringByAppendingPathComponent:databaseName];
}

+(NSString *) getDBPathForSql {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:databaseName];
}

+(void) genrateDB {
    NSString *dbFilePath = [self getDBPath];
    if(sqlite3_open([dbFilePath UTF8String], &database) == SQLITE_OK)
    {
        NSLog(@"CONNECTION SUCCESSFUL WITH DB");
    }
    else
    {
        NSLog(@"CONNECTION FAILURE WITH DB");
    }
    
}
+(void) closeconnection{
    if(sqlite3_close(database)==SQLITE_OK);
    NSLog(@"Connecton close successfully!");
}

+(sqlite3_stmt *) getStatement:(NSString *) SQLStrValue {
    
    NSLog(@"QUERY: %@", SQLStrValue);
    if([SQLStrValue isEqualToString:@""])
        return NO;
    
    sqlite3_stmt * OperationStatement;
    sqlite3_stmt * ReturnStatement = nil;
    
    
    const char * sql = [SQLStrValue cStringUsingEncoding: NSUTF8StringEncoding];
    if (sqlite3_prepare_v2(database, sql, -1, &OperationStatement, NULL) == SQLITE_OK)
    {
        ReturnStatement = OperationStatement;
    }
    return ReturnStatement;
}

+(BOOL)InsUpdateDelData:(NSString*)SqlStr {
    if([SqlStr isEqual:@""])
        return NO;
    
    BOOL RetrunValue;
    RetrunValue = NO;
    const char *sql = [SqlStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, sql, -1, &stmt, nil) == SQLITE_OK)
    {
        printf("\n\nSuccess Query: %s\n\n", sql);
        RetrunValue = YES;
    }
    else
    {
        printf("\n\nFailure Query: %s\n\n", sql);
    }
    
    if(RetrunValue == YES)
    {
        
        if(sqlite3_step(stmt) != SQLITE_DONE)
            NSLog(@"This should be real error checking!");
        sqlite3_finalize(stmt);
        //[sqlFunction closeconnection];
    }
    
    return RetrunValue;
}

+(BOOL)itemExistsInDatabase:(NSString*)tableName FieldName:(NSString*)fieldName Value:(NSString*)value
{
    BOOL flag = FALSE;
    
    NSString *strQuery = [NSString stringWithFormat:@"select ProfileDataid from %@ where %@='%@'",tableName,fieldName,value];
    
    sqlite3_stmt *ReturnStatement = (sqlite3_stmt *) [sqlFunction getStatement: strQuery];
    {
        if(sqlite3_step(ReturnStatement) == SQLITE_ROW)
        {
            flag = TRUE;
        }
    }
    return flag;
}

+(BOOL)itemExistsInDatabase:(NSString*)tableName Value:(NSString*)value
{
    BOOL flag = FALSE;
    
    NSString *strQuery = [NSString stringWithFormat:@"select id from %@ where '%@' between start_date and end_date",tableName,value];
    
    sqlite3_stmt *ReturnStatement = (sqlite3_stmt *) [sqlFunction getStatement: strQuery];
    {
        if(sqlite3_step(ReturnStatement) == SQLITE_ROW)
        {
            flag = TRUE;
        }
    }
    return flag;
}

+(NSString *) documentDirectoryFilePath:(NSString*)fileName {
    
    NSString*(^getPathValue)(NSString *)=^(NSString *fileNameExist){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
        return [documentsDir stringByAppendingPathComponent:fileNameExist];
    };
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = getPathValue(fileName);
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    NSLog(@"Image Path: %@", dbPath);
    
    if(!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        
    }
    return dbPath;
    
}

@end
