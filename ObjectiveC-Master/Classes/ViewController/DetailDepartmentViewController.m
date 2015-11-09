//
//  DetailDepartmentViewController.m
//  ObjectiveC-Master
//
//  Created by Swagatika on 11/5/15.
//  Copyright © 2015 swagatika. All rights reserved.
//

#import "DetailDepartmentViewController.h"

@interface DetailDepartmentViewController ()

@end

@implementation DetailDepartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deptName.text = [self.currentDepartment departmentName];
    self.empName.text = [self.currentDepartment employeeName];
    self.clientName.text = [self.currentDepartment currentClient];
    self.experience.text = [[self.currentDepartment yearsOfExperience]stringValue];
    
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

- (IBAction)cancel:(id)sender {
    //dismiss and remove the object
    [self.delegate cancelDetailViewControllerDidCancel:self.currentDepartment];
}

- (IBAction)save:(id)sender {
    //dismiss and save the object
    self.currentDepartment.departmentName = self.deptName.text;
    self.currentDepartment.employeeName = self.empName.text;
    self.currentDepartment.currentClient = self.clientName.text;
    self.currentDepartment.yearsOfExperience = @([self.experience.text integerValue]);
    
    [self.delegate addDetailViewControllerDidSave];
}
@end
