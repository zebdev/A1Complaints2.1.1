//
//  FileIO.h
//  YachtSwipe
//
//  Created by wit on 12/20/11.
//  Copyright (c) 2011 Yillin IT co.ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/** position of data save int  */
#define			POS_INT		0

/** stage data saving position */
#define			POS_SAVE	200

#define			POS_REV		5300



@interface FileIO : NSObject {
	
	NSFileHandle *m_pFileHandle;
	NSString     *m_strFilePath;
}

-(id)   initFileIO;

-(void) writeInt:(int) data_no : (int) value;
-(int)  readInt :(int) data_no;

-(void)	writeFloat:(int) data_no : (float) value;
-(float)readFloat :(int) data_no;


-(void) writeBool:(int) position :(BOOL) valu;
-(BOOL) readBool :(int) position;

-(void) writeString:(int) position Data:(NSString*) value;
-(NSString*) readString :(int) position Length:(int) length;

-(void) writeBytes:(int) position :(Byte*) value :(int) length;
-(void) readBytes :(int) position :(Byte*) dest :(int) length;

+(int)  getNowDate:(int) type;

-(void) openFile:(BOOL) bRead;
-(void) closeFile;

@end
