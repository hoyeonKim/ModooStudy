//
//  ViewController.m
//  ModooStudy
//
//  Created by SDT-1 on 2014. 1. 9..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomCell.h"
#import "circlularTimer.h"
#import "MyStopwatchViewController.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    BOOL running;
    NSArray *arrayofImage;
    NSArray *time;
    NSArray *name;
}
@property(nonatomic,strong)circlularTimer *circularTimer;
@end

@implementation ViewController
@synthesize hr, min, sec, hun, timer;
@synthesize btnStop, btnStart, btnReset;
//create circle
- (void)createCircle
{
    self.circularTimer= [[circlularTimer alloc] initWithPosition:CGPointMake(80.0f, 70.0f)
                                                          radius:80
                                                  internalRadius:68
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
    
    [self.view addSubview:self.circularTimer];
}

- (IBAction)startTouched:(UIButton *)sender
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self
                                                selector:@selector(showTime)
                                                userInfo:nil
                                                 repeats:YES];
    if(running ==YES){
        running = NO;//서버로 값 반환
    }
    else{
        running = YES;//서버로 값 반환
    }
    
    [self buttonStatesWithStartState:NO stopState:YES resetState:NO];
}
- (IBAction)stopTouched:(UIButton *)sender
{
    [self.timer invalidate];
    self.timer = nil;
    
    [self buttonStatesWithStartState:YES stopState:NO resetState:YES];
}
- (IBAction)resetTouched:(UIButton *)sender
{
    
    self.min.text = @"00 :";
    self.sec.text = @"00 :";
    self.hun.text = @"00";
    
    [self buttonStatesWithStartState:YES stopState:NO resetState:NO];
}
- (void)buttonStatesWithStartState:(BOOL)startState
                         stopState:(BOOL)stopState
                        resetState:(BOOL)resetState
{
    self.btnStart.enabled = startState;
    self.btnStop.enabled = stopState;
    self.btnReset.enabled = resetState;
    
    self.btnStart.alpha = self.btnStop.alpha = self.btnReset.alpha = .5;
    
    if (startState) self.btnStart.alpha = 1;
    if (stopState) self.btnStop.alpha = 1;
    if (resetState) self.btnReset.alpha = 1;
}

- (void)showTime
{
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    int hundredths = 0;
    NSArray *timeArray = [NSArray arrayWithObjects:self.hun.text, self.sec.text, self.min.text, self.hr.text, nil];
    
    for (int i = [timeArray count] - 1; i >= 0; i--) {
        int timeComponent = [[timeArray objectAtIndex:i] intValue];
        switch (i) {
            case 3:
                hours = timeComponent;
                break;
            case 2:
                minutes = timeComponent;
                break;
            case 1:
                seconds = timeComponent;
                break;
            case 0:
                hundredths = timeComponent;
                hundredths++;
                break;
                
            default:
                break;
        }
        
    }
    if (hundredths == 100) {
        seconds++;
        hundredths = 0;
    }
    else if (seconds == 60) {
        minutes++;
        seconds = 0;
    }
    else if (minutes == 60) {
        hours++;
        minutes = 0;
    }
    self.hr.text = [NSString stringWithFormat:@"%.0d", hours];
    self.min.text = [NSString stringWithFormat:@"%.2d :", minutes];
    self.sec.text = [NSString stringWithFormat:@"%.2d :", seconds];
    self.hun.text = [NSString stringWithFormat:@"%.2d", hundredths];
    
}
//콜렉션뷰 멤버보여주기

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [time count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"CELL";
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell img]setImage:[UIImage imageNamed:[arrayofImage objectAtIndex:indexPath.item]]];
    [[cell time]setText:[time objectAtIndex:indexPath.item]];
    [[cell name]setText:[name objectAtIndex:indexPath.item]];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self createCircle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self collectionMember]setDataSource:self];
    [[self collectionMember]setDelegate:self];
    arrayofImage = [[NSArray alloc]initWithObjects:@"c2.jpg",@"c3.jpg",@"c5.jpg"/*,@"ㅇㅇ.png"*/, nil];
    time = [[NSArray alloc]initWithObjects:@"4시간째",@"5시간째",@"6시간째"/*,@"7시간째"*/, nil];
    name = [[NSArray alloc]initWithObjects:@"호연",@"채린",@"수연"/*,@"태현"*/, nil];

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end
