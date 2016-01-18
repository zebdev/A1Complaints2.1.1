//
//  MyParserViewController.m
//  Hello_SOAP
//
//  Created by TaeIl Kim on 6/23/13.
//
//

#import "MyParserViewController.h"
#import "Hello_SOAPAppDelegate.h"
#import "ticketGridViewController.h"
@interface MyParserViewController ()

@end

@implementation MyParserViewController
@synthesize  webData, soapResults, xmlParser, strTemp, parsed, parsed_key, usingObject, allData;
@synthesize PageNo,Status_for_ticket;

-(id)init:(id)p
{
    if(self = [super init])
    {
        usingObject = p;
        isLoged = 1;
        logID = 0;
        parsed = [[NSMutableDictionary alloc]init];
        parsed_key = [[NSMutableArray alloc]init];
        allData = [[NSMutableArray alloc]init];
        flag = FALSE;
    }
    return self;
}
-(void)dealloc{
    [xmlParser release];
    [parsed_key removeAllObjects];
    [parsed removeAllObjects];
    [parsed release];
    [parsed_key release];
    [allData removeAllObjects];
    [allData release];
    [super dealloc];
}
/*
 POST /expertdata.asmx HTTP/1.1
 Host: ws.apoyar.eu
 Content-Type: text/xml; charset=utf-8
 Content-Length: length
 SOAPAction: "http://www.apoyar.net/GetLogoURL"
 
 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
 "<soap:Header>\n"
 "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
 "<UserName>string</UserName>\n"
 "<Password>string</Password>\n"
 "<IsLoggedIn>boolean</IsLoggedIn>\n"
 "<Url>string</Url>\n"
 "<LanguageCulture>string</LanguageCulture>\n"
 "</WebsiteAuthHeader>\n"
 "</soap:Header>\n"
 "<soap:Body>\n"
 "<GetLogoURL xmlns=\"http://www.apoyar.net/\">\n"
 "<url>string</url>\n"
 "</GetLogoURL>\n"
 "</soap:Body>\n"
 "</soap:Envelope>\n"
 */
-(void)getLogoURL:(NSString *)userUrl{
    [allData removeAllObjects];
    [parsed removeAllObjects];
//    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<GetLogoURL xmlns=\"http://www.apoyar.net/\">\n"
                             "<url>%@</url>\n"
                             "</GetLogoURL>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",userUrl, userUrl];
    NSLog(@"----------GetLogoURL----------");
    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/GetLogoURL" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
          }
	else
	{
		NSLog(@"theConnection is NULL");
	}
}

-(void)updateCustomerPhonenumber:(NSString *)expID CustomerID:(NSString *)ticID PhoneNumber:(NSString*)pNum{
    /*
     POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/UpdateCustPhonenumber"
     */
    [allData removeAllObjects];
    [parsed removeAllObjects];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<UpdateCustPhonenumber xmlns=\"http://www.apoyar.net/\">\n"
                             "<ticketid>%@</ticketid>\n"
                             "<phonenumber>%@</phonenumber>\n"
                             "<url>%@</url>\n"//http://a1crm.apoyar.net
                             "</UpdateEnggPhonenumber>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl ,ticID, pNum, del.userUrl];
    //    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/UpdateCustPhonenumber" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}
-(void)updateEnggPhonenumber:(NSString *)expID TicketID:(NSString *)ticID PhoneNumber:(NSString*)pNum{
    /*
     POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/UpdateEnggPhonenumber"
     */
    [allData removeAllObjects];
    [parsed removeAllObjects];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<UpdateEnggPhonenumber xmlns=\"http://www.apoyar.net/\">\n"
                             "<enggid>%@</enggid>\n"
                             "<phonenumber>%@</phonenumber>\n"
                             "<url>%@</url>\n"
                             "</UpdateEnggPhonenumber>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, ticID, pNum,del.userUrl];
    //    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/UpdateEnggPhonenumber" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}
-(void)getFromEmailAddress:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc{
    /*
     POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/GetFromEmailAddress"
     
     */
    [allData removeAllObjects];
    [parsed removeAllObjects];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<GetFromEmailAddress xmlns=\"http://www.apoyar.net/\">\n"
                             "<settingname>%@</settingname>\n"
                              "<url>%@</url>\n"
                             "</GetFromEmailAddress>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, @"FromEmail",del.userUrl];
    //    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/GetFromEmailAddress" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}
-(void)callTicket:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc{
    /*
     POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/CallTicket"
     
     "
     
     */
    [allData removeAllObjects];
    [parsed removeAllObjects];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<CallTicket xmlns=\"http://www.apoyar.net/\">\n"
                             "<ExpertId>%@</ExpertId>\n"
                             "<ticketid>%@</ticketid>\n"
                             "<description>%@</description>\n"
                             "<url>%@</url>\n"
                             "</CallTicket>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, expID, ticID, desc, del.userUrl];
    //    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/CallTicket" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}
-(void)messageTicket:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc{
    /*
     POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/MessageTicket"
     
     */
    [allData removeAllObjects];
    [parsed removeAllObjects];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<MessageTicket xmlns=\"http://www.apoyar.net/\">\n"
                             "<ExpertId>%@</ExpertId>\n"
                             "<ticketid>%@</ticketid>\n"
                             "<description>%@</description>\n"
                             "<url>%@</url>\n"
                             "</MessageTicket>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, expID, ticID, desc, del.userUrl];
    //    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/MessageTicket" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}
-(void)rejectTicket:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc{
    /*POST /expertdata.asmx HTTP/1.1
Host: ws.apoyar.eu
    Content-Type: text/xml; charset=utf-8
    Content-Length: length
SOAPAction: "http://tempuri.org/RejectTicket"
    
    
     */
    [allData removeAllObjects];
        [parsed removeAllObjects];
        Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<RejectTicket xmlns=\"http://www.apoyar.net/\">\n"
                             "<ExpertId>%@</ExpertId>\n"
                             "<ticketid>%@</ticketid>\n"
                             "<description>%@</description>\n"
                             "<url>%@</url>\n"
                             "</RejectTicket>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, expID, ticID, desc, del.userUrl/*, @"http://a1crm.apoyar.net"*/];
    //    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/RejectTicket" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}

-(void)closeTicket:(NSString *)expID TicketID:(NSString *)ticID Description:(NSString*)desc{
    /*
     POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/CloseTicket"
 */
    [allData removeAllObjects];
        [parsed removeAllObjects];
        Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<CloseTicket xmlns=\"http://www.apoyar.net/\">\n"
                             "<ExpertId>%@</ExpertId>\n"
                             "<ticketid>%@</ticketid>\n"
                             "<description>%@</description>\n"
                             "<url>%@</url>\n"
                             "</CloseTicket>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, expID, ticID, desc,del.userUrl/*, @"http://a1crm.apoyar.net"*/];
    //    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/CloseTicket" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}
-(void)insertTicketDetail{
    /*POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/InsertTicketDetail"*/
    [allData removeAllObjects];
        [parsed removeAllObjects];
        Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<InsertTicketDetail xmlns=\"http://www.apoyar.net/\">\n"
                             "<ExpertId>%@</ExpertId>\n"
                             "<ticketid>%@</ticketid>\n"
                             "<ticketstatusid>%@</ticketstatusid>\n"
                             "<description>%@</description>\n"
                             "<url>%@</url>\n"
                             "</InsertTicketDetail>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, @"5", @"31", @"-1", @"insertTicket", del.userUrl];
    //    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/InsertTicketDetail" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}

    
}
-(void)getTicketInformation: (NSString *)ticketID{
    /*
     POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/GetTicketInformation"*/
    
    [allData removeAllObjects];
        [parsed removeAllObjects];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<GetTicketInformation xmlns=\"http://www.apoyar.net/\">\n"
                             "<TicketId>%@</TicketId>\n"
                             "<url>%@</url>\n"
                             "</GetTicketInformation>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, ticketID,del.userUrl];
    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/GetTicketInformation" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
	
}
-(void)getAllTicketDetails: (NSString*)ticketID{
    /*
     POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/GetAllTicketDetails"*/
    [allData removeAllObjects];
        [parsed removeAllObjects];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<GetAllTicketDetails xmlns=\"http://www.apoyar.net/\">\n"
                             "<TicketId>%@</TicketId>\n"
                             "<url>%@</url>\n"
                             "</GetAllTicketDetails>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, ticketID,del.userUrl];
    //    NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/GetAllTicketDetails" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
	
    
}
-(void)getLocationName:(NSString *)ticketID{
    
    /*
     POST /expertdata.asmx HTTP/1.1
     Host: ws.apoyar.eu
     Content-Type: text/xml; charset=utf-8
     Content-Length: length
     SOAPAction: "http://tempuri.org/GetLocationName"*/
    [allData removeAllObjects];
//    [parsed removeAllObjects];
    parsed = [[NSMutableDictionary alloc]init];
    recordResults = TRUE;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
	NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">>\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<GetLocationName xmlns=\"http://www.apoyar.net/\">>\n"
                             "<ticketid>%@</ticketid>\n"
                             "<url>%@</url>\n"
                             "</GetLocationName>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, ticketID,del.userUrl
                             ];
    //	NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/GetLocationName" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}

-(void)login:(NSString *)userName pwd:(NSString*)passwd{
    
    //    ticketGridViewController *ticketView = [[ticketGridViewController alloc]init];
 
	recordResults = TRUE;
    //    [self insertTicketDetail];
    //    return;
    [allData removeAllObjects];
        [parsed removeAllObjects];
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
	NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<ExpertLogin xmlns=\"http://www.apoyar.net/\">\n"
                             "<Username>%@</Username>\n"
                             "<Password>%@</Password>\n"
                             "<URL>%@</URL>\n"
                             "</ExpertLogin>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl , userName, passwd,del.userUrl/*,txtUsername.text, txtPasswd.text*/
                             ];
	NSLog(@"%@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[theRequest addValue: @"http://www.apoyar.net/ExpertLogin" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}
-(void)InsertDeviceToken:(NSString *)deviceToken andUserid :(NSString *)UserId {
//    NSLog(@"%s device token %@",__FUNCTION__,[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"]);
    [allData removeAllObjects];
    [parsed removeAllObjects];
	recordResults = TRUE;
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
	NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<InsertDeviceToken xmlns=\"http://www.apoyar.net/\">\n"
                             "<userid>%d</userid>\n"
                             "<devicetoken>%@</devicetoken>\n"
                             "<URL>%@</URL>\n"//http://a1crm.apoyar.net
                             "</InsertDeviceToken>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, [UserId intValue], [[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"],del.userUrl
                             ];
	NSLog(@"insertDevieToken %@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://www.apoyar.net/InsertDeviceToken " forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
        NSLog(@"webData %@",webData);
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}

}
-(void)getTicketID: (NSString *) userID
{
    
    Hello_SOAPAppDelegate *del = [UIApplication sharedApplication].delegate;
    
    NSLog(@"passed page no=%@",del.Page_new);
    NSLog(@"current user=%@",userID);
    NSLog(@"status=%@",del.Status_For_Ticket);
    
    NSString *page;
    NSString *status;
    
    [allData removeAllObjects];
    [parsed removeAllObjects];

    NSLog(@"%s",__FUNCTION__);
    if(del.Status_For_Ticket==nil && del.Page_new==nil)
    {
        page=@"20";
        status=@"-1";
    }
    else
    {
        page=del.Page_new;
        int pageheight=(int)[page integerValue];
        page=[NSString stringWithFormat:@"%d",pageheight*20];
        status=del.Status_For_Ticket;
    }
    
    NSLog(@"page=%@",del.Page_new);
    NSLog(@"status=%@",status);
    
	recordResults = TRUE;
	NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Header>\n"
                             "<WebsiteAuthHeader xmlns=\"http://www.apoyar.net/\">\n"
                             "<UserName>ap0yar</UserName>\n"
                             "<Password>ap0yar</Password>\n"
                             "<IsLoggedIn>false</IsLoggedIn>\n"
                             "<Url>\"%@\"</Url>\n"
                             "<LanguageCulture>\"en-gb\"</LanguageCulture>\n"
                             "</WebsiteAuthHeader>\n"
                             "</soap:Header>\n"
                             "<soap:Body>\n"
                             "<MyTickets xmlns=\"http://www.apoyar.net/\">\n"
                             "<Id>%@</Id>\n"
                             "<TicketStatusId>%@</TicketStatusId>\n"
                             "<PageSize>%@</PageSize>\n"
                             "<PageNumber>1</PageNumber>\n"
                             "<url>%@</url>\n"//http://a1crm.apoyar.net
                             "</MyTickets>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",del.userUrl, userID, status,page, del.userUrl
                             ];
	NSLog(@"MyTickets %@",soapMessage);
    NSURL *url = [NSURL URLWithString:@"http://ws.apoyar.net/expertdata.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[theRequest addValue: @"http://www.apoyar.net/MyTickets" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: @"ws.apoyar.net" forHTTPHeaderField:@"HOST"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    NSLog(@"Connection=%@",theConnection);
    NSLog(@"request=%@",theRequest);
	
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction:%@",error.description);
    [usingObject performSelector:@selector(errorAction)];
	[connection release];
	[webData release];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];

    NSLog(@"-----------------Received Data%d-------------------", isLoged);
    NSLog(@"theXML %@",theXML);
    NSLog(@"----------------------%d-----------------------",isLoged);
	[theXML release];
	
	if( xmlParser )
	{
		[xmlParser release];
	}
	
	xmlParser = [[NSXMLParser alloc] initWithData: webData];
	[xmlParser setDelegate: self];
	[xmlParser setShouldResolveExternalEntities: YES];
	[xmlParser parse];
	
	[connection release];
	[webData release];
    [allData addObject:parsed];
    
    NSLog(@"allData count=%lu",(unsigned long)[allData count]);
    
    [usingObject performSelector:@selector(doneAction)];
    
    /*if(PageNo==nil)
    {
        [usingObject performSelector:@selector(doneAction)];
    }
    else
    {
        ticketGridViewController *tview=[[ticketGridViewController alloc] init];
        [tview performSelector:@selector(doneAction)];
    }*/
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    flag = TRUE;
    strTemp = elementName;
    soapResults = [NSMutableString stringWithFormat:@""];
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{

    [soapResults appendString: string];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if(flag == TRUE){
        flag = FALSE;
        if([[parsed allKeys] containsObject:strTemp]){
            [allData addObject:parsed];
            parsed = [[NSMutableDictionary alloc]init];
        }
        [parsed setObject:soapResults forKey:strTemp];
    }
}
@end
