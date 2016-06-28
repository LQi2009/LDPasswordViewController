//
//  ViewController.m
//  LZPasswordView
//
//  Created by Artron_LQQ on 16/6/1.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "ViewController.h"
#import "LZPasswordViewController.h"
#import "LZNumberTool.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    BOOL _isTurnOn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];

    _isTurnOn = [LZNumberTool getNumberPasswordEnableState];
    self.title = @"设置密码选项";
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    _tableView = table;
    [self.view addSubview:table];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else {
        
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return _isTurnOn?2:1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    if (section == 0) {
//        return @"设置选项";
//    } else {
//        return @"示例";
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        
        if (indexPath.section == 0) {
            cell.textLabel.text = @"开启密码设置";
            
            UISwitch *sw = [[UISwitch alloc]init];
            
            [sw addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = sw;
        }

    }
    
    if (indexPath.section == 0) {
        
        UISwitch *sw = (UISwitch*)cell.accessoryView;
        sw.on = _isTurnOn;
    }
    
    
    if (indexPath.section == 1) {
        NSArray *arr = @[@"设置密码",@"验证密码",@"更改密码"];
        
        cell.textLabel.text = arr[indexPath.row];
    }
    
    
    return cell;
}

- (void)switchChanged:(UISwitch*)sw {
    
    _isTurnOn = sw.on;
    [LZNumberTool saveNumberPasswordEnableState:sw.on];
    
    
    NSLog(@"%d",[LZNumberTool getNumberPasswordEnableState]);
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        LZPasswordViewController *password = [[LZPasswordViewController alloc]initWithState:indexPath.row];
        
//        switch (indexPath.row) {
//            case 0:
//                password = [[LZPasswordViewController alloc]initWithState:0];
//                break;
//                
//            default:
//                break;
//        }
        [self.navigationController pushViewController:password animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
