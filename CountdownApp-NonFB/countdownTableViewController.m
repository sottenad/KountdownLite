//
//  countdownTableViewController.m
//  CountdownApp-NonFB
//
//  Created by Steve Ottenad on 10/1/13.
//  Copyright (c) 2013 Steve Ottenad. All rights reserved.
//

#import "countdownTableViewController.h"
#import "MZFormSheetController.h"
#import "addEventViewController.h"

@interface countdownTableViewController ()

@end

@implementation countdownTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Fetch the countdowns from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Countdown"];
    countdowns = [[managedObjectContext executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    UIBarButtonItem *addButton = [UIBarButtonItem alloc];
    addButton.title = @"Add";
    addButton.enabled = YES;
    //[addButton addTarget:self
    //            action:@selector(addReminder)
    // forControlEvents:UIControlEventTouchUpInside];
    addButton.target = self;
    addButton.action = @selector(addCountdown);
    
    self.navigationItem.rightBarButtonItem = addButton;


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return countdowns.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSManagedObject *countdown = [countdowns objectAtIndex:indexPath.row];

    UILabel *countdownTitle = (UILabel *)[cell viewWithTag:100];
    countdownTitle.text = [NSString stringWithFormat:@"%@", [countdown valueForKey:@"title"]];
    

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSDate *eventDate = [countdown valueForKey:@"deadline"];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:[NSDate date]
                                                          toDate: eventDate
                                                         options:0];
    NSString *daysApart = [NSString stringWithFormat:@"%i", [components day]];

    UILabel *countdownDate = (UILabel *)[cell viewWithTag:101];
    countdownDate.text = [NSString stringWithFormat:@"%@ days", daysApart ];
    
    UIImageView *thumb = (UIImageView *)[cell viewWithTag:102];
    UIImage *thumbImage = [[UIImage alloc] initWithData:[countdown valueForKey:@"photo"]];
    thumb.image = thumbImage;
    
    return cell;
}


-(void)addCountdown{
    
    //NSLog(@"clicked");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"countdownApp" bundle:[NSBundle mainBundle]];
    addEventViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"addCountdown"] ;
    vc.delegate = self;
    
    if(vc != nil){
        // present form sheet with view controller
        [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
        [[MZFormSheetBackgroundWindow appearance] setBlurRadius:3.0];
        [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
        // present form sheet with view controller
        MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
        formSheet.shouldDismissOnBackgroundViewTap = YES;
        formSheet.shouldCenterVertically = YES;
        formSheet.shouldCenterVerticallyWhenKeyboardAppears = YES;
        formSheet.transitionStyle = MZFormSheetTransitionStyleFade;
        formSheet.cornerRadius = 8.0;
        formSheet.portraitTopInset = 6.0;
        formSheet.landscapeTopInset = 6.0;
        formSheet.presentedFormSheetSize = CGSizeMake(270, 365);
        formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController){
            presentedFSViewController.view.autoresizingMask = presentedFSViewController.view.autoresizingMask | UIViewAutoresizingFlexibleWidth;
        };
        
        [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
            //NSLog(@"completed");
            
            
        }];
        
    }else{
        NSLog(@"cant find the view");
        
    }
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
-(void)loadTableData{
    // Fetch the countdowns from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Countdown"];
    countdowns = [[managedObjectContext executeFetchRequest:fetchRequest error:nil]mutableCopy];
    [self.tableView reloadData];
}

-(void)reloadList {
    NSLog(@"reload List");
    [self loadTableData];
    
}

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
