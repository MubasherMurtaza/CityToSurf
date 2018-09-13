//
//  RegisterViewController.h
//  CityToSurf
//
//  Created by Mubasher on 14/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RegisterViewController : UIViewController{
    AppDelegate *delegate;
    IBOutlet UIScrollView *contionarScrollView;
    
    NSMutableArray *registerScrollData;
}

@end
