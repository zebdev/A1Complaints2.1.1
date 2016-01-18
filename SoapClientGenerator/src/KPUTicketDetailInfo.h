//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 23-03-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class KPUAttachmentInfo;
@class KPUHelper;
#import "KPURequestResultHandler.h"
#import "DDXML.h"



@interface KPUTicketDetailInfo : NSObject <KPUISerializableObject>


@property (retain,nonatomic,getter=getObjAttachment) KPUAttachmentInfo* objAttachment;

@property (retain,nonatomic,getter=getPKTicketDetailId) NSNumber* PKTicketDetailId;

@property (retain,nonatomic,getter=getFKTicketId) NSNumber* FKTicketId;

@property (nonatomic,getter=getFKLocationId) int FKLocationId;

@property (retain,nonatomic,getter=getFKEngineerId) NSNumber* FKEngineerId;

@property (retain,nonatomic,getter=getFKCompanyId) NSNumber* FKCompanyId;

@property (nonatomic,getter=getUpdatedBy) int UpdatedBy;

@property (retain,nonatomic,getter=getFKCustomerId) NSNumber* FKCustomerId;

@property (retain,nonatomic,getter=getFKTicketStatusId) NSNumber* FKTicketStatusId;

@property (retain,nonatomic,getter=getFKTicketSubStateId) NSNumber* FKTicketSubStateId;

@property (retain,nonatomic,getter=getDescription) NSString* Description;

@property (retain,nonatomic,getter=getTimeStamp) NSString* TimeStamp;

@property (nonatomic,getter=getIsPrivate) BOOL IsPrivate;

@property (retain,nonatomic,getter=getRealName) NSString* RealName;

@property (retain,nonatomic,getter=getFileName) NSString* FileName;

@property (nonatomic,getter=getIsPublic) BOOL IsPublic;

@property (nonatomic,getter=getPKAttachmentId) int PKAttachmentId;

@property (nonatomic,getter=getIsCheckedAll) BOOL IsCheckedAll;

@property (nonatomic,getter=getFKDepartmentID) int FKDepartmentID;

@property (nonatomic,getter=getFKResellerId) int FKResellerId;

@property (retain,nonatomic,getter=getEmailAddress) NSString* EmailAddress;

@property (retain,nonatomic,getter=getTicketTitle) NSString* TicketTitle;

@property (retain,nonatomic,getter=getAgentType) NSNumber* AgentType;

@property (nonatomic,getter=getIsTicketPicked) BOOL IsTicketPicked;

@property (nonatomic,getter=getIsTicketAccepted) BOOL IsTicketAccepted;

@property (retain,nonatomic,getter=getSMSMessageID) NSString* SMSMessageID;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
+(KPUTicketDetailInfo*) createWithXml:(DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(KPURequestResultHandler*) __request;
@end