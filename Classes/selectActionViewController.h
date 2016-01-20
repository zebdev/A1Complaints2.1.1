//
//  selectActionViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/8/13.
//
//

#import <UIKit/UIKit.h>
#import "rejectViewController.h"
#import "calViewController.h"
#import "messageViewController.h"
#import "MyParserViewController.h"
#import "MBProgressHUD.h"

@interface selectActionViewController : UIViewController{
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnCall;
    IBOutlet UIButton *btnMessage;
    IBOutlet UIButton *btnClose;
    IBOutlet UIButton *btnRelease;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UILabel *tempLabel2;
    
    rejectViewController *rVC;
    calViewController *cVC;
    messageViewController *mVC;
    
    MyParserViewController *parser;
}

-(IBAction)clickedBack:(id)sender;
-(IBAction)clickedCall:(id)sender;
-(IBAction)clickedMessage:(id)sender;
-(IBAction)clickedClose:(id)sender;
-(void)doneAction;
@end
