//
//  ViewController.m
//  oc-timeline
//
//  Created by HuangBQ on 16/10/24.
//  Copyright © 2016年 huangbingqi. All rights reserved.
//

#import "ViewController.h"
#import "BQTimelineCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, assign) CGFloat leadingOfToplines;

@end

static NSString *cellID = @"timecell";

@implementation ViewController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;

        _tableView.separatorColor = [UIColor clearColor];

        [self.view addSubview:_tableView];
    }

    return  _tableView;
}

- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
        [_datas addObject:@"订单已提交"];
        [_datas addObject:@"支付成功"];
        [_datas addObject:@"商家以接单,商品准备中..."];
        [_datas addObject:@"商品正在配送..."];
        [_datas addObject:@"商品已送达"];
    }

    return _datas;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单详情";

    [self.tableView registerNib:[UINib nibWithNibName:@"BQTimelineCell" bundle:nil] forCellReuseIdentifier:cellID];

    self.topLine = [UIView new];
    self.bottomLine = [UIView new];
    self.bottomLine.backgroundColor = [UIColor darkGrayColor];

    [self.view addSubview:self.topLine];
    [self.view addSubview:self.bottomLine];


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BQTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    [cell setText:self.datas[indexPath.row]];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BQTimelineCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    self.topLine.backgroundColor = [cell topLine].backgroundColor
    ;

    // 计算topline的x和宽度
    //  convertPoint 方法进行坐标系变换，就是将线条在 Cell 中的坐标映射到它应该在 SuperView 中的坐标。
    self.leadingOfToplines = [cell convertPoint:cell.topLine.frame.origin toView:self.view].x;

    [self scrollViewDidScroll:tableView];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    // 更新topline的frame
    self.topLine.frame = CGRectMake(self.leadingOfToplines, 0, 1, -scrollView.contentOffset.y);

    // bottomline 的 frame
    CGFloat yOffset = scrollView.frame.size.height - scrollView.contentSize.height + scrollView.contentOffset.y;
    self.bottomLine.frame = CGRectMake(self.leadingOfToplines, self.view.frame.size.height - yOffset, 1, self.view.frame.size.height);
}


@end
