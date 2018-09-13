//
//  AppDelegate.h
//  CityToSurf
//
//  Created by Mubasher on 13/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

#import "Result.h"


@class HomeViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,MKMapViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navViewController;
@property (strong, nonatomic) HomeViewController *homeVC;

@property (strong, nonatomic) NSString *webTitle;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *topPosition;
@property (strong, nonatomic) NSString *loadCount;

@property (strong, nonatomic) NSString *ticketImg;
//@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) Result *detailResultData;
@property (strong, nonatomic) Result *detailSharedData;

@property (strong, nonatomic) NSString *countryLabel;

-(void)jumpAnimationForViewToggle:(UIView *)animatedView toPoint:(CGPoint)point;
-(int)calculateDays:(NSString*)firstDate SecondDate:(NSString*)secondDate Format:(NSString*)format;
-(NSString*)formatCurrentDate:(NSString*)format;

-(void)sendFbPost:(NSString*)message sharedPicture:(UIImage*)image;

@end

