//
//  UIGridView.h
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIGridViewDelegate;
@class UIGridViewCell;

@interface UIGridView : UITableView<UITableViewDelegate, UITableViewDataSource> {
	UIGridViewCell *tempCell;
    int row;
    int col;
    int tagId;
    float cWidth;
}

@property (nonatomic, retain) IBOutlet id<UIGridViewDelegate> uiGridViewDelegate;
@property (nonatomic, readwrite) int rows;
@property (nonatomic, readwrite) int cols;
@property (nonatomic, readwrite) int tagId;
@property (nonatomic, readwrite) float cWidth;

- (void) setUp;
- (UIGridViewCell *) dequeueReusableCell;

- (IBAction) cellPressed:(id) sender;

@end
