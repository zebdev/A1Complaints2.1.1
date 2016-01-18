//
//  TicketDetailViewController.h
//  ApoyarA1 Complaints V2
//
//  Created by Keshav on 25/04/14.
//
//

#import <UIKit/UIKit.h>
#import "MyParserViewController.h"
@interface TicketDetailViewController : UIViewController
{
    MyParserViewController *parser11;
    BOOL flag;
    NSString *desc;

}
@property (retain, nonatomic) IBOutlet UIButton             *btnBack;
@property (retain, nonatomic) IBOutlet UILabel              *lblID;
@property (retain, nonatomic) IBOutlet UILabel *lblDate;
@property (retain, nonatomic) IBOutlet UILabel *lblWho;
@property (retain, nonatomic) NSMutableArray   *marrData;
@property (retain, nonatomic) IBOutlet UIScrollView *svTicket;
@property (retain, nonatomic) IBOutlet UILabel *lblDescription;
@end
