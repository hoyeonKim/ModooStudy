//
//  ViewController.h
//  ModooStudy
//
//  Created by SDT-1 on 2014. 1. 9..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *hr;

@property (nonatomic, weak) IBOutlet UILabel *min;
@property (weak, nonatomic) IBOutlet UILabel *sec;

@property (nonatomic, weak) IBOutlet UILabel *hun;
@property (nonatomic, weak) IBOutlet UIButton *btnStop;
@property (nonatomic, weak) IBOutlet UIButton *btnStart;
@property (nonatomic, weak) IBOutlet UIButton *btnReset;
@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionMember;
- (IBAction)startTouched:(UIButton *)sender;
- (IBAction)stopTouched:(UIButton *)sender;
- (IBAction)resetTouched:(UIButton *)sender;

@property float radius;
@property float internalRadius;
@property (nonatomic, strong) UIColor *circleStrokeColor;
@property (nonatomic, strong) UIColor *activeCircleStrokeColor;


@end
