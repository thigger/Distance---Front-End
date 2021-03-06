//
//  PRGoodWardSelectViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 19/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRGoodWardSelectViewController.h"

#import <MagicalRecord/MagicalRecord.h>

#import "PRWard.h"
#import "PRHospital.h"
#import "PRTrust.h"

#import "PRRecord.h"
#import "PRWardSelectViewController.h"

@interface PRGoodWardSelectViewController ()

@end

@implementation PRGoodWardSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    childSelect = self.childViewControllers.firstObject;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    childSelect.selectedTrust = self.selectedWard.hospital.trust;
    childSelect.selectedHospital = self.selectedWard.hospital;
    childSelect.selectedWard = self.selectedWard;
    
    // don't overwrite the current ward, instead load a new custom selection
    /*
    if (childSelect.selectedWard.id.integerValue < -1) {
        PRWard *blankWard = [childSelect blankCustomWard];
        childSelect.selectedWard = blankWard;
    }
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dismissSelectionViewController:(id)sender
{
    BOOL validWard = [childSelect validateSelectedWard];
    
    [childSelect commitCustomWard];
    
    if (validWard) {
        self.selectedWard = childSelect.selectedWard;
        [super dismissSelectionViewController:sender];
    }
}

@end
