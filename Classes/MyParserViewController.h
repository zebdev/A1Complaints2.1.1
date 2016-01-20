//
//  MyParserViewController.h
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/23/13.
//
//

#import <UIKit/UIKit.h>

@interface MyParserViewController : NSObject< NSXMLParserDelegate>
{
    NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
    NSMutableDictionary *parsed;
    NSMutableArray *parsed_key;
    NSMutableArray *allData;
    NSString *strTemp;

	BOOL *recordResults;
    BOOL flag;
    int isLoged;
    int logID;
    NSString *strUserId;
    
    id usingObject;
}
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property(nonatomic, retain) NSMutableDictionary *parsed;
@property(nonatomic, retain) NSMutableArray *parsed_key;
@property(nonatomic, retain) NSMutableArray *allData;
@property(nonatomic, retain) NSString *strTemp;
@property(nonatomic, retain) id usingObject;

@property(nonatomic, strong) NSString *PageNo;
@property(nonatomic, strong) NSString *Status_for_ticket;


-(void)login: (NSString *)userName pwd:(NSString *)passwd;
-(void)getTicketID: (NSString *) userID;
-(void)getLocationName: (NSString*)ticketID;
-(void)getAllTicketDetails: (NSString*)ticketID;
-(void)getTicketInformation: (NSString *)ticketID;
-(void)closeTicket:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc;
-(void)rejectTicket:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc;
-(void)messageTicket:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc;
-(void)callTicket:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc;
-(void)callbackTicket:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc;

-(void)getFromEmailAddress:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc;
-(void)updateEnggPhonenumber:(NSString *)expID TicketID:(NSString *)ticID PhoneNumber:(NSString*)pNum;
-(void)updateCustomerPhonenumber:(NSString *)expID CustomerID:(NSString *)ticID PhoneNumber:(NSString*)pNum;
-(void)getLogoURL:(NSString *)userUrl;
-(id)init:(id)p;
-(void)InsertDeviceToken:(NSString *)deviceToken andUserid :(NSString *)UserId;
@end
