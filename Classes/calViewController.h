//
//  calViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/9/13.
//
//

#import <UIKit/UIKit.h>
#import "MyParserViewController.h"
@interface calViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>{
    IBOutlet UITextField *txtDateTime;
    MyParserViewController *parser;
    BOOL flag;
}

-(IBAction)onBtnCal:(id)sender;
-(IBAction)onBtnOK:(id)sender;
-(IBAction)onBtnBack:(id)sender;
-(void)doneAction;

@end
