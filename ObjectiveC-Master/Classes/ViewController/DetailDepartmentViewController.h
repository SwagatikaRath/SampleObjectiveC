//
//  DetailDepartmentViewController.h
//  ObjectiveC-Master
//
//  Created by Swagatika on 11/5/15.
//  Copyright © 2015 swagatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
#import "DepartmentTableViewController.h"

@protocol DetailDepartmentViewControllerDelegate;


@interface DetailDepartmentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *deptName;
@property (weak, nonatomic) IBOutlet UITextField *empName;
@property (weak, nonatomic) IBOutlet UITextField *clientName;
@property (weak, nonatomic) IBOutlet UITextField *experience;

@property(nonatomic,strong)Department *currentDepartment;
@property(nonatomic,weak)id <DetailDepartmentViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end

@protocol DetailDepartmentViewControllerDelegate

-(void)addDetailViewControllerDidSave;
-(void)cancelDetailViewControllerDidCancel:(Department*)deleteDepartment;

@end