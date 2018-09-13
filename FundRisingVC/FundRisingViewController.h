//
//  FundRisingViewController.h
//  CityToSurf
//
//  Created by Mubasher on 22/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FundRisingViewController : UIViewController<UIWebViewDelegate>{
    AppDelegate *delegate;
    IBOutlet UIWebView *webView;
    
    IBOutlet UILabel *tilte;
    
    int count;
}

@end
