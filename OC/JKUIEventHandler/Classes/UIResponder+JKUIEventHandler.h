//
//  UIResponder+JKUIEventHandler.h
//  JKUIEventHandler
//
//  Created by JackLee on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (JKUIEventHandler)

@property (nonatomic, weak, readonly, nullable) __kindof UIResponder *jk_nextResponder;
/// 设置jk_nextResponder
- (void)configJk_nextResponder:(__kindof UIResponder*)jk_nextResponder;

@end

NS_ASSUME_NONNULL_END
