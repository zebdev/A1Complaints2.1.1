//
//  Screen3GridViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/19/13.
//
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"
#import "MyParserViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import "Screen4GridViewController.h"


@interface Screen3GridViewController : UIViewController<MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate, UIGridViewDelegate, UITextViewDelegate, UITextFieldDelegate>{
    MyParserViewController *parser;
    NSString *expID;
    NSString *ticID;
    NSString *desc;
    NSString *emAddress;//llrap027162422015
    NSMutableArray *dat1;
    NSMutableArray *dat2;
    Screen4GridViewController *scr4;
    IBOutlet UITextView *tempView;
    IBOutlet UIScrollView *incBtn;
}
@property (nonatomic, retain) IBOutlet UIGridView *infoView;
@property (nonatomic, retain) IBOutlet UIGridView *historyView;
@property (nonatomic, retain) IBOutlet UIView *viewSub;
@property (nonatomic, retain) IBOutlet UITextView *descView;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) MyParserViewController *parser;
@property (nonatomic, retain) NSString *expID;
@property (nonatomic, retain) NSString *ticID;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *emAddress;
@property (nonatomic, retain) Screen4GridViewController *scr4;
@property (nonatomic, retain) IBOutlet UITextView *tempView;
@property (nonatomic, retain) IBOutlet UIScrollView *incBtn;
-(void)goCallBack:(id)sender;
-(IBAction)btnClose:(id)sender;
-(IBAction)btnCall:(id)sender;
-(IBAction)btnMessage:(id)sender;
-(IBAction)btnReject:(id)sender;
-(IBAction)btnOK:(id)sender;
-(IBAction)btnCancel:(id)sender;
-(IBAction)btnShowHide:(id)sender;
-(void)doneAction;
//@property (nonatomic, retain) IBOutlet UIButton *btnCall;
//@property (nonatomic, retain) IBOutlet UIButton *btnMessage;
//@property (nonatomic, retain) IBOutlet UIButton *btnReject;
//@property (nonatomic, retain) IBOutlet UIButton *btnClose;

@end
