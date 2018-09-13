//
//  Result.h
//  CityToSurf
//
//  Created by Mubasher on 21/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject

@property (nonatomic, retain) NSString *trackResultid;
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *elapsedTime;
@property (nonatomic,retain ) NSString *altitude;
@property (nonatomic, retain) NSString *distCovered;
@property (nonatomic, retain) NSString *speed;
@property (nonatomic, retain) NSString *avgSpeed;
@property (nonatomic, retain) NSString *maxSpeed;
@property (nonatomic, retain) NSString *dateCalc;
@property (nonatomic, retain) NSMutableArray *googlePathPoints;
@property (nonatomic, retain) NSString *imgPath;

@end
