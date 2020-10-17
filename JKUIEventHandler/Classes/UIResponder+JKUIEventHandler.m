//
//  UIResponder+JKUIEventHandler.m
//  JKUIEventHandler
//
//  Created by JackLee on 2020/10/16.
//

#import "UIResponder+JKUIEventHandler.h"
#import <objc/runtime.h>

static const void *jk_nextResponderKey = "jk_nextResponderKey";

@implementation UIResponder (JKUIEventHandler)
- (void)configJk_nextResponder:(__kindof UIResponder*)jk_nextResponder
{
    [self setJk_nextResponder:jk_nextResponder];
}
- (void)setJk_nextResponder:(UIResponder *)jk_nextResponder
{
#if DEBUG
    NSAssert(jk_nextResponder, @"jk_nextResponder can't be nil");
#endif
    objc_setAssociatedObject(self, jk_nextResponderKey, jk_nextResponder, OBJC_ASSOCIATION_ASSIGN);
}

- (UIResponder *)jk_nextResponder
{
    UIResponder *responser = objc_getAssociatedObject(self, jk_nextResponderKey);
    if (responser) {
        return responser;
    }
    return self.nextResponder;
}
@end
