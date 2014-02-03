//
//  MyStopwatchViewController.m
//  ModooStudy
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MyStopwatchViewController.h"
#import "circlularTimer.h"

@interface MyStopwatchViewController ()
@property(nonatomic,strong)circlularTimer *circularTimer1;
@end

@implementation MyStopwatchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)createCircle
{
    self.circularTimer1= [[circlularTimer alloc] initWithPosition:CGPointMake(50.0f, 120.0f)
                                                          radius:120
                                                  internalRadius:100
                                               circleStrokeColor:[UIColor grayColor]
                                         activeCircleStrokeColor:[UIColor purpleColor]
                                                     initialDate:5000000
                                                       finalDate:0
                                                   startCallback:^{
                                                       //self.statusLabel.text = @"Running!";
                                                   }
                                                     endCallback:^{
                                                         //self.statusLabel.text = @"Not running anymore!";
                                                     }];
    
    //self.statusLabel.text = ([self.circularTimer willRun]) ? @"Circle will run" : @"Circle won't run";
    
    [self.view addSubview:self.circularTimer1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self createCircle];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
