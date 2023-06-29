//
//  SMMessageView.m
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import "SMMessageView.h"
#import "SMMessageViewBaseCell.h"
#import "SMMessageViewNormalCell.h"
#import "SMMessageViewSystemCell.h"

@interface SMMessageView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation SMMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.msgs = [NSMutableArray new];
        [self initView];
    }
    return self;
}

- (void)setMsgs:(NSMutableArray<SMMessage *> *)msgs {
    _msgs = msgs;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Privete Method

- (void)initView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self tableViewRegisterClass];
}

/// 列表注册cell
- (void)tableViewRegisterClass {
    [self.tableView registerClass:SMMessageViewNormalCell.class
           forCellReuseIdentifier:NSStringFromClass(SMMessageViewNormalCell.class)];
    [self.tableView registerClass:SMMessageViewSystemCell.class
           forCellReuseIdentifier:NSStringFromClass(SMMessageViewSystemCell.class)];
}

#pragma mark -
#pragma mark Public Method

- (void)insertMsg:(SMMessage *)msg {
    if (msg) {
        [self.msgs addObject:msg];
        [self.tableView reloadData];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource


// 列表Row个数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.msgs.count;
}

// 列表Sections个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 初始化cell
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SMMessage *msg = self.msgs[indexPath.row];
    SMMessageViewBaseCell *cell;
    if (msg.type == SMMessageTypeNormal) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SMMessageViewNormalCell class])];
    } else if (msg.type == SMMessageTypeSystem) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SMMessageViewSystemCell class])];
    }
    [cell updateData:msg];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

// 列表高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SMMessage *msg = self.msgs[indexPath.row];
    if (msg) {
        return msg.height > 0 ? msg.height : 48;
    }
    return 48;
}

// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
