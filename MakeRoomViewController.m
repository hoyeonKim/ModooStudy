//
//  MakeRoomViewController.m
//  ModooStudy
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MakeRoomViewController.h"

@interface MakeRoomViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{
    NSArray * num;
    int NumOfMember;
    int dy;//keyboard
    NSMutableArray *day;
    BOOL selectDay;
    BOOL selectDay1;
    BOOL selectDay2;
    BOOL selectDay3;
    BOOL selectDay4;
    BOOL selectDay5;
    BOOL selectDay6;
    int Daynum;
}
@property (weak, nonatomic) IBOutlet UITextField *RoomName;
@property (weak, nonatomic) IBOutlet UIPickerView *MemberNum;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end

@implementation MakeRoomViewController
//keyboard dismiss & viewscroll
-(UITextField *)firstResponderTextfield{
    for(id child in self.view.subviews){
        if([child isKindOfClass:[UITextField class]]){
            UITextField *textField = (UITextField *)child;
            if(textField.isFirstResponder){
                return textField;
            }
        }
    }
    return nil;
}
-(IBAction)dismissKeyboard:(id)sender{
    [[self firstResponderTextfield]resignFirstResponder];
}
-(void)keyboardWillShow:(NSNotification *)noti{
    UITextField *firstResponder = (UITextField *)[self firstResponderTextfield];
    int y=firstResponder.frame.origin.y+firstResponder.frame.size.height+5;
    int viewHeight = self.view.frame.size.height;
    
    NSDictionary *userInfo = [noti userInfo];
    CGRect rect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue];
    int keyboardHeight = (int)rect.size.height;
    
    float animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    if(keyboardHeight>(viewHeight-y)){
        [UIView animateWithDuration:animationDuration animations:^{
            dy=keyboardHeight - (viewHeight - y);
            self.view.center=CGPointMake(self.view.center.x, self.view.center.y-dy);
        }];
    }
    else{
        dy=0;
    }
}

-(void)keyboardWillHide:(NSNotification *)noti{
    if(dy>0){
        float animationDuration =[[[noti userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
        [UIView animateWithDuration:animationDuration animations:^{self.view.center = CGPointMake(self.view.center.x, self.view.center.y+dy);}];
    }
}

//camera setting by alertview

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing =YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:imagePicker animated:YES];
    }
    else if(buttonIndex ==1){
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"오류입니다!" message:@"이 기종에서는 카메라가 지원되지 않습니다" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
            [alert show];
            return;
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing=YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:imagePicker animated:YES];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *original = [info objectForKey:UIImagePickerControllerEditedImage];
    
    UIImage *usingImg =(nil==editedImage)? original : editedImage;
    self.imageView.image = usingImg;
    [picker dismissModalViewControllerAnimated:YES];
}
- (IBAction)camera:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"사진 설정" delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:@"앨범에서 선택" otherButtonTitles:@"촬영", nil];
    sheet.tag=1;
    [sheet showInView:self.view];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 6;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(0==component){
        return [NSString stringWithFormat:@"%ld 명",(row+1)];
    }
    else{
        return [num objectAtIndex:row];
    }
}
- (IBAction)competeBtn:(id)sender {
    //서버로 numofmember쏴주고(값이 0일경우 4로 반환할 것!!)
    NSLog(@"%d",NumOfMember);
}
- (IBAction)mon:(id)sender {
    if(selectDay ==YES){
    [self.mon setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        selectDay = NO;
        Daynum+=1;
        NSLog(@"%d",Daynum);
    }
    else{
        selectDay =YES;
        [self.mon setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}

- (IBAction)tue:(id)sender {
    if(selectDay1 ==YES){
        [self.tue setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        selectDay1 = NO;
    }
    else{
        selectDay1 =YES;
        [self.tue setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}
- (IBAction)wed:(id)sender {
    if(selectDay2 ==YES){
        [self.wed setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        selectDay2 = NO;
    }
    else{
        selectDay2 =YES;
        [self.wed setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (IBAction)thur:(id)sender {
    if(selectDay3 ==YES){
        [self.thur setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        selectDay3 = NO;
    }
    else{
        selectDay3 =YES;
        [self.thur setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (IBAction)fri:(id)sender {
    if(selectDay4 ==YES){
        [self.fri setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        selectDay4 = NO;
    }
    else{
        selectDay4 =YES;
        [self.fri setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (IBAction)sat:(id)sender {
    if(selectDay5 ==YES){
        [self.sat setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        selectDay5 = NO;
    }
    else{
        selectDay5 =YES;
        [self.sat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (IBAction)sun:(id)sender {
    if(selectDay6 ==YES){
        [self.sun setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        selectDay6 = NO;
    }
    else{
        selectDay6 =YES;
        [self.sun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NumOfMember = row+1;
    return NumOfMember;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillShowNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.MemberNum selectRow:3 inComponent:0 animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    selectDay = NO ;
    
 
    
   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
