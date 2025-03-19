# HYFDynamicIsland  灵动岛Demo

### 在主项目中，新建子target，并修改info.plist


![新建](https://github.com/user-attachments/assets/fc82e6d1-1f4d-4f30-ac51-74c674227f6d)


![勾选](https://github.com/user-attachments/assets/942d7bf9-0fb0-4a67-b3af-0c0129daa829)


![添加项，并设置为YES](https://github.com/user-attachments/assets/88ce6ff7-17f6-4580-8d9a-4ac1feb699aa)



在build setting里也修改一下YES

![Xnip2025-03-19_15-10-01](https://github.com/user-attachments/assets/8dfe5ad3-b52a-4389-9c7f-ae14589e0fb6)



### 使用默认样式
新建完成之后其实有个默认样式，但是我们还不能直接使用，因为这时候在主项目里调用不了。

我们新建一个Attributes文件（主要用于数据模型和传值），注意：这个文件需要勾选主工程和子工程才能使用


![Xnip2025-03-19_15-13-28](https://github.com/user-attachments/assets/591b5d3a-62bc-4b98-b512-3433af429465)


在xxxActivityLiveActivity文件里有默认的xxxAttributes结构体，我们把这部分代码剪切到新建的Attributes文件里，这样主工程就能访问到了
默认的代码结构：


![image](https://github.com/user-attachments/assets/990dbbb9-20ed-45f5-899f-cbcef2a076a6)


### 在主工程中调用
在主工程中使用button调用方法

```
if #available(iOS 16.1, *) {
    let attributes = testDemoAttributes(name: "测试名称")
    let contentState = testDemoAttributes.ContentState(emoji: "😀")
    
    do {
        let activity = try Activity<testDemoAttributes>.request(
            attributes: attributes,
            contentState: contentState,
            pushType: nil
        )
        print("成功请求 Live Activity: \(activity.id)")
    } catch {
        print("请求 Live Activity 失败: \(error)")
    }
}
```

不出意外的话我们就能看到灵动岛的样式了


![Xnip2025-03-19_15-18-29](https://github.com/user-attachments/assets/252a2830-2b81-4341-b67c-deb4f1f94499)


![Xnip2025-03-19_15-18-38](https://github.com/user-attachments/assets/7dd42640-1753-4870-a7b3-8b7cf831e1bc)


![Xnip2025-03-19_15-18-51](https://github.com/user-attachments/assets/327ea0d2-1643-40f6-9c32-7ff0bbfb7e81)



### 自定义样式


当然，系统样式一般很难满足需求，这时候就需要自定义样式，我们先修改数据格式

```
struct DynamicIsActivityAttributes: ActivityAttributes {
    public typealias dynamicIsActivityStatus = ContentState

    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
//        var emoji: String
        var driverName: String
        var driverStatus : Int //1待接单， 2配送中 3已完成
        var deliveryTimer: ClosedRange<Date>
    }

    // Fixed non-changing properties about your activity go here!
//    var name: String
    var numberOfPizzas: Int
    var totalAmount: String
    var orderNumber: String
}
```

然后在LiveActivity文件里修改不同模式下的UI就行了，详见Demo


![Xnip2025-03-19_15-22-33](https://github.com/user-attachments/assets/07f95124-2c5d-48ea-899b-b1c8ffd59be9)

![Xnip2025-03-19_15-22-44](https://github.com/user-attachments/assets/d06a4a7a-c720-4a01-8320-a2eb5cdec5f5)


![Xnip2025-03-19_15-23-03](https://github.com/user-attachments/assets/e7b35785-338c-45d6-91fb-b496c2c5acfd)



ps:在拓展模式时，如果有按钮点击可以通过URL让点击事件响应在SecneDelegate中
