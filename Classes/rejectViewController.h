//
//  rejectViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/9/13.
//
//

#import <UIKit/UIKit.h>
#import "MyParserViewController.h"

@interface rejectViewController : UIViewController<UITextViewDelegate>{

    IBOutlet    UITextView  *txtvCont;
    IBOutlet    UIButton    *btnBack;
    IBOutlet    UIButton    *btnSend;
    
    IBOutlet UIButton *btnCancel;
    IBOutlet    UIScrollView  *sV;
    IBOutlet UILabel *lblTitle;
    UILabel *lblPlaceholder;
    NSString        *lastString;
    MyParserViewController *parser;
    BOOL    flag;
}
@property (nonatomic, retain) NSString *desc,*lbltext;
@property (nonatomic, retain) IBOutlet    UILabel *lblDesc;
-(IBAction)btnBackClicked:(id)sender;
-(IBAction)btnSendClicked:(id)sender;

-(void)doneAction;
@end
