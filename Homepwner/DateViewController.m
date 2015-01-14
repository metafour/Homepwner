//
//  DateViewController.m
//  Homepwner
//
//  Created by Camron Schwoegler on 1/14/15.
//  Copyright (c) 2015 metafour.org. All rights reserved.
//

#import "DateViewController.h"
#import "BNRItem.h"

@interface DateViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DateViewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  BNRItem *item = self.item;
  
  [self.datePicker setDate:item.dateCreated animated:YES];
  
  [self.datePicker addTarget:self action:@selector(updateDate:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Custom Methods

- (void)updateDate:(id)sender
{
  self.item.dateCreated = self.datePicker.date;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
