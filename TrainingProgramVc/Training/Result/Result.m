//
//  Result.m
//  CityToSurf
//
//  Created by Mubasher on 21/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "Result.h"

@implementation Result

@synthesize trackResultid,startTime,elapsedTime,altitude,distCovered,speed,avgSpeed,maxSpeed,dateCalc,googlePathPoints,imgPath;

-(void)dealloc{
    
    trackResultid=Nil;
    startTime=Nil;
    elapsedTime=Nil;
    altitude=Nil;
    distCovered=Nil;
    speed=Nil;
    avgSpeed=Nil;
    maxSpeed=Nil;
    dateCalc=Nil;
    googlePathPoints=Nil;
    imgPath=Nil;
}

@end
