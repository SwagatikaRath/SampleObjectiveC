//
//  Department+CoreDataProperties.h
//  ObjectiveC-Master
//
//  Created by Swagatika on 11/5/15.
//  Copyright © 2015 swagatika. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Department.h"

NS_ASSUME_NONNULL_BEGIN

@interface Department (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *departmentName;
@property (nullable, nonatomic, retain) NSString *employeeName;
@property (nullable, nonatomic, retain) NSString *currentClient;
@property (nullable, nonatomic, retain) NSNumber *yearsOfExperience;

@end

NS_ASSUME_NONNULL_END
