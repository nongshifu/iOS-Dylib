#import <Foundation/Foundation.h>
#import "LtShengMing.h"
#import <WebKit/WebKit.h>
#import "SCLAlertView.h"
@interface NSObject ()<NSURLConnectionDataDelegate>
- (BOOL)xzdylib;//1
- (BOOL)xzjson;//2
- (BOOL)jxjson;//3

- (BOOL)duibi;//5
- (BOOL)jzdylib;//6
- (BOOL)scwenjian;//7

@end

@implementation main : NSObject
static void __attribute__((constructor)) entry()
{
    @autoreleasepool {
        
        NSLog(@"到这里了~~~~~~~~~·");
        [NSObject xzdylib];
    }
}

@end
