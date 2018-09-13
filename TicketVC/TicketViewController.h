//
//  TicketViewController.h
//  CityToSurf
//
//  Created by Mubasher on 22/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TicketViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    AppDelegate *delegate;
    
    IBOutlet UIImageView *ticketImg;
    IBOutlet UILabel *addTicket;
    IBOutlet UIButton *btnCapture;
    IBOutlet UIButton *viewConvertBtn;
    
    IBOutlet UIView *fullView;
    IBOutlet UIImageView *fullImgView;
}

@end
