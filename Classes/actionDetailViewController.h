//
//  actionDetailViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 7/8/13.
//
//

#import <UIKit/UIKit.h>
#import "MyParserViewController.h"

@interface actionDetailViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    MyParserViewController *parser11;
    BOOL flag;
    int selectedrow;
    NSString *desc;
//    CGSize expectedLabelSize;
    NSMutableDictionary *sizes;
//    float *sizes;
    IBOutlet UILabel *lblID;
}
@property (nonatomic, retain) IBOutlet UIButton *btnBack;
@property (nonatomic, retain) IBOutlet UIButton *btnRefresh;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UILabel *lblBack;
-(IBAction)actionBack:(id)sender;
-(IBAction)actionRefresh:(id)sender;

@end
