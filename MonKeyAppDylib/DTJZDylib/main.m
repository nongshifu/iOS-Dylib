#import <Foundation/Foundation.h>
#import "LtShengMing.h"
#import <WebKit/WebKit.h>
#import "SCLAlertView.h"
//程序主文件代码

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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([NSObject xzdylib]) {
               
            }
        });
    }
    
}

@end


