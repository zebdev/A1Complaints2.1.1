//
//  Hello_SOAPViewController.h
//  Hello_SOAP
//
//  Created by Dave McAnall on 11/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ticketGridViewController.h"
#import "MyParserViewController.h"
#import "pinInputViewController.h"
#import "ticketGridViewController.h"
#import "MBProgressHUD.h"
@interface Hello_SOAPViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIImageView *imgBack;
	IBOutlet UITextField *txtUsername;
    IBOutlet UITextField *txtUrl;
    IBOutlet UITextField *txtPasswd;
    IBOutlet UIImageView *imgLogo;

    IBOutlet UIButton *btnLogin;
    IBOutlet UIScrollView *scrollView;
IBOutlet UIButton *btnCheck;
    UIActivityIndicatorView *indicatorView;
    pinInputViewController *pinView;
    ticketGridViewController *ticketView;
    MyParserViewController *parser,*parser1;
    BOOL flag,isRememberMe;
    BOOL fShowLogo;
    UIActivityIndicatorView *spinner;
    NSString *strUserId;
}

@property(nonatomic, retain) MyParserViewController *parser;
@property(nonatomic, retain) pinInputViewController *pinView;
@property(nonatomic, retain) UIActivityIndicatorView *indicatorView;
@property(nonatomic, readwrite) BOOL fCanceled;


-(IBAction)buttonClick: (id) sender;
-(IBAction)checkClick:(id)sender;
-(void)doneAction;
- (void)showAlertWithTitle:(NSString *)t;
@end

