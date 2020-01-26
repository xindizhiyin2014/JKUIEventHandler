//
//  JKUIEventHandler.h
//  JKUIEventHandler
//
//  Created by JackLee on 2020/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKUIEventHandler : NSObject

/// 发送链式事件,事件根据响应链朝着对应的VC层级传递
/// @param eventName 事件名称
/// @param data 数据
/// @param responder 初始响应者
+ (void)sendChainEvent:(nonnull NSString *)eventName
                  data:(nullable id)data
             responder:(nonnull __kindof UIResponder *)responder;

/// 广播事件,事件根据视图层级,从responder层朝着顶层传递
/// @param eventName 事件名称
/// @param data 数据
/// @param responder 响应者
+ (void)broadcastEvent:(nonnull NSString *)eventName
                  data:(nullable id)data
             responder:(nonnull __kindof UIResponder *)responder;

@end

NS_ASSUME_NONNULL_END
