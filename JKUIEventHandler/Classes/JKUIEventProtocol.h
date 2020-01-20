//
//  JKUIEventProtocol.h
//  JKUIEventHandler
//
//  Created by JackLee on 2020/1/20.
//

#ifndef JKUIEventProtocol_h
#define JKUIEventProtocol_h
typedef NS_ENUM(NSInteger, JKUIEventResult)
{
 JKUIEventResultIgnore = 0,       /// 忽略事件,事件会继续传递，直到结束
 JKUIEventResultHandle,           /// 响应事件，阻止事件继续传递
 JKUIEventResultHandleDelivery    /// 响应事件，并让事件继续传递
}; /// 事件处理结果

@protocol JKUIEventProtocol <NSObject>

@optional

/// 接收到链式事件
/// @param eventName 事件名称
/// @param data 数据
- (JKUIEventResult)jk_receiveChainEvent:(nonnull NSString *)eventName
                        data:(nullable id)data;

/// 接收广播事件
/// @param eventName 事件名称
/// @param data 数据
- (JKUIEventResult)jk_receiveBroadcastEvent:(nonnull NSString *)eventName
                            data:(nullable id)data;

@end
#endif /* JKUIEventProtocol_h */
