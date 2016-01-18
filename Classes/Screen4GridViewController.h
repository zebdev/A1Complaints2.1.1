//
//  Screen4GridViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/19/13.
//
//

#import <UIKit/UIKit.h>
#import "Hello_SOAPAppDelegate.h"
#import "MyParserViewController.h"
#import "OCCalendarViewController.h"

@class ticketGridViewController;
@interface Screen4GridViewController : UIViewController<UITextFieldDelegate, OCCalendarDelegate, UIGestureRecognizerDelegate, UITextViewDelegate>{
    MyParserViewController *parser4;
    ticketGridViewController *tGVC;
    OCCalendarViewController *occ;
    UILabel *toolTipLabel;
    IBOutlet UITextField *txtDateTime;
    IBOutlet UITextField *txtClose;
    IBOutlet UITextView *txtMessage;
    IBOutlet UIScrollView *sv;
    BOOL flag;
}
@property (nonatomic, retain) ticketGridViewController *tGVC;
@property (nonatomic, retain) OCCalendarViewController *occ;
@property (nonatomic, retain) IBOutlet UITextField *txtDateTime;
@property (nonatomic, retain) IBOutlet UITextField *txtClose;
@property (nonatomic, retain) IBOutlet UITextView *txtMessage;
@property (nonatomic, retain) IBOutlet UIScrollView *sv;

-(IBAction)onClicked:(id)sender;
-(IBAction)showCalendar:(id)sender;
-(IBAction)setDateTime:(id)sender;
-(IBAction)onOK:(id)sender;
@end
