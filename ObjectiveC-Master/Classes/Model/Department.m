//
//  Department.m
//  ObjectiveC-Master
//
//  Created by Swagatika on 11/5/15.
//  Copyright © 2015 swagatika. All rights reserved.
//

#import "Department.h"
NSString *const DepartmentName = @"Department";
NSString *const EmployeeName = @"Employee";
NSString *const ClientName = @"Client";

@implementation Department

// Insert code here to add functionality to your managed object subclass
+ (NSArray *)scopeNames {
    static NSArray *scopeTypeNames = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        scopeTypeNames = @[DepartmentName, EmployeeName, ClientName];
    });
    
    return scopeTypeNames;
}

@end
