//
//  AppDelegate.m
//  CityToSurf
//
//  Created by Mubasher on 13/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "sqlFunction.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
//@synthesize locationManager;

#define constantTime 0.48f



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [sqlFunction copyDatabaseIfNeeded];
    [sqlFunction genrateDB];
    
    [GMSServices provideAPIKey:@"AIzaSyBAV5LioZRM0X0cqBR2Fri1bioNQQbZ8r0"];
    
//    locationManager = [[CLLocationManager alloc] init];
//    [locationManager setDelegate:self];
//    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//    
//    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [locationManager requestWhenInUseAuthorization];
//        NSLog(@"yes");
//    }
//    [locationManager startUpdatingLocation];
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.homeVC =[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
    self.navViewController=[[UINavigationController alloc]initWithRootViewController:self.homeVC];
    self.navViewController.navigationBarHidden=TRUE;
    self.window.rootViewController=self.navViewController;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"%@",@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"%@",@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"%@",@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"%@",@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"%@",@"applicationWillTerminate");
}

#pragma mark -
#pragma mark Animation

-(void)jumpAnimationForViewToggle:(UIView *)animatedView toPoint:(CGPoint)point{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:constantTime];
    [animatedView setCenter:point];
    [UIView commitAnimations];
}
#pragma mark -
#pragma mark Calculate Day

-(int)calculateDays:(NSString*)firstDate SecondDate:(NSString*)secondDate Format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *startDate = [formatter dateFromString:firstDate];
    NSLog(@"%@",startDate);
    NSDate *endDate = [formatter dateFromString:secondDate];
    NSLog(@"%@",endDate);
    
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    return (int)components.day;
}

-(NSString*)formatCurrentDate:(NSString*)format
{
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:format];
    NSDate *currentDate = [[NSDate alloc] init];
    return [dateFormatter1 stringFromDate:currentDate];
}

#pragma mark -
#pragma mark Shared On Fb
-(void)sendFbPost:(NSString *)message sharedPicture:(UIImage *)image{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            
            [fbController dismissViewControllerAnimated:YES completion:nil];
            
            switch(result)
            {
                case SLComposeViewControllerResultCancelled:
                    break;
                case SLComposeViewControllerResultDone:
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"ThankYou,You sucessfully share CityToSurf on Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }
        };
        
        
        [fbController setInitialText:message];
        [fbController addImage:image];
        
        [fbController setCompletionHandler:completionHandler];
        [self.navViewController presentViewController:fbController animated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sign In!" message:@"Please first Sign In to your device. Go to device settings and SignIn for facebook!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

@end
