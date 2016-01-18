//----------------------------------------------------
//
// Generated by www.easywsdl.com
// Version: 4.1.5.2
//
// Created by Quasar Development at 23-03-2015
//
//---------------------------------------------------


#import <Foundation/Foundation.h>

@class KPUHelper;
#import "KPURequestResultHandler.h"
#import "DDXML.h"



@interface KPUTicketProblemTypeInfo : NSObject <KPUISerializableObject>


@property (retain,nonatomic,getter=getPKTicketProblemTypeId) NSNumber* PKTicketProblemTypeId;

@property (retain,nonatomic,getter=getTicketProblemTypeName) NSString* TicketProblemTypeName;

@property (nonatomic,getter=getIsDefault) BOOL IsDefault;

@property (nonatomic,getter=getFKTicketProblemTypeId) int FKTicketProblemTypeId;

@property (nonatomic,getter=getAssetRequired) int AssetRequired;

@property (nonatomic,getter=getIsActive) BOOL IsActive;

@property (nonatomic,getter=getIsStandardWorkRequest) BOOL IsStandardWorkRequest;

@property (retain,nonatomic,getter=getDepartmentIds) NSString* DepartmentIds;

@property (retain,nonatomic,getter=getFKAssetCategoryId) NSNumber* FKAssetCategoryId;

@property (nonatomic,getter=getLocationdependant) BOOL locationdependant;

@property (nonatomic,getter=getFKdepartmentid) int fKdepartmentid;

@property (nonatomic,getter=getFKserviceid) int fKserviceid;
-(id)init;
-(id)initWithXml: (DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
+(KPUTicketProblemTypeInfo*) createWithXml:(DDXMLElement*)__node __request:(KPURequestResultHandler*) __request;
-(void) serialize:(DDXMLElement*)__parent __request:(KPURequestResultHandler*) __request;
@end