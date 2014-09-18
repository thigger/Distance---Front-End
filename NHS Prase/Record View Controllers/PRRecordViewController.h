//
//  PRRecordViewController.h
//  NHS Prase
//
//  Created by Josh Campion on 29/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRSegmentTabViewController.h"

@class PRRecord;
@class PRQuestionnaire;

@interface PRRecordViewController : PRSegmentTabViewController <UIAlertViewDelegate>
{
    IBOutlet UIView *progressFooter;
    IBOutlet UIProgressView *progressView;
    IBOutlet UILabel *progressLabel;
}

@property (nonatomic, strong) PRRecord *record;

-(IBAction)goHome:(id)sender;

@end
