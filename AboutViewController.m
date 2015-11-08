//
//  AboutViewController.m
//  BullsEye
//
//  Created by Nguyen Van Anh Tuan on 11/1/15.
//  Copyright © 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AboutViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSString* htmlFile = [[NSBundle mainBundle] pathForResource:@"BullsEye" ofType:@"html"];
    NSData* htmlData = [NSData dataWithContentsOfFile:htmlFile];
    NSURL* baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
}

-(IBAction)close{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
