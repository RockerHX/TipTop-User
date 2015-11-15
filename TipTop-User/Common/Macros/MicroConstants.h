//
//  MicroCommon.h
//
//  Created by Andy Shaw on 14/12/24.
//

#ifndef MaintenanceCar_MicroCommons_h
#define MaintenanceCar_MicroCommons_h

#pragma mark - System Framework Singleton Define
#define APP_DELEGATE_INSTANCE               ((AppDelegate*)([UIApplication sharedApplication].delegate))
#define USER_DEFAULT                        [NSUserDefaults standardUserDefaults]
#define NOTIFICATION_CENTER                 [NSNotificationCenter defaultCenter]

#define CLASS_NAME(Class)                   NSStringFromClass([Class class])

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

#define EMPTY_STRING            @""

#define STR(key)                NSLocalizedString(key, nil)

#define PATH_OF_APP_HOME        NSHomeDirectory()
#define PATH_OF_TEMP            NSTemporaryDirectory()
#define PATH_OF_DOCUMENT        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

#define LabelSystemFont(size)   [UIFont systemFontOfSize:size]

#define WEAK_SELF(weakSelf)     __weak __typeof(&*self)weakSelf = self

#endif