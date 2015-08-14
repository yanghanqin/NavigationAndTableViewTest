//
//  TableViewController.m
//  NavigationTest
//
//  Created by user on 15/8/4.
//  Copyright (c) 2015年 NCEPU. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController
{
    UITableView *myTableView;
    UINavigationBar *navigationBar;
    
    NSMutableArray *dataArr;
    
    NSInteger rowOfAddButton;//用于存储添加按钮所在的cell的row的值
    CGFloat heightOfAddCell;//用于存储存放添加按钮所在的cell的高度
    
    
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
    
    heightOfAddCell=44;
    
    
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==rowOfAddButton) {
        return heightOfAddCell;
    }else{
        return 132;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
//    UITableViewCell *cell=[[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 132)];
    
    
    if (indexPath.row==rowOfAddButton) {
        UIButton *testButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 2, tableView.frame.size.width-40, 40)];
        [testButton setTitle:@"添加" forState:UIControlStateNormal];
        [testButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
//        [cell setBackgroundColor:[UIColor blackColor]];
        [testButton addTarget:self action:@selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [testButton setBackgroundColor:[UIColor whiteColor]];
        [cell setBackgroundColor:[UIColor blueColor]];
        [cell addSubview:testButton];
        
    }else{
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
//    [cell addSubview:lable1];
//    [cell addSubview:lable2];
//    [cell addSubview:lable3];

//    cell.textLabel.text=[dataArr objectAtIndex:indexPath.row];
    
    
    
    return cell;
}
-(void)testButtonAction:(id)sender{
    UIButton *senderButton=(UIButton *)sender;
//    [senderButton setBackgroundColor:[UIColor blackColor]];
    UITableViewCell *cellFromButton=(UITableViewCell *)[senderButton superview];
    [cellFromButton setFrame:CGRectMake(cellFromButton.frame.origin.x, cellFromButton.frame.origin.y, cellFromButton.frame.size.width, cellFromButton.frame.size.height+44)];
    [cellFromButton setBackgroundColor:[UIColor redColor]];
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
