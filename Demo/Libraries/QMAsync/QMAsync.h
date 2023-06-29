//
//  QMAsync.h
//  Solo
//
//  Created by 江林 on 2018/2/28.
//  Copyright © 2018年 Starmaker Interactive Inc. All rights reserved.
//

#ifndef QMAsync_h
#define QMAsync_h

#include <CoreFoundation/CoreFoundation.h>

//

/**
 异步执行block

 @param block 需要执行的block
 */
CF_EXPORT void go(dispatch_block_t block);

/**
 如果调研线程是主线程，同步执行block方法，否则异步在主线程中运行

 @param block 需要执行的block
 */
CF_EXPORT void run(dispatch_block_t block);

#endif /* QMAsync_h */
