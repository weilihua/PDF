//
//  QMAsync.m
//  Solo
//
//  Created by 江林 on 2018/2/28.
//  Copyright © 2018年 Starmaker Interactive Inc. All rights reserved.
//

#include <pthread/pthread.h>
#import "QMAsync.h"

void go(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), block);
}

void run(dispatch_block_t block) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
