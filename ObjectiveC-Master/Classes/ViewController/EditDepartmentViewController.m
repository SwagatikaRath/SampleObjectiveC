//
//  EditDepartmentViewController.m
//  ObjectiveC-Master
//
//  Created by Swagatika on 11/5/15.
//  Copyright © 2015 swagatika. All rights reserved.
//

#import "EditDepartmentViewController.h"
#import "AppDelegate.h"

@interface EditDepartmentViewController ()

@end

@implementation EditDepartmentViewController
@synthesize deptName,empName,clientName,experience,editButton,doneButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.deptName.text = [self.currentDepartment departmentName];
    self.empName.text = [self.currentDepartment employeeName];
    self.clientName.text = [self.currentDepartment currentClient];
    
    deptName.userInteractionEnabled = NO;
    empName.userInteractionEnabled = NO;
    clientName.userInteractionEnabled = NO;
    experience.userInteractionEnabled = NO;
    doneButton.userInteractionEnabled = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)edit:(id)sender {
    deptName.userInteractionEnabled = YES;
    empName.userInteractionEnabled = YES;
    clientName.userInteractionEnabled = YES;
    experience.userInteractionEnabled = YES;
    doneButton.userInteractionEnabled = YES;
    editButton.hidden = YES;
    
    deptName.borderStyle = UITextBorderStyleRoundedRect;
    empName.borderStyle = UITextBorderStyleRoundedRect;
    clientName.borderStyle = UITextBorderStyleRoundedRect;
    experience.borderStyle = UITextBorderStyleRoundedRect;
}

- (IBAction)done:(id)sender {
    deptName.userInteractionEnabled = NO;
    empName.userInteractionEnabled = NO;
    clientName.userInteractionEnabled = NO;
    experience.userInteractionEnabled = NO;
    doneButton.userInteractionEnabled = NO;
    editButton.hidden = NO;
    
    deptName.borderStyle = UITextBorderStyleNone;
    empName.borderStyle = UITextBorderStyleNone;
    clientName.borderStyle = UITextBorderStyleNone;
    experience.borderStyle = UITextBorderStyleNone;
    
    self.currentDepartment.departmentName = deptName.text;
    self.currentDepartment.employeeName = empName.text;
    self.currentDepartment.currentClient = clientName.text;
  //  self.currentDepartment.yearsOfExperience = experience.text;
    
    AppDelegate *myApp = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [myApp saveContext];
}
@end
