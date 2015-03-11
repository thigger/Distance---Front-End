//
//  PRBasicDataFormViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 27/08/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRBasicDataFormViewController.h"

#import "PRTheme.h"

#import "PRSelectionViewController.h"

#import "PRDateSelectCell.h"
#import "PRIncrementCell.h"
#import "PRTextFieldCell.h"

@interface PRBasicDataFormViewController ()

@end

@implementation PRBasicDataFormViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view setNeedsLayout];
}

#pragma mark - Form Methods

+(NSArray *)basicDataFormKeys
{
    static NSArray *keys = nil;
    
    if (keys == nil) {
        keys = @[@"Completer", @"OtherCompleter", @"DOB", @"Gender", @"Ethnicity", @"Language", @"OtherLanguage", @"StayLength"];
    }
    
    return keys;
}

-(NSArray *)generateCellInfo
{
    // save a weak reference of self to store in the dictionary to prevent retain cycles caused in self.cellInfo
    __weak PRBasicDataFormViewController *wSelf = self;
    
    NSString *tapToSelect = TDLocalizedStringWithDefaultValue(@"selection.default-placeholder", nil, nil, @"Tap to select", @"The default placeholder text for an empty selection cell.");
    
    // Completer
    NSDictionary *completerOptions = @{@"patient": TDLocalizedStringWithDefaultValue(@"basic-data.completer.option.patient", nil, nil, @"The patient", @"Patient option for who is completing the questionnaire (basic data question)."),
                                       @"family-carer": TDLocalizedStringWithDefaultValue(@"basic-data.completer.option.family-carer", nil, nil, @"A family member/carer", @"Family member / carer option for who is completing the questionnaire (basic data question)."),
                                       @"hospital-volunteer": TDLocalizedStringWithDefaultValue(@"basic-data.completer.option.hospital-volunteer", nil, nil, @"A hospital volunteer", @"Hospital volunteer option for who is completing the questionnaire (basic data question)."),
                                       @"other": TDLocalizedStringWithDefaultValue(@"basic-data.completer.option.other", nil, nil, @"Other", @"Other (i.e. free text) option for who is completing the questionnaire (basic data question).")};
    
    NSString *completerTitle = TDLocalizedStringWithDefaultValue(@"basic-data.completer.title", nil, nil, @"Are you...", @"Basic Data Question: Are you...");
    NSMutableDictionary *completerInfo = [TDSelectCell cellInfoWithTitle:completerTitle
                                                             placeholder:tapToSelect
                                                                 options:completerOptions
                                                                 details:nil
                                                                 inOrder:@[@[@"patient", @"family-carer", @"hospital-volunteer", @"other"]]
                                                                   value:nil
                                                                  andKey:@"Completer"];
    completerInfo[@"reuseIdentifier"] = @"SelectCell";
    completerInfo[@"userInfo"][@"selectionDelegate"] = wSelf;
    completerInfo[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    completerInfo[@"userInfo"][@"textField.textInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(4, 15, 4, 15)];
    completerInfo[@"userInfo"][@"textField.imageInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 15)];
    
    // Date Of Birth
    
    NSString *dobTitle = TDLocalizedStringWithDefaultValue(@"basic-data.dob.title", nil, nil, @"Date of Birth", @"Basic Data Question: Date of Birth");
    NSMutableDictionary *dobInfo = [PRDateSelectCell cellInfoWithTitle:dobTitle
                                                                 value:nil
                                                                andKey:@"DOB"];
    dobInfo[@"reuseIdentifier"] = @"DateSelectCell";
    
    NSString *genderTitle = TDLocalizedStringWithDefaultValue(@"basic-data.gender.title", nil, nil, @"Gender", @"Basic Data Question: Gender");
    NSString *genderMale = TDLocalizedStringWithDefaultValue(@"basic-data.gender.male", nil, nil, @"Male", @"Basic Data Question: Gender-Male");
    NSString *genderFemale = TDLocalizedStringWithDefaultValue(@"basic-data.gender.female", nil, nil, @"Female", @"Basic Data Question: Gender-Female");
    NSMutableDictionary *genderInfo = [TDSegmentedCell cellInfoWithTitle:genderTitle
                                                           segmentTitles:@[genderMale, genderFemale]
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
    ethnicGroupCell[@"userInfo"][@"textField.textInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(4, 15, 4, 15)];
    ethnicGroupCell[@"userInfo"][@"textField.imageInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 15)];
    
    // Language
    
    NSDictionary *languageOptions = @{@"en": @"English",
                                      @"mi": @"Mirpuri",
                                      @"ur": @"Urdu",
                                      @"other" : @"Other"};
    NSArray *languageKeys = @[@[@"en", @"mi", @"ur", @"other"]];
    
    NSMutableDictionary *languageInfo = [TDSelectCell cellInfoWithTitle:@"What is your first language?"
                                                            placeholder:tapToSelect
                                                                options:languageOptions
                                                                details:nil
                                                                inOrder:languageKeys
                                                                  value:nil
                                                                 andKey:@"Language"];
    
    languageInfo[@"reuseIdentifier"] = @"SelectCell";
    languageInfo[@"userInfo"][@"selectionDelegate"] = wSelf;
    languageInfo[@"userInfo"][@"selectionIdentifier"] = @"PRBasicSelectionVC";
    languageInfo[@"userInfo"][@"textField.textInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(4, 15, 4, 15)];
    languageInfo[@"userInfo"][@"textField.imageInsets"] = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 10)];
    
    NSString *admittedTitle = TDLocalizedStringWithDefaultValue(@"basic-data.admitted.title", nil, nil, @"How many days have you been in hospital?", @"Basic Data Question: How many days have you been in hospital?");
    
    NSMutableDictionary *admittedInfo = [PRIncrementCell cellInfoWithTitle:admittedTitle
                                                                      value:@0
                                                                     andKey:@"StayLength"];
    admittedInfo[@"reuseIdentifier"] = @"IncrementCell";

    NSMutableArray *cellInfo = [NSMutableArray array];
    [cellInfo addObject:completerInfo];
    
    // optionally add a text field if "other" is chosen for the completer
    if (showOtherCompleterOption) {
        NSString *placeholder = TDLocalizedStringWithDefaultValue(@"basic-data.othercompleter.placeholder", nil, nil, @"Enter your relation to the patient", @"The placeholder text shown in a text field when the user chooses other as the completer.");
        
        NSMutableDictionary *otherCompleterCellInfo = [TDTextFieldCell cellInfoWithTitle:nil
                                                                            placeholder:placeholder
                                                                                  value:nil
                                                                                 andKey:@"OtherCompleter"];
        otherCompleterCellInfo[@"reuseIdentifier"] = @"TextCell";
        [cellInfo addObject:otherCompleterCellInfo];
    }
    
    [cellInfo addObjectsFromArray:@[dobInfo, genderInfo, ethnicGroupCell, languageInfo]];
    
    // optionally add a text field if "other" is chosen for the users first language
    if (showOtherLanguageOption) {
        NSString *placeholder = TDLocalizedStringWithDefaultValue(@"basic-data.otherlanguage.placeholder", nil, nil, @"Enter your language", @"The placeholder text shown in a text field when the user chooses other for their first language.");
        
        NSMutableDictionary *otherLanguageCellInfo = [TDTextFieldCell cellInfoWithTitle:nil
                                                                            placeholder:placeholder
                                                                                  value:nil
                                                                                 andKey:@"OtherLanguage"];
        otherLanguageCellInfo[@"reuseIdentifier"] = @"TextCell";
        
        [cellInfo addObject:otherLanguageCellInfo];
    }
    
    [cellInfo addObject:admittedInfo];
    
    return @[cellInfo];
}

-(void)cellValueChanged:(TDCell *)cell
{
    [super cellValueChanged:cell];
    
    if ([cell.key isEqualToString:@"Language"]) {
        showOtherLanguageOption = [cell.value isEqualToString:@"Other"];
        [self reloadForm];
    } else if ([cell.key isEqualToString:@"Completer"]) {
        NSString *otherOptionString = TDLocalizedStringWithDefaultValue(@"basic-data.completer.option.other", nil, nil, nil, nil);
        showOtherCompleterOption = [cell.value isEqualToString:otherOptionString];
        [self reloadForm];
    }
}

#pragma mark - SelectionCell Delegate Methods

-(void)selectionCell:(TDSelectCell *)cell requestsPresentationOfSelectionViewController:(TDSelectionViewController *)selectionVC
{
    if ([selectionVC isKindOfClass:[PRSelectionViewController class]]) {

        NSIndexPath *selectedPath = [self indexPathForFormKey:cell.key];
        NSDictionary *selectedCellInfo = self.cellInfo[selectedPath.section][selectedPath.row];
        
        PRSelectionViewController *prSelection = (PRSelectionViewController *) selectionVC;
        
        // force load the view to configure its subclasses
        if (prSelection.view != nil) {
            prSelection.titleLabel.text = selectedCellInfo[@"title"];
            prSelection.subTitleLabel.text = @"Please select from the options below.";
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentViewController:prSelection animated:YES completion:nil];
            }];
        }
    }
}

-(CGFloat)selectionViewController:(TDSelectionViewController *)selectionVC heightForHeaderInSection:(NSInteger)section
{
    if ([selectionVC.key isEqualToString:@"Ethnicity"]) {
        NSString *thisSectionTitle = selectionVC.sectionTitles[section];
        
        UIView *view = [self createHeaderWithTitle:thisSectionTitle];
        CGSize layoutSize = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        return layoutSize.height + 2.0;
    }
    
    return 0;
}

-(UIView *)selectionViewController:(TDSelectionViewController *)selectionVC viewForHeaderInSection:(NSInteger)section
{
    if ([selectionVC.key isEqualToString:@"Ethnicity"]) {
        NSString *thisSectionTitle = selectionVC.sectionTitles[section];
        
        UIView *view = [self createHeaderWithTitle:thisSectionTitle];
        
        return view;
    }
    
    return nil;
}

-(UIView *)createHeaderWithTitle:(NSString *) title
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.TDTextStyleIdentifier = @"SubHeadline";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = [[PRTheme sharedTheme] mainColor];
    [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [view addSubview:label];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(15)-[label]-(15)-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"label": label}]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[label]-(8)-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"label": label}]];
    
    [self applyThemeToView:view];
    //[view layoutIfNeeded];
    
    return view;
}

@end
