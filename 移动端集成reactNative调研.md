---
title: "移动端集成reactNative调研分享"
description: ""
date: 2017-11-14T10:24:42+08:00
author: "uncoder"
tags: ["react-native","android","ios","expo","gradle","bundle"]
categories: ["前端相关"]
slug: ""
---

## 全新项目初始化

[文档地址](https://facebook.github.io/react-native/docs/getting-started.html)
<!--more-->

- 方式一：expo开发

```bash
npm install -g create-react-native-app
create-react-native-app AwesomeProject
cd AwesomeProject
npm start
使用expo扫描二维码即可
```

- 方式二：手动初始化

```bash
brew install node
brew install watchman
npm install -g react-native-cli
react-native init AwesomeProject
cd AwesomeProject
react-native run-ios
```

## 基于现有项目

[文档地址](https://facebook.github.io/react-native/docs/integration-with-existing-apps.html)

- android篇注意事项

```javascript
1，build.gradle文件有多个，根目录有一个全局配置，应用中有一个本应用配置
2，gradle下载失败，可配置翻墙，编辑根目录gradle.properties，配置代理
systemProp.http.proxyHost=127.0.0.1
systemProp.http.proxyPort=端口号
systemProp.https.proxyHost=127.0.0.1
systemProp.https.proxyPort=端口号
3，react-native开发者菜单需要手动开启，默认关闭
.setUseDeveloperSupport(true)
4，开发者菜单需要悬浮窗权限
(1)API 23版本以下
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW"/>
(2)API 23版本以上
@Override
public boolean onKeyUp(int keyCode, KeyEvent event) {
    if (keyCode == KeyEvent.KEYCODE_MENU && mReactInstanceManager != null) {
        mReactInstanceManager.showDevOptionsDialog();
        return true;
    }
    return super.onKeyUp(keyCode, event);
}
5，模拟器运行时提示arm错误，在本应用的/build.gradle文件中字段defaultConfig添加
ndk {
  abiFilters "armeabi-v7a", "x86"
}
packagingOptions {
  exclude "lib/arm64-v8a/librealm-jni.so"
}
6，集成antd-mobile问题
//不能区分web和native，
//https://github.com/ant-design/ant-design-mobile/issues/2054
//按照下面方法使用
import Button from 'antd-mobile/lib/button';
7，真机调试，需要设置端口
8，npm使用脚本
"scripts": {
  "start": "node node_modules/react-native/local-cli/cli.js start",
  "build": "react-native bundle --platform android --dev false --entry-file index.js --bundle-output app/src/main/assets/index.android.bundle --assets-dest app/src/main/res/"
}
```

- iOS篇注意事项

```javascript
1，podfile配置
source 'https://github.com/CocoaPods/Specs.git'
# Required for Swift apps，指定ios版本
platform :ios, '11.1'
use_frameworks!
# The target name is most likely the name of your project.
target '项目名称' do
  # 第三方依赖
  pod 'DoubleConversion', :podspec => '../node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
  pod 'GLog', :podspec => '../node_modules/react-native/third-party-podspecs/GLog.podspec'
  pod 'Folly', :podspec => '../node_modules/react-native/third-party-podspecs/Folly.podspec'
  # Explicitly include Yoga if you are using RN >= 0.42.0
  pod "yoga", :path => "../node_modules/react-native/ReactCommon/yoga"
  # Your 'node_modules' directory is probably in the root of your project,
  # but if not, adjust the `:path` accordingly
  pod 'React', :path => '../node_modules/react-native', :subspecs => [
    'Core',
    'CxxBridge', # Include this for RN >= 0.47
    'DevSupport', # Include this to enable In-App Devmenu if RN >= 0.43
    'RCTText',
    'RCTNetwork',
    'RCTWebSocket', # needed for debugging
    # Add any other subspecs you want to use in your project
  ]
end
2，若运行时提示报错 'fishhook/fishhook.h' file not found
#import <React/RCTDefines.h>
修改为
#import "fishhook.h"
3，若模拟器提示failed to load，可Info.plist加入本地域名安全设置
<key>NSAppTransportSecurity</key>
<dict>
<key>NSExceptionDomains</key>
<dict>
    <key>localhost</key>
    <dict>
        <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
        <true/>
    </dict>
</dict>
4，提示JS Exception: Application。。 has not been registered.，项目名需要保持一致
AppRegistry.registerComponent('项目名', () => App);
与
let rootView = RCTRootView(
    moduleName: "项目名"
)
5，xcode运行
product => scheme => Edit scheme...
info => build Configuration选择打包版本 =》 Debug／Release
6，npm 脚本
"scripts": {
    "start": "node node_modules/react-native/local-cli/cli.js start",
    "build": "react-native bundle --entry-file index.js --platform ios --dev false --bundle-output release_ios/main.jsbundle --assets-dest release_ios/"
}
```

## reactNative开发流程

```bash
1, 生成jsBoudle
2, 使用ios/android对应的ReactRootView进行加载服务器/本地资源文件
```

```java
android 入口文件示例代码
public class MainActivity extends AppCompatActivity  implements DefaultHardwareBackBtnHandler{
    private ReactRootView mReactRootView;
            private ReactInstanceManager mReactInstanceManager;
            public static final int OVERLAY_PERMISSION_REQ_CODE = 101;
            @Override
            protected void onCreate(Bundle savedInstanceState) {
                super.onCreate(savedInstanceState);
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    if (!Settings.canDrawOverlays(this)) {
                        Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                                Uri.parse("package:" + getPackageName()));
                        startActivityForResult(intent, OVERLAY_PERMISSION_REQ_CODE);
                    }
        }
        mReactRootView = new ReactRootView(this);
        mReactInstanceManager = ReactInstanceManager.builder()
                .setApplication(getApplication())
                .setBundleAssetName("index.android.bundle")
                .setJSMainModulePath("index")
                .addPackage(new MainReactPackage())
//                .setUseDeveloperSupport(BuildConfig.DEBUG)
                .setUseDeveloperSupport(true)
                .setInitialLifecycleState(LifecycleState.RESUMED)
                .build();
        mReactRootView.startReactApplication(mReactInstanceManager, "MyReactNativeApp", null);

        setContentView(mReactRootView);
    }
    @Override
    protected void onPause() {
        super.onPause();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostPause(this);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostResume(this, this);
        }
        Log.e("onResume","-----------------");
    }
    @Override
    protected void onDestroy() {
        super.onDestroy();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostDestroy();
        }
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == OVERLAY_PERMISSION_REQ_CODE) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if (!Settings.canDrawOverlays(this)) {
                    // SYSTEM_ALERT_WINDOW permission not granted...
                }
            }
        }
    }
    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_MENU && mReactInstanceManager != null) {
            mReactInstanceManager.showDevOptionsDialog();
            return true;
        }
        return super.onKeyUp(keyCode, event);
    }
    @Override
    public void invokeDefaultOnBackPressed() {
        super.onBackPressed();
    }
}
```

```java
ios示例代码
import UIKit
import React

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleClick(_ sender: Any) {
        NSLog("Hello")
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")

//        let filePath = Bundle.main.path(forResource: "main", ofType: "jsbundle")
//        let jsCodeLocation = URL(fileURLWithPath: filePath!)

        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "reactApp",
            initialProperties: nil,
            launchOptions: nil
        )
        let vc = UIViewController()
        vc.view = rootView
        self.present(vc, animated: true, completion: nil)
    }
}
```
