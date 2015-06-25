//
//  CDNavDrawerControllerTableViewController.m
//  CoronaDental
//
//  Created by Raju Gautam on 06/06/15.
//  Copyright (c) 2015 Raju Gautam. All rights reserved.
//

#import "CDNavDrawerControllerTableViewController.h"
#import "CDWebViewController.h"
#import "UIViewController+MMDrawerController.h"

#define CDDRAWERACTION @"CDDrawerAction"

@interface CDNavDrawerControllerTableViewController ()

@end

@implementation CDNavDrawerControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideDrawerCell" forIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:15];
    cell.textLabel.textColor = [UIColor colorWithRed:30.0f/255.0f green:138.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        // Configure the cell...//110 110 112
    switch(indexPath.row) {
        case 0:
            
            [cell.contentView addSubview:[self profileView]];
            break;
            
        case 1:
            cell.textLabel.text = @"Due Re-Orders";
            break;
        
        case 2:
            cell.textLabel.text = @"Deals on Product bought";
            break;
        case 3:
            cell.textLabel.text = @"Pending Deliveries";
            break;
        case 4:
            cell.textLabel.text = @"Start New Order";
            break;
        case 5:
            cell.textLabel.text = @"Past Orders";
            break;
            
        case 6:
            cell.textLabel.text = @"Contact Us";
            break;
            
            
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch(indexPath.row) {
        case 0:
            return 120.0f;
            break;
            
            default:

            return 60.0f;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    NSString *url = nil;
    switch (indexPath.row) {
        case 0:
            return;
            break;
            
        case 1:
            url = @"http://coronadentalnetwork.com/index.php/seal-tight-1500-tips-disposable-air-water-syringe-tips-bendable-adapter-required-this.html";
            break;
            
        case 2:
            url = @"http://coronadentalnetwork.com/index.php/cavit-g-single-jar-gray-soft-temporary-filling-material-self-cure-28-gm-jar.html";
            break;
        
        case 3:
        url = @"http://coronadentalnetwork.com/index.php/sales/order/history/";
            break;
        
        case 4:
            url = @"http://coronadentalnetwork.com/index.php/";
            break;
        
        case 5:
            url = @"http://coronadentalnetwork.com/index.php/sales/order/history/";
            break;
        case 6:
            url = @"http://coronadentalnetwork.com/index.php/contacts/";
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CDDRAWERACTION object:url];
    
}

- (UIView *)profileView {
    CGSize size = self.view.frame.size;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 120.0f)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:159.0f/255.0f blue:227.0f/255.0f alpha:1.0f]];
    UIImageView *profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64, 40, 40)];
    [profilePic setImage:[UIImage imageNamed:@"amar-singh-profimg1"]];
    profilePic.layer.cornerRadius = 20;
    profilePic.layer.masksToBounds = TRUE;
    [headerView addSubview:profilePic];
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 65, size.width - 70.0f, 20.0f)];
    headerTitle.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
    headerTitle.text = @"Dr. Amar Singh";
    [headerTitle setTextAlignment:NSTextAlignmentLeft];
    [headerTitle setTextColor:[UIColor whiteColor]/*[UIColor colorWithRed:30.0f/255.0f green:138.0f/255.0f blue:220.0f/255.0f alpha:1.0f]*/];
    
    [headerView addSubview:headerTitle];
    
    UILabel *headerTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 85, size.width - 70.0f, 20.0f)];
    headerTitle2.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
    headerTitle2.text = @"Preferred Customer: D000001A";
    [headerTitle2 setTextAlignment:NSTextAlignmentLeft];
    [headerTitle2 setTextColor:/*[UIColor colorWithRed:147.0f/255.0f
                                               green:189.0f/255.0f
                                                blue:19.0f/255.0f
                                               alpha:1.0f]*/[UIColor whiteColor]];
    [headerView addSubview:headerTitle2];
    
        //    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(65, headerView.frame.size.height - 0.5f, size.width - 70.0f, 0.5f)];
        //    [separator setBackgroundColor:[UIColor lightGrayColor]];
        //    [headerView addSubview:separator];
    
    return headerView;
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
