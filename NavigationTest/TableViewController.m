//
//  TableViewController.m
//  NavigationTest
//
//  Created by user on 15/8/4.
//  Copyright (c) 2015年 NCEPU. All rights reserved.
//

#import "TableViewController.h"

#define CELLNEWAREA_HEIGHT 44 //cell中新增加的空间的高度
#define CELLNORMAL_HEIGHT 44
#define CELLADDBUTTON_WIDTH 100
@interface TableViewController ()

@end

@implementation TableViewController
{
    UITableView *myTableView;
    UINavigationBar *navigationBar;
    
    NSMutableArray *dataArr;
    
    NSInteger rowOfAddButton;//用于存储添加按钮所在的cell的row的值
    CGFloat heightOfAddCell;//用于存储存放添加按钮所在的cell的高度
    int buttonChangeFlag;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
    dataArr=[[NSMutableArray alloc]initWithObjects:@"aaa",@"bbb",@"ccc", nil];
    
    navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"左边" style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftButton)];
    
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"右边"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(clickRightButton)];
    navigationItem.leftBarButtonItem=leftButton;
    navigationItem.rightBarButtonItem=rightButton;
    
    //设置导航栏内容
    [navigationItem setTitle:@"tableViewAndNavicationBar"];
    
    //将navigationitem放到navigationbar中
    [navigationBar pushNavigationItem:navigationItem animated:YES];
    
    
    [self.view addSubview:navigationBar];
    
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width,self.view.frame.size.height- 44)];
    
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    
    heightOfAddCell=CELLNORMAL_HEIGHT;
    buttonChangeFlag=0;//等于0的时候说明是原始样子
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];//隐藏状态栏
}
-(void)clickLeftButton
{
    NSLog(@"left");
    //[self showDialog:@"点击了导航栏左边按钮"];
    
}
-(bool)prefersStatusBarHidden{
    return YES;
}

-(void)clickRightButton
{
    NSLog(@"right");
    //[self showDialog:@"点击了导航栏右边按钮"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    rowOfAddButton =dataArr.count;
    
    return dataArr.count+1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.row==rowOfAddButton) {
        return heightOfAddCell;
        
    }else{
        return 132;
    }
//    NSLog(@"%ld",(long)indexPath.row);
//    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    
    
    if (indexPath.row==rowOfAddButton) {
        [cell setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, heightOfAddCell)];
        
        
        UIButton *testButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 2, tableView.frame.size.width-40, 40)];
        [testButton setTitle:@"添加" forState:UIControlStateNormal];
        [testButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [testButton addTarget:self action:@selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [testButton setBackgroundColor:[UIColor whiteColor]];
        [cell addSubview:testButton];
        
        if (buttonChangeFlag==0) {//点击了偶数次按钮
            [cell setBackgroundColor:[UIColor blueColor]];
  
        }else if(buttonChangeFlag==1){//点击了奇数次按钮
            UITextField *fieldForInput=[[UITextField alloc]initWithFrame:CGRectMake(4, CELLNORMAL_HEIGHT+2, tableView.frame.size.width-CELLADDBUTTON_WIDTH-8, CELLNEWAREA_HEIGHT-4)];
            fieldForInput.delegate=self;
            [fieldForInput addTarget:self action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
            [fieldForInput setBackgroundColor:[UIColor whiteColor]];
            [fieldForInput setBorderStyle:UITextBorderStyleNone];
            [fieldForInput.layer setBorderWidth:1.0];
            [fieldForInput.layer setBorderColor:[UIColor blackColor].CGColor];
            [fieldForInput.layer setCornerRadius:5.0];
            [cell addSubview:fieldForInput];
            
            UIButton *buttonForInput=[[UIButton alloc]initWithFrame:CGRectMake(tableView.frame.size.width-CELLADDBUTTON_WIDTH, CELLNORMAL_HEIGHT, CELLADDBUTTON_WIDTH, CELLNEWAREA_HEIGHT)];
            [buttonForInput setTitle:@"保存" forState:UIControlStateNormal];
            [buttonForInput setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [buttonForInput setBackgroundColor:[UIColor greenColor]];
            [buttonForInput addTarget:self action:@selector(creatItem:) forControlEvents:UIControlEventTouchUpInside];

            [cell addSubview:buttonForInput];
            [cell setBackgroundColor:[UIColor redColor]];
        }
        
    }else{
//        [cell setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, 132)];
        //用于添加边框的view
        UIView *viewForContain=[[UIView alloc]initWithFrame:CGRectMake(4, 2, tableView.frame.size.width-8, 132-4)];
        [viewForContain.layer setBorderColor:[UIColor blackColor].CGColor];
        [viewForContain.layer setBorderWidth:1.0];
        [viewForContain.layer setCornerRadius:5.0];
        
        
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(2, 1, viewForContain.frame.size.width-4, 40)];
        UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(2, 43, viewForContain.frame.size.width-4, 40)];
        UILabel *lable3=[[UILabel alloc]initWithFrame:CGRectMake(2, 85, viewForContain.frame.size.width-4, 40)];
        
        
        lable1.text=@"11111";
        lable2.text=@"22222";
        lable3.text=@"33333";
        [lable1 setBackgroundColor:[UIColor clearColor]];
        [lable2 setBackgroundColor:[UIColor clearColor]];
        [lable3 setBackgroundColor:[UIColor clearColor]];
        
        [viewForContain addSubview:lable1];
        [viewForContain addSubview:lable2];
        [viewForContain addSubview:lable3];
        
        [cell addSubview:viewForContain];
    }

    
    
    
    return cell;
}
-(void)testButtonAction:(id)sender{
    UIButton *senderButton=(UIButton *)sender;
    UITableViewCell *cellFromButton=(UITableViewCell *)[senderButton superview];
    if (buttonChangeFlag==0) {
        heightOfAddCell=cellFromButton.frame.size.height+CELLNEWAREA_HEIGHT;//44;
        buttonChangeFlag=1;
    }else{
        heightOfAddCell=cellFromButton.frame.size.height-CELLNEWAREA_HEIGHT;//44;
        buttonChangeFlag=0;
    }
    [myTableView reloadData];//使用reloaddata能够更好地控制cell的变化
}
-(void)creatItem:(id)sender{
    NSLog(@"creatItem");
    
    UIButton *senderButton=(UIButton *)sender;
    UITableViewCell *cellFromButton=(UITableViewCell *)[senderButton superview];
    NSArray *viewArray=[cellFromButton subviews];
    
    for (int i=0; i<viewArray.count; i++) {
        [[viewArray objectAtIndex:i] resignFirstResponder];
    }
//    UITextField *textInCell=[viewArray objectAtIndex:1];
//    [textInCell resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //-----------上移-----------
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 200, self.view.frame.size.width, self.view.frame.size.height);
    //设置动画结束
    [UIView commitAnimations];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //-----------下移----------
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 200, self.view.frame.size.width, self.view.frame.size.height);
    //设置动画结束
    [UIView commitAnimations];
}
-(void)textFiledReturnEditing:(id)sender{
    [sender resignFirstResponder];
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
