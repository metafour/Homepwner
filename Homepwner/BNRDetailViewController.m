//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Camron Schwoegler on 1/13/15.
//  Copyright (c) 2015 metafour.org. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateField;

@end

@implementation BNRDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.valueField.keyboardType = UIKeyboardTypeNumberPad;
  self.nameField.delegate = self;
  self.serialField.delegate = self;
  self.valueField.delegate = self;
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated
{
  
  [super viewWillAppear:animated];
  
  // If there's already a class property that holds this item, an instance
  // variable, why a local variable as well?
  BNRItem *item = self.item;
  
  self.nameField.text = item.itemName;
  self.serialField.text = item.serialNumber;
  self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.timeStyle = NSDateFormatterMediumStyle;
  dateFormatter.dateStyle = NSDateFormatterMediumStyle;
  
  self.dateField.text = [dateFormatter stringFromDate:item.dateCreated];
  
}



- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  [self.view endEditing:YES];
  
  // Save changes to item
  BNRItem *item = self.item;
  
  item.itemName = self.nameField.text;
  item.serialNumber = self.serialField.text;
  item.valueInDollars = [self.valueField.text intValue];
}



#pragma mark - UITextField Delegate Methods



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:textField action:@selector(resignFirstResponder)];
  
  self.navigationItem.rightBarButtonItem = doneButton;
  
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  self.navigationItem.rightBarButtonItem = nil;
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  
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
