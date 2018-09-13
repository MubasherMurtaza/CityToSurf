//
//  FundRisingViewController.m
//  CityToSurf
//
//  Created by Mubasher on 22/04/2015.
//  Copyright (c) 2015 Connect Techno. All rights reserved.
//

#import "FundRisingViewController.h"

@interface FundRisingViewController ()

@end

@implementation FundRisingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self loadWebView];
    
    tilte.text=delegate.webTitle;
    
    if ([delegate.url isEqualToString:@"http://perth.perthcitytosurf.com/fundraising/"]){
        
        UIScrollView *scroll;
        for(UIView *view in webView.subviews)
        {
            scroll= (UIScrollView*) view;
            [scroll setScrollEnabled:FALSE];
        }
    }
    count=1;
    [webView setFrame:CGRectMake(0, [delegate.topPosition floatValue], 320, 1350)];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)homeMoveBtn:(UIButton*)sender{
    [delegate.navViewController popViewControllerAnimated:YES];
}
-(void)loadWebView{
    
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:delegate.url]];
        [webView loadRequest:requestObj];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (count<=[delegate.loadCount integerValue])
        count++;
    else{
        [webView setFrame:CGRectMake(0, 0, 320, 514)];
        webView.scrollView.scrollEnabled=TRUE;
    }
    
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
