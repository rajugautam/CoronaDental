//
//  CDProductCell.h
//  CoronaDental
//
//  Created by Raju Gautam on 06/06/15.
//  Copyright (c) 2015 Raju Gautam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CDProductCellCallBack)(NSIndexPath *indexPath, int tag);

@interface CDProductCell : UITableViewCell

@property(nonatomic, strong)UIButton *orderBtn1;
@property(nonatomic, strong)UIButton *orderBtn2;
@property(nonatomic, strong)UIButton *orderBtn3;

@property(nonatomic, strong)UILabel *orderLabel1;
@property(nonatomic, strong)UILabel *orderLabel2;
@property(nonatomic, strong)UILabel *orderLabel3;

@property(nonatomic, strong)UIView *headerView;
@property(nonatomic, strong)UILabel *headerTitle;

@property(nonatomic, strong)UIImageView *orderTruck;

@property (nonatomic, copy) CDProductCellCallBack callback;

@end
