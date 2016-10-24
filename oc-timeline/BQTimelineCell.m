//
//  BQTimelineCell.m
//  oc-timeline
//
//  Created by HuangBQ on 16/10/24.
//  Copyright © 2016年 huangbingqi. All rights reserved.
//

#import "BQTimelineCell.h"

@interface BQTimelineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation BQTimelineCell

- (UIView *)topLine
{
    return _topLine;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    self.bgImageView.image = highlighted ? [UIImage imageNamed:@"bg-timeline-cell-highlighted"] : [UIImage imageNamed:@"bg-timeline-cell"];

    self.contentLabel.textColor = highlighted ? [UIColor whiteColor] : [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)setText:(NSString *)text
{
    self.contentLabel.text = text;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    self.iconImageView.layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.topLine.backgroundColor = [UIColor orangeColor];
    self.bottomLine.backgroundColor = [UIColor orangeColor];

    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width/2;
    self.iconImageView.layer.masksToBounds = YES;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


@end
