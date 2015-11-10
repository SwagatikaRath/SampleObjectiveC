//
//  DepartmentTableViewController.m
//  ObjectiveC-Master
//
//  Created by Swagatika on 11/5/15.
//  Copyright © 2015 swagatika. All rights reserved.
//

#import "DepartmentTableViewController.h"
#import "EditDepartmentViewController.h"
#import "ResultsTableViewController.h"

@interface DepartmentTableViewController () <DetailDepartmentViewControllerDelegate>
@property(nonatomic,strong)NSMutableArray *searchResultArray;
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;
@property(nonatomic,strong)NSFetchRequest *searchFetch;

@end

@implementation DepartmentTableViewController
@synthesize fetchedResultControler = _fetchedResultControler,searchResultArray;
@synthesize searchFetch = _searchFetch,searchBar,searchDisplayController;

- (void)viewDidLoad {
    [super viewDidLoad];
   // Don't show the scope bar or cancel button until editing begins
    
    searchBar.delegate = self;
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
    // Reload the table
    [[self tableView] reloadData];
  
    searchResultArray = [[NSMutableArray alloc]init];
    NSError *error = nil;
    if (![self.fetchedResultControler performFetch:&error]) {
        NSLog(@"Error!%@",error);
        abort();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Search FetchRequest
-(NSFetchRequest*)searchFetch{
    if (!_searchFetch) {
        return _searchFetch;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departmentName"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    return _searchFetch;
  
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    [self showDetailViewController:viewControllerToCommit sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    if (tableView != self.searchDisplayController.searchResultsTableView)
    {
        return [[self.fetchedResultControler sections]count];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [searchResultArray count];
    }
    else
    {
        id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultControler sections]objectAtIndex:section];
        return [secInfo numberOfObjects];
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString static *identifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        return cell;
    }
    Department *department  = nil;
     NSString *scope = [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        department = [searchResultArray objectAtIndex:[indexPath row]];
        if ([scope isEqualToString:@"Department"]) {
            cell.textLabel.text = department.departmentName;
        }
        else{
             cell.textLabel.text = department.employeeName;
        }
    }
    else
    {
        department = [self.fetchedResultControler objectAtIndexPath:indexPath];
        cell.textLabel.text = department.employeeName;

    }

    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        return [[[self.fetchedResultControler sections] objectAtIndex:section] name];

    }
    return nil;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = self.managedObjectContext;
        Department *dptToDelete = [self.fetchedResultControler objectAtIndexPath:indexPath];
        [context deleteObject:dptToDelete];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error!%@",error);
        }
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark-
#pragma mark - Fetch ResultViewController Section
-(NSFetchedResultsController*)fetchedResultControler{
   
  if (_fetchedResultControler) {
        return _fetchedResultControler;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departmentName"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    _fetchedResultControler = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"departmentName" cacheName:nil];
    _fetchedResultControler.delegate = self;
    return _fetchedResultControler;
 
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];


}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];

}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:{
            Department *newDepartment = [self.fetchedResultControler objectAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = newDepartment.employeeName;
        }
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;

        default:
            break;
    }
}
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
             break;
        default:
            break;
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"detailInfo"]) {
        DetailDepartmentViewController *detaildvc = (DetailDepartmentViewController*)[segue destinationViewController];
        detaildvc.delegate = self;
        Department *newDepartment = (Department*)[NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.managedObjectContext];
        detaildvc.currentDepartment = newDepartment;
    }
    else if ([[segue identifier]isEqualToString:@"edit"]){
        EditDepartmentViewController *edvc = (EditDepartmentViewController*)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Department *selectedDpt = [self.fetchedResultControler objectAtIndexPath:indexPath];
        edvc.currentDepartment = selectedDpt;
    }
}
-(void)cancelDetailViewControllerDidCancel:(Department *)deleteDepartment{
    NSManagedObjectContext *context = self.managedObjectContext;
    [context deleteObject:deleteDepartment];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addDetailViewControllerDidSave{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error!%@",error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark
#pragma mark - UISearchBar Delegate
#pragma mark
#pragma mark Content Filtering

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.searchResultArray removeAllObjects];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Department" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = nil;
    if ([scope isEqualToString:@"Department"]) {
    predicate = [NSPredicate predicateWithFormat:@"departmentName contains[c] %@", searchText];
   
    }else {
        predicate = [NSPredicate predicateWithFormat:@"employeeName contains[c] %@", searchText];
    }
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    
   searchResultArray = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
