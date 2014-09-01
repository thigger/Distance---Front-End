//
//  PRQuestionOptionsViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionOptionsViewController.h"

#import "PRQuestionOptions.h"

#import "PROptionCollectionViewCell.h"

@interface PRQuestionOptionsViewController ()

@end

@implementation PRQuestionOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    titleLabel.text = optionsQuestion.questionTitle;
}

-(void)setQuestion:(PRQuestion *)question
{
    if ([question isKindOfClass:[PRQuestionOptions class]]) {
        [super setQuestion:question];
        optionsQuestion = (PRQuestionOptions *) question;
        
        titleLabel.text = optionsQuestion.questionTitle;
        
        [self.collectionView reloadData];
    }
}

#pragma mark - CollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (optionsQuestion.showsNA) {
        return 2;
    }
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 1) {
        // two cells for NA and prefer not to answer
        return 2;
    } else {
        return optionsQuestion.options.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PROptionCollectionViewCell *optionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OptionCell" forIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        NSString *title = nil;
        
        switch (indexPath.row) {
            case 0:
                title = @"Not Applicable";
                break;
            case 1:
                title = @"Prefer not to answer";
                break;
            default:
                break;
        }
        
        [optionCell setOptionTitle:title andImage:nil];
    } else {
        NSDictionary *thisOption = optionsQuestion.options[indexPath.row];
        
        [optionCell setOptionTitle:thisOption[@"title"] andImage:thisOption[@"image"]];
    }
    
    return optionCell;
}

#pragma mark - Collection Delegate


-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"Selecting: %@", indexPath);
    NSArray *currentSelections = [collectionView indexPathsForSelectedItems];
    // NSLog(@"Selections: %@", currentSelections);
    
    for (NSIndexPath *selected in currentSelections) {
        if ([indexPath isEqual:selected]) {
            [collectionView deselectItemAtIndexPath:indexPath animated:NO];
            return NO;
        }
    }
    
    return YES;
}

@end
