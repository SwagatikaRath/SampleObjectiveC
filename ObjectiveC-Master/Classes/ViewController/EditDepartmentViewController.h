//
//  EditDepartmentViewController.h
//  ObjectiveC-Master
//
//  Created by Swagatika on 11/5/15.
//  Copyright © 2015 swagatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
#import "DepartmentTableViewController.h"

@interface EditDepartmentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *deptName;
@property (weak, nonatomic) IBOutlet UITextField *empName;
@property (weak, nonatomic) IBOutlet UITextField *clientName;
@property (weak, nonatomic) IBOutlet UITextField *experience;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property(nonatomic,strong)Department *currentDepartment;
- (IBAction)edit:(id)sender;

- (IBAction)done:(id)sender;

@end
