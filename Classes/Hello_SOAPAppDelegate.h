//
//  Hello_SOAPAppDelegate.h
//  Hello_SOAP
//
//  Created by Dave McAnall on 11/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Hello_SOAPViewController;

@interface Hello_SOAPAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet Hello_SOAPViewController *viewController;
//    NSMutableArray *data1;
//    NSMutableArray *data2;
//    NSString *expertID;
//    NSString *userName;
//    NSString *passWd;
//    NSString *ticID;
//    NSMutableArray *dat1;
//    NSMutableArray *dat2;
    BOOL sFlg;
    NSMutableData *webdata;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) id parentvc;
@property (nonatomic, retain) Hello_SOAPViewController *viewController;
@property (nonatomic, retain) NSMutableArray *data1;
@property (nonatomic, retain) NSMutableArray *data2;
@property (nonatomic, retain) NSMutableArray *dat1;
@property (nonatomic, retain) NSMutableArray *dat2;
@property (nonatomic, retain) NSString *expertID;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *passWd;
@property (nonatomic, retain) NSString *ticID;
@property (nonatomic, retain) NSString *Customer_Name;
@property (nonatomic, retain) NSString *Store_name;
@property (nonatomic, readwrite) BOOL sFlg;
@property (nonatomic, retain) NSString *userUrl;
@property (nonatomic, retain) NSString *strDeviceToken;

@property (nonatomic, strong) NSString *Page_new;
@property (nonatomic, strong) NSString *Page_Close;
@property (nonatomic, strong) NSString *Page_ongoing;

@property (nonatomic, strong) NSString *Selected_Category;

@property (nonatomic, strong) NSString *Status_For_Ticket;

@end	

