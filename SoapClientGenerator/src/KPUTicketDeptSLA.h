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
@class KPUTicketDeptSLA_TicketAttributes;
@class KPUHelper;
#import "KPURequestResultHandler.h"
#import "DDXML.h"



@interface KPUTicketDeptSLA : NSObject <KPUISerializableObject>


@property (retain,nonatomic,getter=getObjAttachment) KPUAttachmentInfo* objAttachment;

@property (retain,nonatomic,getter=getTicketAttributes) KPUTicketDeptSLA_TicketAttributes* TicketAttributes;

@property (retain,nonatomic,getter=getAssetName) NSString* AssetName;

@property (retain,nonatomic,getter=getDeptName) NSString* DeptName;

@property (retain,nonatomic,getter=getSharedWith) NSString* SharedWith;

@property (retain,nonatomic,getter=getPKTicketId) NSNumber* PKTicketId;

@property (retain,nonatomic,getter=getFKAssetId) NSNumber* FKAssetId;

@property (retain,nonatomic,getter=getFKCustomerId) NSNumber* FKCustomerId;

@property (retain,nonatomic,getter=getFKTicketTypeId) NSNumber* FKTicketTypeId;

@property (retain,nonatomic,getter=getFKTicketProblemTypeId) NSNumber* FKTicketProblemTypeId;

@property (retain,nonatomic,getter=getFKTicketPriorityId) NSNumber* FKTicketPriorityId;

@property (nonatomic,getter=getFKAssetCategoryId) int FKAssetCategoryId;

@property (retain,nonatomic,getter=getFKCreateEngineerId) NSNumber* FKCreateEngineerId;

@property (retain,nonatomic,getter=getFKCreateCompanyId) NSNumber* FKCreateCompanyId;

@property (retain,nonatomic,getter=getFKCreateResellerId) NSNumber* FKCreateResellerId;

@property (nonatomic,getter=getAddedBy) int AddedBy;

@property (retain,nonatomic,getter=getTicketCreated) NSDate* TicketCreated;

@property (retain,nonatomic,getter=getTicketTitle) NSString* TicketTitle;

@property (retain,nonatomic,getter=getTicketDescription) NSString* TicketDescription;

@property (retain,nonatomic,getter=getTicketDetailDescription) NSString* TicketDetailDescription;

@property (retain,nonatomic,getter=getResponseSLA) NSNumber* ResponseSLA;

@property (retain,nonatomic,getter=getResolutionSLA) NSNumber* ResolutionSLA;

@property (nonatomic,getter=getIsAlerted) BOOL IsAlerted;

@property (retain,nonatomic,getter=getTicketStatusName) NSString* TicketStatusName;

@property (retain,nonatomic,getter=getBCustomerName) NSString* BCustomerName;

@property (retain,nonatomic,getter=getEngineerName) NSString* EngineerName;

@property (retain,nonatomic,getter=getLastChanged) NSDate* LastChanged;

@property (nonatomic,getter=getResponseSLAOriginal) int ResponseSLAOriginal;

@property (nonatomic,getter=getResolutionSLAOriginal) int ResolutionSLAOriginal;

@property (retain,nonatomic,getter=getTicketPriorityExtension) NSString* TicketPriorityExtension;

@property (retain,nonatomic,getter=getTicketPriorityName) NSString* TicketPriorityName;

@property (nonatomic,getter=getBusiness) BOOL Business;

@property (retain,nonatomic,getter=getTableColor) NSString* TableColor;

@property (retain,nonatomic,getter=getCustomerName) NSString* CustomerName;

@property (retain,nonatomic,getter=getTicketSubStateName) NSString* TicketSubStateName;

@property (nonatomic,getter=getFKCompanyId) int FKCompanyId;

@property (nonatomic,getter=getFKEngineerId) int FKEngineerId;

@property (retain,nonatomic,getter=getOverdueResolutionSLA) NSDate* OverdueResolutionSLA;

@property (nonatomic,getter=getOverdueResponseSLA) int OverdueResponseSLA;

@property (retain,nonatomic,getter=getTicketType) NSString* TicketType;

@property (retain,nonatomic,getter=getProblemCategory) NSString* ProblemCategory;

@property (retain,nonatomic,getter=getAssetCategoryName) NSString* AssetCategoryName;

@property (retain,nonatomic,getter=getCreatedBy) NSString* CreatedBy;

@property (nonatomic,getter=getTargetResponseSLA) int TargetResponseSLA;

@property (nonatomic,getter=getTargetResolutionSLA) int TargetResolutionSLA;

@property (nonatomic,getter=getActualResponseSLA) int ActualResponseSLA;

@property (retain,nonatomic,getter=getActualResolutionSLA) NSDate* ActualResolutionSLA;

@property (retain,nonatomic,getter=getLastActiveIP) NSString* LastActiveIP;

@property (retain,nonatomic,getter=getLastUpdatedBy) NSString* LastUpdatedBy;

@property (retain,nonatomic,getter=getLanguage) NSString* Language;

@property (nonatomic,getter=getTotalUnassignedTime) int TotalUnassignedTime;

@property (nonatomic,getter=getTotalActionTime) int TotalActionTime;

@property (nonatomic,getter=getTotalWaitingTime) int TotalWaitingTime;

@property (retain,nonatomic,getter=getTimeAssigned) NSDate* TimeAssigned;

@property (retain,nonatomic,getter=getTimeResolved) NSDate* TimeResolved;

@property (retain,nonatomic,getter=getTimeClosed) NSDate* TimeClosed;

@property (retain,nonatomic,getter=getResolutionSLAName) NSString* ResolutionSLAName;

@property (retain,nonatomic,getter=getResponseSLAName) NSString* ResponseSLAName;

@property (nonatomic,getter=getFKLastUserId) int FKLastUserId;

@property (nonatomic,getter=getFKLastUserType) int FKLastUserType;

@property (nonatomic,getter=getCurrency) int Currency;

@property (retain,nonatomic,getter=getCurrencySymbol) NSString* CurrencySymbol;

@property (retain,nonatomic,getter=getBillRate) NSString* BillRate;

@property (retain,nonatomic,getter=getAdditionalText) NSString* AdditionalText;

@property (retain,nonatomic,getter=getInvoiceNumber) NSString* InvoiceNumber;

@property (nonatomic,getter=getBillType) int BillType;

@property (nonatomic,getter=getDefaultCurrency) int DefaultCurrency;

@property (retain,nonatomic,getter=getDefaultCurrencySymbol) NSString* DefaultCurrencySymbol;

@property (nonatomic,getter=getTicketVerified) BOOL TicketVerified;

@property (retain,nonatomic,getter=getUpdateActionTime) NSString* UpdateActionTime;

@property (nonatomic,getter=getFKRelatedTicketId) int FKRelatedTicketId;

@property (nonatomic,getter=getRelatedTicketCount) int RelatedTicketCount;

@property (nonatomic,getter=getIsTicketBillable) BOOL IsTicketBillable;

@property (nonatomic,getter=getEstimatedTime) int EstimatedTime;

@property (nonatomic,getter=getFkSWRTicketID) int FkSWRTicketID;

@property (nonatomic,getter=getFKDepartmentID) int FKDepartmentID;

@property (nonatomic,getter=getFkSWRID) int FkSWRID;

@property (nonatomic,getter=getFKCurrencyId) int FKCurrencyId;

@property (retain,nonatomic,getter=getScreenName) NSString* ScreenName;

@property (retain,nonatomic,getter=getCallmeNumber) NSString* CallmeNumber;

@property (retain,nonatomic,getter=getCallmeDescription) NSString* CallmeDescription;

@property (retain,nonatomic,getter=getCallmeTime) NSDate* CallmeTime;

@property (nonatomic,getter=getRequestVisitTime) int RequestVisitTime;

@property (nonatomic,getter=getOptionalTicketReference) int OptionalTicketReference;

@property (nonatomic,getter=getTicketPoints) int TicketPoints;

@property (nonatomic,getter=getAgentPoints) int AgentPoints;

@property (nonatomic,getter=getTicketRating) int TicketRating;

@property (retain,nonatomic,getter=getCustomerTVID) NSString* CustomerTVID;

@property (retain,nonatomic,getter=getCustomerTVPassword) NSString* CustomerTVPassword;

@property (retain,nonatomic,getter=getCurrentPeriod) NSNumber* CurrentPeriod;

@property (nonatomic,getter=getTimeout) int Timeout;

@property (retain,nonatomic,getter=getKeywords) NSString* Keywords;

@property (nonatomic,getter=getIsFixedPoints) BOOL IsFixedPoints;

@property (nonatomic,getter=getAdditionalPoints) int AdditionalPoints;

@property (nonatomic,getter=getAdditionalMinutes) int AdditionalMinutes;

@property (nonatomic,getter=getInitialMinutes) int InitialMinutes;

@property (nonatomic,getter=getEAdditionalPoints) int EAdditionalPoints;

@property (nonatomic,getter=getEAdditionalMinutes) int EAdditionalMinutes;

@property (nonatomic,getter=getEInitialMinutes) int EInitialMinutes;

@property (nonatomic,getter=getChargedInterval) int ChargedInterval;

@property (nonatomic,getter=getEarnedInterval) int EarnedInterval;

@property (nonatomic,getter=getPointsCharged) int PointsCharged;

@property (nonatomic,getter=getPointsEarned) int PointsEarned;

@property (retain,nonatomic,getter=getToken) NSString* Token;

@property (retain,nonatomic,getter=getVisitDate) NSDate* VisitDate;

@property (retain,nonatomic,getter=getFKTicketStatusID) NSNumber* FKTicketStatusID;

@property (retain,nonatomic,getter=getVisitAddress) NSString* VisitAddress;

@property (retain,nonatomic,getter=getCNameForFreelancer) NSString* CNameForFreelancer;

@property (nonatomic,getter=getIsThrownToPool) BOOL IsThrownToPool;

@property (retain,nonatomic,getter=getPSATicketTypeSettingName) NSString* PSATicketTypeSettingName;

@property (nonatomic,getter=getCustomerResellerID) int CustomerResellerID;

@property (retain,nonatomic,getter=getExpertMultiplier) NSNumber* ExpertMultiplier;

@property (retain,nonatomic,getter=getCustomerMultiplier) NSNumber* CustomerMultiplier;

@property (nonatomic,getter=getIsPSATicket) BOOL IsPSATicket;

@property (nonatomic,getter=getChatterID) int ChatterID;

@property (nonatomic,getter=getChatTicketID) int ChatTicketID;

@property (nonatomic,getter=getFklocationid) int fklocationid;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
+(KPUTicketDeptSLA*) createWithXml:(DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(KPURequestResultHandler*) __request;
@end