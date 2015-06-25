//
//  CDHomeViewController.m
//  CoronaDental
//
//  Created by Raju Gautam on 04/06/15.
//  Copyright (c) 2015 Raju Gautam. All rights reserved.
//

#import "CDHomeViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "CDProductCell.h"
#import "CDNewOrderCell.h"
#import "CDWebViewController.h"
#import "NSString+Helpers.h"

#define CDDRAWERACTION @"CDDrawerAction"

@interface CDHomeViewController ()<UISearchBarDelegate>
@property (strong, nonatomic)NSString *searchString;
@property (strong, nonatomic)NSMutableArray *titleArray;
@end

@implementation CDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftMenuButton];
    
//    self.navigationController.hidesBarsOnSwipe = TRUE;
    
    _titleArray = [NSMutableArray array];
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    NSArray *array1 = [NSArray arrayWithObjects:@"AIR WATER SYRINGIES",@"IMPRESSION TRAYS",@"ALFHANET ALIGNATE", nil];
    [dict1 setObject:array1 forKey:@(0)];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    NSArray *array2 = [NSArray arrayWithObjects:@"CAVIT G\nFILLING MATERIAL",@"SUPREMAX\n GLOVES",@"K FILES", nil];
    [dict2 setObject:array2 forKey:@(1)];

    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    NSArray *array3 = [NSArray arrayWithObjects:@"ORDER #42\n EXPECTED 6/3/15",@"ORDER #38\n EXPECTED 3/8/15",@"ORDER #37\n EXPECTED 3/8/15", nil];
    [dict3 setObject:array3 forKey:@(2)];

    NSMutableDictionary *dict4 = [NSMutableDictionary dictionary];
    NSArray *array4 = [NSArray arrayWithObjects:@"ORDER #36\n 3 MAY, 15",@"ORDER #35\n 6 MAY, 15",@"ORDER #21\n 10 MAY, 15", nil];
    [dict4 setObject:array4 forKey:@(4)];

    [_titleArray addObject:dict1];
    [_titleArray addObject:dict2];
    [_titleArray addObject:dict3];
    [_titleArray addObject:dict4];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUrlInWebView:) name:CDDRAWERACTION object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadUrlInWebView: (NSNotification *)notification{
    CDWebViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    newView.url = [notification object];
    [self.navigationController pushViewController:newView animated:YES];
}

- (void)setupLeftMenuButton {
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton];
}

- (void)leftDrawerButtonPress:(id)leftDrawerButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 3) {
        static NSString *CellIdentifier = @"CDNewOrderCell";
        CDNewOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CDNewOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor whiteColor];
        }
            // Configure the cell...
        return cell;
        
    } else {
        static NSString *CellIdentifier = @"CDProductCell";
        CDProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CDProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor whiteColor];
            [cell setCallback:^(NSIndexPath *indexPath, int tag){
                [self detectClickedProductFromIndexPath:indexPath withTag:tag];
            }];
        }
        
        [cell.contentView bringSubviewToFront:cell.orderTruck];
        cell.orderTruck.hidden = TRUE;

        switch (indexPath.row) {
            case 0:{
                [cell.orderBtn1 setImage:[UIImage imageNamed:@"air-water-syringe.jpg"] forState:UIControlStateNormal];
                [cell.orderBtn2 setImage:[UIImage imageNamed:@"impression-trays.jpg"] forState:UIControlStateNormal];
                [cell.orderBtn3 setImage:[UIImage imageNamed:@"alfanet-alignet.jpg"] forState:UIControlStateNormal];
                
                cell.orderBtn1.tag = 100;
                cell.orderBtn2.tag = 101;
                cell.orderBtn3.tag = 102;
                NSArray *array = [[_titleArray objectAtIndex:indexPath.row] objectForKey:@(indexPath.row)];
                cell.orderLabel1.text = array[0];
                cell.orderLabel2.text = array[1];
                cell.orderLabel3.text = array[2];
                
                cell.headerTitle.text = @"Due Re-Orders";

                break;
            }
            case 1: {
                [cell.orderBtn1 setImage:[UIImage imageNamed:@"cavit-g.jpg"] forState:UIControlStateNormal];
                [cell.orderBtn2 setImage:[UIImage imageNamed:@"supermax-gloves.jpg"] forState:UIControlStateNormal];
                [cell.orderBtn3 setImage:[UIImage imageNamed:@"k-files.jpg"] forState:UIControlStateNormal];
                
                cell.orderBtn1.tag = 200;
                cell.orderBtn2.tag = 201;
                cell.orderBtn3.tag = 202;
                
                NSArray *array = [[_titleArray objectAtIndex:indexPath.row] objectForKey:@(indexPath.row)];
                cell.orderLabel1.text = array[0];
                cell.orderLabel2.text = array[1];
                cell.orderLabel3.text = array[2];

                cell.headerTitle.text = @"Deals on Products Bought";
//                cell.orderLabel1.text = @"CAVIT G\nFILLING MATERIAL";
//                cell.orderLabel2.text = @"SUPREMAX\n GLOVES";
//                cell.orderLabel3.text = @"K FILES";
                break;
            }
            case 2:
            {
                cell.orderTruck.hidden = FALSE;
            
                [cell.orderBtn1 setImage:[UIImage imageNamed:@"ic_pending_delivery01"] forState:UIControlStateNormal];
                [cell.orderBtn2 setImage:[UIImage imageNamed:@"ic_pending_delivery02"] forState:UIControlStateNormal];
                [cell.orderBtn3 setImage:[UIImage imageNamed:@"ic_pending_delivery03"] forState:UIControlStateNormal];
                
                cell.orderBtn1.tag = 300;
                cell.orderBtn2.tag = 301;
                cell.orderBtn3.tag = 302;
                
                NSArray *array = [[_titleArray objectAtIndex:indexPath.row] objectForKey:@(indexPath.row)];
                cell.orderLabel1.text = array[0];
                cell.orderLabel2.text = array[1];
                cell.orderLabel3.text = array[2];
                cell.headerTitle.text = @"Pending Deliveries";
//                cell.orderLabel1.text = @"ORDER #42\n EXPECTED 6/3/15";
//                cell.orderLabel2.text = @"ORDER #38\n EXPECTED 3/8/15";
//                cell.orderLabel3.text = @"ORDER #37\n EXPECTED 3/8/15";
                break;
        }
            case 4:
            {
            [cell.orderBtn1 setImage:[UIImage imageNamed:@"ic_past_orders.png"] forState:UIControlStateNormal];
            [cell.orderBtn2 setImage:[UIImage imageNamed:@"ic_past_orders.png"] forState:UIControlStateNormal];
            [cell.orderBtn3 setImage:[UIImage imageNamed:@"ic_past_orders.png"] forState:UIControlStateNormal];
                
                cell.orderBtn1.tag = 400;
                cell.orderBtn2.tag = 401;
                cell.orderBtn3.tag = 402;
                
            cell.headerTitle.text = @"Past Orders";
//                cell.orderLabel1.text = @"ORDER #43\n 3 MAY, 15";
//                cell.orderLabel2.text = @"ORDER #43\n 5 MAY, 15";
//                cell.orderLabel3.text = @"ORDER #43\n 10 MAY, 15";
            NSArray *array = [[_titleArray objectAtIndex:(indexPath.row -1)] objectForKey:@((indexPath.row))];
            cell.orderLabel1.text = array[0];
            cell.orderLabel2.text = array[1];
            cell.orderLabel3.text = array[2];

                break;
            }
            default:
                break;
        }
            // Configure the cell...
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 3) {
        return 104.0f;
    } else {
        return 162.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGSize size = self.view.frame.size;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 60.0f)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    UIImageView *profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [profilePic setImage:[UIImage imageNamed:@"amar-singh-profimg1"]];
    [headerView addSubview:profilePic];
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, size.width - 70.0f, 20.0f)];
    headerTitle.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
    headerTitle.text = @"Hello, Dr. Amar Singh";
    [headerTitle setTextAlignment:NSTextAlignmentLeft];
    [headerTitle setTextColor:[UIColor colorWithRed:2.0f/255.0f green:146.0f/255.0f blue:208.0f/255.0f alpha:1.0f]];
    
    [headerView addSubview:headerTitle];
    
    UILabel *headerTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(65, 27, 145.0f, 20.0f)];
    headerTitle2.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
    headerTitle2.text = @"Preferred Customer:";
    [headerTitle2 setTextAlignment:NSTextAlignmentLeft];
    [headerTitle2 setTextColor:[UIColor colorWithRed:110.0f/255.0f
                                               green:110.0f/255.0f
                                                blue:112.0f/255.0f
                                               alpha:1.0f]];
    [headerView addSubview:headerTitle2];
    
    UILabel *headerTitle3 = [[UILabel alloc] initWithFrame:CGRectMake(205, 27, size.width - 70.0f, 20.0f)];
    headerTitle3.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
    headerTitle3.text = @" D000001A";
    [headerTitle3 setTextAlignment:NSTextAlignmentLeft];
    [headerTitle3 setTextColor:[UIColor colorWithRed:110.0f/255.0f
                                               green:134.0f/255.0f
                                                blue:15.0f/255.0f
                                               alpha:1.0f]];
    [headerView addSubview:headerTitle3];
    
//    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(65, headerView.frame.size.height - 0.5f, size.width - 70.0f, 0.5f)];
//    [separator setBackgroundColor:[UIColor lightGrayColor]];
//    [headerView addSubview:separator];

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        CDWebViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        newView.url = @"http://coronadentalnetwork.com/index.php/";
        newView.navigationItem.title = @"New Order";
        [self.navigationController pushViewController:newView animated:YES];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([self.searchDisplayController isActive]) {
        [self.searchDisplayController setActive:NO];
    }
    // Initiate server search when search button on keyboard is pressed.
    //NSString *searchString = searchBar.text;
    _searchString = [_searchString stringByUrlEncoding];
    
    NSString *searchQuery = [NSString stringWithFormat:@"http://coronadentalnetwork.com/index.php/catalogsearch/result/?q=%@", _searchString];
    if ([searchQuery isEqualToString:@"(null)"] || searchQuery == nil) {
        searchQuery = @"http://coronadentalnetwork.com/index.php/";
    }
    CDWebViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    newView.url = searchQuery;
    newView.navigationItem.title = @"Search";
    [self.navigationController pushViewController:newView animated:YES];
}

- (void)detectClickedProductFromIndexPath:(NSIndexPath *)indexPath withTag:(int)tag {
    NSLog(@"tag %d", tag);
    CDWebViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    newView.url = @"http://coronadentalnetwork.com/index.php/";
    switch (indexPath.row) {
        case 0:
            newView.navigationItem.title = @"Due Re-Orders";
            switch (tag) {
                case 100:
                    newView.url = @"http://coronadentalnetwork.com/index.php/seal-tight-1500-tips-disposable-air-water-syringe-tips-bendable-adapter-required-this.html";
                    break;
                case 101:
                    newView.url = @"http://coronadentalnetwork.com/index.php/tray-aways-3-perforated-medium-upper-full-arch-blue-plastic-impression-trays-package-of-12.html";
                    break;
                case 102:
                    
                    break;
                    
                default:
                    break;
            }
            break;
   
        case 1:
            newView.navigationItem.title = @"Deals";
            switch (tag) {
                case 200:
                    //newView.url = @"http://coronadentalnetwork.com/index.php/catalogsearch/result/index/?p=1&q=cavit+g+filling+material";
                    newView.url = @"http://coronadentalnetwork.com/index.php/cavit-g-single-jar-gray-soft-temporary-filling-material-self-cure-28-gm-jar.html";
                    break;
                case 201:
                    newView.url = @"http://coronadentalnetwork.com/index.php/aurelia-vibrant-latex-exam-glove-small-powder-free-textured-non-sterile-box-of-100-gloves.html";
                    break;
                case 202:
                    newView.url = @"http://coronadentalnetwork.com/index.php/maillefer-k-files-25mm-10-6-box-stainless-steel.html";
                    break;
                    
                default:
                    break;
            }
            break;
           
        case 2:
            newView.navigationItem.title = @"Pending Deliveries";
            switch (tag) {
                case 300:
                    newView.url = @"http://coronadentalnetwork.com/index.php/sales/order/view/order_id/42/";
                    break;
                case 301:
                    newView.url = @"http://coronadentalnetwork.com/index.php/sales/order/view/order_id/38/";
                    break;
                case 302:
                    newView.url = @"http://coronadentalnetwork.com/index.php/sales/order/view/order_id/37/";
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 4:
            newView.navigationItem.title = @"Past Orders";
            switch (tag) {
                case 400:
                    newView.url = @"http://coronadentalnetwork.com/index.php/sales/order/view/order_id/36/";
                    break;
                case 401:
                    newView.url = @"http://coronadentalnetwork.com/index.php/sales/order/view/order_id/35/";
                    break;
                case 402:
                    newView.url = @"http://coronadentalnetwork.com/index.php/sales/order/view/order_id/21/";
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:newView animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return TRUE;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _searchString = searchText;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
        //_shouldDisplayHeader = FALSE;
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
