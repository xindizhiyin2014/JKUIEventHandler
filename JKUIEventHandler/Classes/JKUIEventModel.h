//
//  JKUIEventModel.h
//  JKUIEventHandler
//
//  Created by JackLee on 2020/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKUIEventModel : NSObject
/// 数据
@property (nonatomic, strong, nullable) id data;
/// 回执
@property (nonatomic, copy, nullable) void(^eventReceiptBlock)(id _Nullable data);

/// 初始响应者
@property (nonatomic, strong) __kindof UIResponder *originResponder;

@end

NS_ASSUME_NONNULL_END
