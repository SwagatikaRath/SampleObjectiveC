//
//  DepartmentTableViewController.h
//  ObjectiveC-Master
//
//  Created by Swagatika on 11/5/15.
//  Copyright © 2015 swagatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
#import "Department+CoreDataProperties.h"
#import "DetailDepartmentViewController.h"
#import <CoreData/CoreData.h>


@interface DepartmentTableViewController : UITableViewController <UISearchControllerDelegate,UISearchBarDelegate,UISearchResultsUpdating,NSFetchedResultsControllerDelegate>

@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultControler;

@end
