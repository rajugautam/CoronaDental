//
//  CDProductCell.m
//  CoronaDental
//
//  Created by Raju Gautam on 06/06/15.
//  Copyright (c) 2015 Raju Gautam. All rights reserved.
//

#import "CDProductCell.h"

#define FLDeviceIsUIKit7() [[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0f

@implementation CDProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
            // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        _orderLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderLabel1.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:12];
        _orderLabel1.numberOfLines = 0;
        _orderLabel1.text = @"Air Water\n Syringes";
        _orderLabel1.lineBreakMode = NSLineBreakByWordWrapping;
        [_orderLabel1 setTextAlignment:NSTextAlignmentCenter];
        [_orderLabel1 setTextColor:[UIColor colorWithRed:110.0f/255.0f
                                                   green:134.0f/255.0f
                                                    blue:15.0f/255.0f
                                                   alpha:1.0f]];
        [self.contentView addSubview:_orderLabel1];
        
        _orderLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderLabel2.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:12];
        _orderLabel2.numberOfLines = 0;
        _orderLabel2.text = @"Impression Trays";
        _orderLabel2.lineBreakMode = NSLineBreakByWordWrapping;
        [_orderLabel2 setTextAlignment:NSTextAlignmentCenter];
        [_orderLabel2 setTextColor:[UIColor colorWithRed:110.0f/255.0f
                                                   green:134.0f/255.0f
                                                    blue:15.0f/255.0f
                                                   alpha:1.0f]];
        [self.contentView addSubview:_orderLabel2];
        
        _orderLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderLabel3.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:12];
        [_orderLabel3 setTextAlignment:NSTextAlignmentCenter];
        _orderLabel3.text = @"Alfhanet\n Alignate";
        _orderLabel3.lineBreakMode = NSLineBreakByWordWrapping;
        _orderLabel3.numberOfLines = 0;
        [_orderLabel3 setTextColor:[UIColor colorWithRed:110.0f/255.0f
                                                   green:134.0f/255.0f
                                                    blue:15.0f/255.0f
                                                   alpha:1.0f]];
        [self.contentView addSubview:_orderLabel3];
        
        _orderBtn1 = [[UIButton alloc] initWithFrame:CGRectZero];
        [_orderBtn1 setImage:[UIImage imageNamed:@"Corona-13.png"] forState:UIControlStateNormal];
        [_orderBtn1 addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_orderBtn1];
        
        _orderBtn2 = [[UIButton alloc] initWithFrame:CGRectZero];
        [_orderBtn2 setImage:[UIImage imageNamed:@"Corona-19.png"] forState:UIControlStateNormal];
        [_orderBtn2 addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_orderBtn2];
        
        _orderBtn3 = [[UIButton alloc] initWithFrame:CGRectZero];
        [_orderBtn3 setImage:[UIImage imageNamed:@"Corona-75.png"] forState:UIControlStateNormal];
        [_orderBtn3 addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_orderBtn3];
        
            // 30, 138, 220 blue
            // 147 189 19 titles

        _headerView = [[UIView alloc] initWithFrame:CGRectZero];
        [_headerView setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:159.0f/255.0f blue:227.0f/255.0f alpha:1.0f]];
        
        _orderTruck = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_orderTruck setImage:[UIImage imageNamed:@"ic_pending_truck"]];
            //    profilePic.layer.cornerRadius = 20;
            //    profilePic.layer.masksToBounds = TRUE;
        [self.contentView addSubview:_orderTruck];
        [self.contentView bringSubviewToFront:_orderTruck];
        
        _headerTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _headerTitle.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
        _headerTitle.text = @"Due Re-Orders";
        [_headerTitle setTextAlignment:NSTextAlignmentLeft];
        [_headerTitle setTextColor:[UIColor whiteColor]];
        [_headerView addSubview:_headerTitle];
        
        [self.contentView addSubview:_headerView];
        
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self setBackgroundView:backgroundView];
        
        
    }
    return self;
}


#pragma mark - Layout Configuration Views
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = CGRectInset([self bounds], 0.0f, 0.0f);
    
    CGFloat heightOffset = 0.0f;
    CGFloat widthOffset = (frame.size.width - 95 *3) / 4;
    
    [_headerView setFrame:CGRectMake(CGRectGetMinX(frame) + 10, 10.0f, CGRectGetWidth(frame) - 20, 22.0f)];
    [_headerTitle setFrame:CGRectMake(5, 0, CGRectGetWidth(_headerView.frame) - 20, 22.0f)];
    
    heightOffset = heightOffset + 32.0f;
    [_orderBtn1 setFrame:CGRectMake(CGRectGetMinX(frame) + widthOffset, heightOffset + 5.0f, 95.0f, 80.0f)];
    
    [_orderBtn2 setFrame:CGRectMake(CGRectGetMinX(frame) + 95 + widthOffset*2, heightOffset + 5.0f, 95.0f, 80.0f)];
    
    [_orderBtn3 setFrame:CGRectMake(CGRectGetMinX(frame) + 190 + widthOffset *3, heightOffset + 5.0f, 95.0f, 80.0f)];
    
    heightOffset = heightOffset + 80.0f;
    [_orderLabel1 setFrame:CGRectMake(CGRectGetMinX(frame) + widthOffset, heightOffset, 95.0f, 50.0f)];
    [_orderLabel2 setFrame:CGRectMake(CGRectGetMinX(frame) + 95 + widthOffset*2, heightOffset, 95.0f, 50.0f)];
    [_orderLabel3 setFrame:CGRectMake(CGRectGetMinX(frame) + 190 + widthOffset *3, heightOffset, 95.0f, 50.0f)];
    
    [_orderTruck setFrame:CGRectMake(CGRectGetWidth(frame) - 60, 0, 32, 32)];
}


- (void)orderBtnClicked : (id)sender {
    UIButton *button = (UIButton *)sender;
    UITableView *tableView = [self tableView];
    if (_callback) {
        self.callback([tableView indexPathForCell:self],button.tag);
    }
}

#pragma mark - Action Methods
- (UITableView *)tableView {
    UITableView *tableView = (id)[self superview];
    if (FLDeviceIsUIKit7()) {
        tableView = (id)[tableView superview];
    }
    return tableView;
}


@end
