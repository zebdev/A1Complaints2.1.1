//
//  ConcernInfoViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/8/13.
//
//

#import <UIKit/UIKit.h>
#import "MyParserViewController.h"
#import "actionDetailViewController.h"
#import "selectActionViewController.h"
#import "rejectViewController.h"
#import "messageViewController.h"
#import "MBProgressHUD.h"

@interface ConcernInfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,messageDelegate>{
    MyParserViewController *parser10;
    NSString *desc;
    BOOL flag,isCalled;
    actionDetailViewController *detailView;

    rejectViewController *rVC;
    messageViewController * mVC;
    UITextField *tf;
    IBOutlet UILabel *lblID;
    IBOutlet    UIScrollView *sss;
    IBOutlet UIButton *btnNew;
    IBOutlet UIButton *btnOngoing;
    IBOutlet UIButton *btnClosed;
    IBOutlet UITextView *l;
    IBOutlet UIWebView *web;
    NSString *message;
}
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property (nonatomic, retain) IBOutlet UIButton *btnAction;
@property (nonatomic, retain) IBOutlet UIButton *btnCall;
@property (nonatomic, retain) IBOutlet UIButton *btnMessage;
@property (nonatomic, retain) IBOutlet UIButton *btnReject;
@property (nonatomic, retain) IBOutlet UIButton *btnClose;
@property (nonatomic, retain) IBOutlet UILabel *lblBack;
@property (nonatomic, retain) IBOutlet UIButton *btnback;
@property (nonatomic, retain) selectActionViewController *sAVC;
@property (nonatomic, retain) id delegate;
-(IBAction)btnBack:(id)sender;
-(IBAction)btnClickedAction:(id)sender;
-(IBAction)bClickedCall:(id)sender;
-(IBAction)bClickedMessage:(id)sender;
-(IBAction)bClickedReject:(id)sender;
-(IBAction)bClickedClose:(id)sender;
- (IBAction)btnNewClicked:(id)sender;
- (IBAction)btnOngoingClicked:(id)sender;
- (IBAction)btnClosedClicked:(id)sender;
-(void)hideHud;
@end
