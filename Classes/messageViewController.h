//
//  messageViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/9/13.
//
//

#import <UIKit/UIKit.h>
#import "MyParserViewController.h"

@protocol messageDelegate <NSObject>

-(void)message :(NSString *)string;
@end
@interface messageViewController : UIViewController<UITextViewDelegate>{
    IBOutlet    UILabel *lblDesc;
    IBOutlet    UITextView  *txtvCont;
    IBOutlet    UIButton    *btnBack;
    IBOutlet    UIButton    *btnSend;
    IBOutlet    UIScrollView *sV;
    MyParserViewController *parser;
    BOOL flag,isSubmitted;
    UILabel *lblPlaceholder;
    IBOutlet UIButton *btnCancel;
    IBOutlet UILabel *lblTitle;
}
@property (nonatomic, retain) NSString *desc;
@property (strong, nonatomic) NSString *strMessage;

-(IBAction)btnBackClicked:(id)sender;
-(IBAction)btnSendClicked:(id)sender;
-(void)doneAction;

@property (nonatomic,assign) id <messageDelegate> delegate;
@end
