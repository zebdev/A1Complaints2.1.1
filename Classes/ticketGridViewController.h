//
//  ticketGridViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/18/13.
//
//

#import <UIKit/UIKit.h>
#import "MyParserViewController.h"
#import "Screen3GridViewController.h"
#import "ConcernInfoViewController.h"
#import "MNMBottomPullToRefreshManager.h"
#import "MBProgressHUD.h"

//@interface ticketGridViewController : UIViewController< UIGridViewDelegate>{
@interface ticketGridViewController : UIViewController< UITableViewDataSource, UITableViewDelegate>
{
    NSString *expertID;
    MyParserViewController *parser2;
    IBOutlet UITableView *table;
    IBOutlet UIButton *btnSetting;
    IBOutlet UIButton *btnRefresh;
    IBOutlet UILabel *hiddenlable;
    
    NSString *status_for_ticket;
    
    IBOutlet UIView *ListheadingView;
    IBOutlet UIView *ListheadingView1;
    IBOutlet UIView *ListheadingView2;
    ConcernInfoViewController *concernInfo;
    NSString *storeName;
    NSString *customerName;
    NSString *filterString;
//    Screen3GridViewController *tGVC;
    BOOL refFlag;
    
    IBOutlet UIImageView *imgView;
    IBOutlet UIButton *btnNew;
    IBOutlet UIButton *btnOngoing;
    IBOutlet UIButton *btnClosed;
    
    BOOL isid,isstore,iscustomer;
    
    MBProgressHUD *HUD;
    
    int                             startPage,No_of_Page;
    MNMBottomPullToRefreshManager   *pullToRefreshManager;
    BOOL                            isPullForMore;
    
    BOOL PullToRefreshFlag;

}
@property (nonatomic,assign) BOOL isPrevious;
@property (nonatomic,retain) NSMutableArray *newitemArr;
@property (nonatomic,retain) NSMutableArray *ongoingArr;
@property (nonatomic,retain) NSMutableArray *closedArr;
@property (nonatomic,retain) NSMutableDictionary *TempDict;
@property (nonatomic,retain) NSMutableArray *TempArr;

@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property (nonatomic, retain) NSString *expertID;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) MyParserViewController *parser2;
@property (nonatomic, retain) ConcernInfoViewController *concernInfo;

-(IBAction)onSettings:(id)sender;
-(IBAction)onRefresh:(id)sender;
-(void)doneAction;
- (IBAction)btnNewClicked:(id)sender;
- (IBAction)btnOngoingClicked:(id)sender;
- (IBAction)btnClosedClicked:(id)sender;

- (IBAction)btnheadingClicked:(id)sender;

-(void)refreshTable;
@end