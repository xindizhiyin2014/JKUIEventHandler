//
//  JKUIEventHandler.m
//  JKUIEventHandler
//
//  Created by JackLee on 2020/1/20.
//

#import "JKUIEventHandler.h"
#import "JKUIEventProtocol.h"

@implementation JKUIEventHandler

+ (void)sendChainEvent:(nonnull NSString *)eventName
                  data:(nullable id)data
             responder:(nonnull __kindof UIResponder *)responder
{
#if DEBUG
    NSAssert(eventName, @"eventName can't be nil");
    NSAssert(responder, @"responder can't be nil");
    NSAssert([responder isKindOfClass:[UIResponder class]], @"make sure [responder isKindOfClass:[UIResponder class]] be YES");
#endif
    if (!eventName) {
        return;
    }
    if (!responder) {
        return;
    }
    if (![responder isKindOfClass:[UIResponder class]]) {
        return;
    }
    UIResponder <JKUIEventProtocol>*currentResponder = (UIResponder <JKUIEventProtocol>*)responder.nextResponder;
    while (currentResponder
           && ![currentResponder isKindOfClass:[UIWindow class]]
           && ![currentResponder isKindOfClass:[UIApplication class]]) {
        if ([currentResponder conformsToProtocol:@protocol(JKUIEventProtocol)]) {
            if ([currentResponder respondsToSelector:@selector(jk_receiveChainEvent:data:responder:)]) {
                JKUIEventResult result = [currentResponder jk_receiveChainEvent:eventName data:data responder:responder];
                if (result == JKUIEventResultHandleDelivery) {// 事件继续传递
                   currentResponder = (UIResponder <JKUIEventProtocol>*)currentResponder.nextResponder;
                } else {
                    break;
                }
            } else {
               currentResponder = (UIResponder <JKUIEventProtocol>*)currentResponder.nextResponder;
            }
        } else {
            currentResponder = (UIResponder <JKUIEventProtocol>*)currentResponder.nextResponder;
        }
    }
}


+ (void)broadcastEvent:(nonnull NSString *)eventName
                  data:(nullable id)data
             responder:(nonnull __kindof UIResponder *)responder
{
    #if DEBUG
        NSAssert(eventName, @"eventName can't be nil");
        NSAssert(responder, @"responder can't be nil");
        NSAssert([responder isKindOfClass:[UIResponder class]], @"make sure [responder isKindOfClass:[UIResponder class]] be YES");
    #endif
        if (!eventName) {
            return;
        }
        if (!responder) {
            return;
        }
        if (![responder isKindOfClass:[UIResponder class]]) {
            return;
        }
        
    if ([responder isKindOfClass:[UIViewController class]]) {
        __kindof UIViewController <JKUIEventProtocol>*responderVC = (__kindof UIViewController <JKUIEventProtocol>*)responder;
        if ([responderVC conformsToProtocol:@protocol(JKUIEventProtocol)]
            && [responderVC respondsToSelector:@selector(jk_receiveBroadcastEvent:data:)]) {
            JKUIEventResult result = [responderVC jk_receiveBroadcastEvent:eventName data:data];
            if (result == JKUIEventResultHandle) { // 事件停止继续广播
                return;
            }
        }
        if (responderVC.childViewControllers.count > 0) {
            for (__kindof UIViewController *childVC in responderVC.childViewControllers) {
               [self broadcastEvent:eventName data:data responder:childVC];
            }
        }
        
        __kindof UIView <JKUIEventProtocol>*view = (__kindof UIView <JKUIEventProtocol>*)responderVC.view;
        if ([view conformsToProtocol:@protocol(JKUIEventProtocol)]
            && [view respondsToSelector:@selector(jk_receiveBroadcastEvent:data:)]) {
            JKUIEventResult result = [view jk_receiveBroadcastEvent:eventName data:data];
            if (result == JKUIEventResultHandle) { // 事件停止继续广播
                return;
            }
        }
        if (responderVC.view.subviews.count > 0) {
            for (__kindof UIView *subview in responderVC.view.subviews) {
                [self broadcastEvent:eventName data:data responder:subview];
            }
        }
    } else if([responder isKindOfClass:[UIView class]]) {
        __kindof UIView <JKUIEventProtocol>*view = (__kindof UIView <JKUIEventProtocol>*)responder;
        if ([view conformsToProtocol:@protocol(JKUIEventProtocol)]
            && [view respondsToSelector:@selector(jk_receiveBroadcastEvent:data:)]) {
            JKUIEventResult result = [view jk_receiveBroadcastEvent:eventName data:data];
            if (result == JKUIEventResultHandle) {// 事件停止继续广播
                return;
            }
        }
        if (view.subviews.count > 0) {
            for (__kindof UIView *subview in view.subviews) {
                [self broadcastEvent:eventName data:data responder:subview];
            }
        }
    }
}
@end