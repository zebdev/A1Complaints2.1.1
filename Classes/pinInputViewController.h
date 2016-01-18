//
//  pinInputViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/19/13.
//
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "MyParserViewController.h"
#import "ticketGridViewController.h"

@interface pinInputViewController : UIViewController<UITextFieldDelegate>{
    NSString *expertID;
    IBOutlet    UITextField *char1,*char2,*char3,*char4;
    IBOutlet    UILabel *title1,*title2;

    IBOutlet    UITextField *char5,*char6,*char7,*char8;;
    IBOutlet    UIButton    *btnOK;
    IBOutlet    UIButton    *btnCancel;
    IBOutlet    UIImageView *imgBack;
    IBOutlet    UIImageView *imgCover;
    MyParserViewController *parser1;
    IBOutlet UIScrollView *sV;
    ticketGridViewController *tGVC;
    NSMutableDictionary *pins;
    UIActivityIndicatorView *spinner;
    int userCount;
    int ticCount;
    BOOL flag;
    BOOL f;
}

@property (nonatomic,strong) NSString *strUserId;
@property (nonatomic, retain) NSString *expertID;
@property (nonatomic, readwrite) BOOL bSaved;
 @property(nonatomic, retain) IBOutlet UITextField *pin1;
 @property(nonatomic, retain) IBOutlet UITextField *pin2;
@property (nonatomic, readwrite) int direct;
@property(nonatomic, retain) ticketGridViewController *tGVC;
@property(nonatomic, retain) IBOutlet UIButton *btnOK;
@property(nonatomic, retain) IBOutlet UIButton *btnCancel;
//@property(nonatomic, retain)    IBOutlet UIScrollView *sV;
-(IBAction)okClicked:(id)sender;
-(IBAction)forgotClicked:(id)sender;
-(IBAction)onClickedCancel:(id)sender;
-(void)doneAction;
- (void)showAlertWithTitle:(NSString *)t;
- (IBAction)authenticateButtonTapped:(id)sender;
@end
/*    IBOutlet UITextField *txtUrl;
 IBOutlet UITextField *txtPasswd;
 IBOutlet UILabel *greeting;
 
 MyParserViewController *parser;
 }
 
 @property(nonatomic, retain) IBOutlet UITextField *nameInput;
 @property(nonatomic, retain) IBOutlet UILabel *greeting;*/