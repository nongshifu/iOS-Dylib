#import <WebKit/WebKit.h>
#import "LtShengMing.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>

#import "SCLAlertView.h"
#import "LtShengMing.h"
#import <dlfcn.h>


//默认 根域名
#define homeurl @"https://iosgods.cn/html/game/"
//默认辅助动态库文件名
#define dylibname @"wzry.dylib"
//默认辅助更新的配置文件
#define fzjson @"wzry.txt"
static NSString *MUFENGKEY  =   @"MUFENG";

@implementation NSObject (hook)
//1下载动态库
- (BOOL)xzdylib;
{
    @autoreleasepool {
        // 取得沙盒目录
        NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 要检查的文件目录
        NSString *filePath = [localPath  stringByAppendingPathComponent:dylibname];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSLog(@"dylib存在");
            [NSObject xzjson];
        }
        else {
            
            
            NSLog(@"dylib不存在");
            //开始下载
            NSString *pinjieurl =[NSString stringWithFormat:@"%@%@",homeurl,dylibname];
            NSURL *url = [NSURL URLWithString:pinjieurl];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDownloadTask *downloadTaskdylib = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
            {
                NSLog(@"dylib缓存成功= %@", location);
                    //转移文件
                NSString *cache = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  lastObject];
                NSString *filePath = [cache stringByAppendingPathComponent:response.suggestedFilename];
                        
                NSLog(@"1111111🆚下载dylib完成 = %@",filePath);
                NSURL *toURL = [NSURL fileURLWithPath:filePath];
                [[NSFileManager defaultManager] moveItemAtURL:location toURL:toURL error:nil];
                if (error) {
                        return;
                    } else
                    {
                        
                        //提示下载成功
                        [NSObject xzjson];
                    }
                    
                }];
            [downloadTaskdylib resume];
        }
        
        return 0;
    }
    
}
//2下载json
- (BOOL)xzjson;
{
    @autoreleasepool {
        //每次启动下载 存在就跳过
        NSString *pinjieurl =[NSString stringWithFormat:@"%@%@",homeurl,fzjson];
        NSURL *url = [NSURL URLWithString:pinjieurl];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *downloadTasktxt = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            NSLog(@"txt缓存成功= %@", location);
                //转移文件
            NSString *cache = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  lastObject];
            NSString *filePath = [cache stringByAppendingPathComponent:response.suggestedFilename];
                    
            NSLog(@"222222🆚下载txt完成 = %@",filePath);
            NSURL *toURL = [NSURL fileURLWithPath:filePath];
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:toURL error:nil];
            if (error) {
                    return;
                } else
                {
                    //下载json完成
                    [NSObject jxjson];
                }
                
            }];
        [downloadTasktxt resume];
        return 0;
    }
    
}

//解析服务器json
- (BOOL)jxjson;//4
{
    @autoreleasepool {
        //解析服务器版本
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",homeurl,fzjson];
        
        NSLog(@"打印问题的URL%@",urlStr);
        
        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        NSError *error;
        NSDictionary *json1 = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&error];
        NSArray *webbanben = [json1 objectForKey:@"banben"];
        NSLog(@"333333🆚服务器版本: %@",webbanben);
        //解析本地版本
        NSLog(@"解析服务器json测试错误1");
        NSString *jsonPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),fzjson];
        NSData *data2 = [NSData dataWithContentsOfFile:jsonPath];
        NSDictionary *json2 = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:&error];
        
        NSArray *bdbanben = [json2 objectForKey:@"banben"];
        NSLog(@"4444444🆚当前版本: %@",bdbanben);
        //对比版本
        [self versionCompareOldStr:(NSString *)bdbanben andNewStr: (NSString *)webbanben];
        return 0;
    }
    
}
//对比本都和web   //5
- (BOOL)versionCompareOldStr:(NSString *)bdbanben andNewStr: (NSString *)webbanben
{
    @autoreleasepool
    {
        if ([bdbanben compare:webbanben options:NSNumericSearch] == NSOrderedDescending)
        {
            
            //如果本地版本大于服务器版本
            NSLog(@"555AAAA🆚本地版本大于服务器版本不执行任何");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //解析服务器版本
                NSString *urlStr = [NSString stringWithFormat:@"%@%@",homeurl,fzjson];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
                NSError *error;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                
                NSString *gonggao = [json objectForKey:@"gonggao"];
                NSString *time = [json objectForKey:@"time"];
                //更新提示并且删除
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                [alert addButton:@"在线更新" actionBlock:^{
                    
                    [NSObject scwenjian];
                    
                    
                    
                }];
                [alert addButton:time actionBlock:^{
                    
                    [NSObject scwenjian];
                    
                    
                    
                }];
                [alert addButton:@"取消更新" actionBlock:^{
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [NSObject jzdylib];
                    });
                   
                }];
                [alert showSuccess:@"辅助更新" subTitle:gonggao closeButtonTitle:nil duration:10];
            });
            return 0;
           
        }else if ([bdbanben compare:webbanben options:NSNumericSearch] == NSOrderedSame)
        {
            //版本相等不操作
            NSLog(@"555BBBB🆚等于服务器版本无需更新");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject jzdylib];
            });
            
            return 0;
        }else
        {
            NSLog(@"5555CCCC🆚小于服务器版本");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //更新提示并且删除
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                [alert addButton:@"重启更新" actionBlock:^{
                    
                    [NSObject scwenjian];
                    
                    
                }];
                [alert addButton:@"取消更新" actionBlock:^{
                    NSLog(@"🆚取消更新🆚");
                    [NSObject jzdylib];
                }];
                [alert showSuccess:@"辅助更新" subTitle:@"新版本功能" closeButtonTitle:nil duration:10];
            });
            
        }
    return 0;
    }
    
}

//加载远程辅助
- (BOOL)jzdylib//6
{
    @autoreleasepool {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *frameworkPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),dylibname];
            libHandle = NULL;
            libHandle = dlopen([frameworkPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
            NSString *str = @"加载iOsGods.Cn失败!";
            
            if (libHandle == NULL) {
                char *error = dlerror();
                NSLog(@"3error: %s", error);
            } else {
                NSLog(@"66666🆚加载iOsGods.Cn成功打印");
                str = @"加载iOsGods.Cn成功";
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                [alert showNotice:@"iOsGoDsCn" subTitle:@"辅助加载成功感谢使用" closeButtonTitle:nil duration:2];
               
            }
        });
        
        return 0;
    }
    
    
}
//删除辅助和json
- (BOOL)scwenjian;//7
{
    @autoreleasepool {
        NSString *txt = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),fzjson];
        NSString *dylib = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),dylibname];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:dylib error:NULL];
        [fileManager removeItemAtPath:txt error:NULL];
        NSLog(@"77777🆚删除dylib和txt成功");
        if ([fileManager removeItemAtPath:txt error:NULL])
        {
            
        }else{
            NSLog(@"8888🆚重新下载");
    //        exit(0);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @autoreleasepool {
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert addTimerToButtonIndex:0 reverse:YES];
                    [NSObject xzdylib];
                    [alert showWaiting:@"更新" subTitle:@"更新完毕自动加载辅助" closeButtonTitle:@"下载中请稍后" duration:5];
                }
                
                
            });
        }
        return 0;
    }
    
}


@end
