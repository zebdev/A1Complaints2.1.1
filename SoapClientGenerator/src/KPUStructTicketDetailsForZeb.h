//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 23-03-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

#import "KPURequestResultHandler.h"
#import "DDXML.h"



@interface KPUStructTicketDetailsForZeb : NSObject <KPUISerializableObject>


@property (nonatomic,getter=getPKTicketId) int PKTicketId;

@property (retain,nonatomic,getter=getTicketTitle) NSString* TicketTitle;

@property (nonatomic,getter=getTicketStatus) int TicketStatus;

@property (nonatomic,getter=getFKTicketStatusID) int FKTicketStatusID;

@property (nonatomic,getter=getCustomerID) int CustomerID;

@property (retain,nonatomic,getter=getCustomerName) NSString* CustomerName;

@property (retain,nonatomic,getter=getStoreName) NSString* StoreName;

@property (retain,nonatomic,getter=getStatusName) NSString* StatusName;

@property (retain,nonatomic,getter=getTicketSubStatusName) NSString* TicketSubStatusName;

@property (retain,nonatomic,getter=getTicketCreated) NSDate* TicketCreated;

@property (retain,nonatomic,getter=getResolutionSLA) NSDate* ResolutionSLA;

@property (retain,nonatomic,getter=getTicketDescription) NSString* TicketDescription;

@property (retain,nonatomic,getter=getTicketTypeName) NSString* TicketTypeName;

@property (nonatomic,getter=getAttachmentID) int AttachmentID;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
+(KPUStructTicketDetailsForZeb*) createWithXml:(DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(KPURequestResultHandler*) __request;
@end