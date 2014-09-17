//
//  PRBasicDataFormViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRBasicDataFormViewController.h"

#import "PRDateSelectCell.h"
#import "PRIncrementCell.h"
#import "PRSelectionViewController.h"

@interface PRBasicDataFormViewController ()

@end

@implementation PRBasicDataFormViewController

-(NSArray *)generateCellInfo
{
    // save a weak reference of self to store in the dictionary to prevent retain cycles caused in self.cellInfo
    __weak PRBasicDataFormViewController *wSelf = self;
    
    NSMutableDictionary *dobInfo = [PRDateSelectCell cellInfoWithTitle:@"Date of Birth"
                                                                 value:nil
                                                                andKey:@"DOB"];
    dobInfo[@"reuseIdentifier"] = @"DateSelectCell";
    dobInfo[@"userInfo"][@"formatter"] = self.dateFormatter;
    
    NSMutableDictionary *genderInfo = [TDSegmentedCell cellInfoWithTitle:@"Gender"
                                                           segmentTitles:@[@"Male", @"Female"]
                                                                   value:nil
                                                                  andKey:@"Gender"];
    genderInfo[@"reuseIdentifier"] = @"SegmentCell";
    
    // Ethnicity
    
    NSArray *ethnicSections = @[@"White", @"Black or Black British", @"Asian or Asian British", @"Chinese", @"Mixed", @"Other"];
    
    NSDictionary *ethnicOptions = @{@"british" : @"British",
                                    @"irish" : @"Irish",
                                    @"other white" : @"Other",
                                    @"african": @"African",
                                    @"caribbean": @"Caribbean",
                                    @"other black": @"Other background",
                                    @"indian": @"Indian",
                                    @"pakistani": @"Pakistani",
                                    @"bangladeshi": @"Bangladeshi",
                                    @"other asian": @"Other background",
                                    @"chinese": @"Chinese",
                                    @"white+asian": @"White & Asian",
                                    @"white+black african": @"White & Black African",
                                    @"white+black caribbean": @"White & Black Caribbean",
                                    @"other mixed": @"Other mixed background",
                                    @"other other": @"Other ethnic background"};
    
    NSArray *ethnicKeys = @[@[@"british", @"irish", @"other white"],
                            @[@"african", @"caribbean", @"other black"],
                            @[@"indian", @"pakistani", @"bangladeshi", @"other asian"],
                            @[@"chinese"],
                            @[@"white+asian", @"white+black african", @"white+black caribbean", @"other mixed",],
                            @[@"other other"]];
    
    NSMutableDictionary *ethnicGroupCell = [TDSelectCell cellInfoWithTitle:@"How would you describe your ethnic group?"
                                                               placeholder:@"Tap to select"
                                                                   options:ethnicOptions
                                                                   details:nil
                                                                   inOrder:ethnicKeys
                                                                     value:nil
                                                                    andKey:@"Ethnicity"];
    
    ethnicGroupCell[@"reuseIdentifier"] = @"SelectCell";
    ethnicGroupCell[@"userInfo"][@"selectionDelegate"] = wSelf;
    ethnicGroupCell[@"userInfo"][@"selectionVCInfo"] = @{@"sectionTitles": ethnicSections};
    ethnicGroupCell[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    
    // Language
    
    NSDictionary *languageOptions = @{@"en": @"English",
                                      @"mi": @"Mirpuri",
                                      @"ur": @"Urdu",
                                      @"other" : @"Other"};
    NSArray *languageKeys = @[@[@"en", @"mi", @"ur", @"other"]];
    
    NSMutableDictionary *languageInfo = [TDSelectCell cellInfoWithTitle:@"What is your first language?"
                                                            placeholder:@"Tap to select"
                                                                options:languageOptions
                                                                details:nil
                                                                inOrder:languageKeys
                                                                  value:nil
                                                                 andKey:@"Language"];
    
    languageInfo[@"reuseIdentifier"] = @"SelectCell";
    languageInfo[@"userInfo"][@"selectionDelegate"] = wSelf;
    languageInfo[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    
    NSMutableDictionary *admittedInfo = [PRDateSelectCell cellInfoWithTitle:@"When were you admitted to the hospital?"
                                                                      value:[NSDate date]
                                                                     andKey:@"Admitted"];
    admittedInfo[@"reuseIdentifier"] = @"DateSelectCell";
    admittedInfo[@"userInfo"][@"formatter"] = self.dateFormatter;
    
    NSMutableDictionary *inpatientInfo = [PRIncrementCell cellInfoWithTitle:@"How many times have you been an inpatient at this hospital in the past 5 years?"
                                                                      value:@0
                                                                     andKey:@"InpatientCount"];
    inpatientInfo[@"reuseIdentifier"] = @"IncrementCell";
    
    NSMutableDictionary *ongoingTreatmentInfo = [TDSegmentedCell cellInfoWithTitle:@"Are you receiving any ongoing treatment elsewhere in the hospital?"
                                                                     segmentTitles:@[@"Yes", @"No"]
                                                                             value:@1
                                                                            andKey:@"OngoingTreatment"];
    ongoingTreatmentInfo[@"reuseIdentifier"] = @"SegmentCell";
    
    return @[@[dobInfo, genderInfo, ethnicGroupCell, languageInfo, admittedInfo, inpatientInfo, ongoingTreatmentInfo]];
}

-(NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *formatter = nil;
    
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    return formatter;
}

#pragma mark - SelectionCell Delegate Methods

-(void)selectionCell:(TDSelectCell *)cell requestsPresentationOfSelectionViewController:(TDSelectionViewController *)selectionVC
{
    if ([selectionVC isKindOfClass:[PRSelectionViewController class]]) {

        NSIndexPath *selectedPath = [self indexPathForFormKey:cell.key];
        NSDictionary *selectedCellInfo = self.cellInfo[selectedPath.section][selectedPath.row];
        
        PRSelectionViewController *prSelection = (PRSelectionViewController *) selectionVC;
        
        // force load the view to configure its subclasses
        UIView *selectionView = prSelection.view;
        prSelection.titleLabel.text = selectedCellInfo[@"title"];
        prSelection.subTitleLabel.text = @"Please select from the options below.";
        prSelection.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self presentViewController:prSelection animated:YES completion:nil];
        }];
    }
}

@end
