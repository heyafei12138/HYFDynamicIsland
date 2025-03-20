//
//  ViewController.swift
//  HYFDynamicIsland
//
//  Created by 贺亚飞 on 2025/3/19.
//

import UIKit
import ActivityKit
import WidgetKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createButton(title: "更新数据", y: view.center.y - 100, selector: #selector(startDeliveryPizza))
//        createButton(title: "更新灵动岛", y: view.center.y - 50, selector: #selector(updateDeliveryPizza))
//        createButton(title: "关闭灵动岛", y: view.center.y, selector: #selector(endAppearanceTransition))
    }
    
    private func createButton(title: String, y: CGFloat, selector: Selector) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        view.addSubview(button)
        button.center.x = view.center.x
        button.frame.origin.y = y
        button.addTarget(self, action: selector, for: .touchUpInside)
    }
    @objc private func startDeliveryPizza() {
      
        
        let sharedDefaults = UserDefaults(suiteName: "group.DynamicIslandDemo")
           sharedDefaults?.setValue("Hello, Widget!", forKey: "widgetText")
           sharedDefaults?.setValue("customImage", forKey: "widgetImage")
           sharedDefaults?.synchronize()

           // 让小组件重新加载
           WidgetCenter.shared.reloadAllTimelines()
        return
        
        //初始化静态数据
        let pizzaDeliveryAttributes = DynamicIsActivityAttributes(numberOfPizzas: 5, totalAmount:"￥99", orderNumber: "23456")
        //初始化动态数据
        let initialContentState = DynamicIsActivityAttributes.dynamicIsActivityStatus(driverName: "小旋风 🚴🏻",driverStatus: 1 , deliveryTimer: Date()...Date().addingTimeInterval(15 * 60))
        if let activity = try? Activity<DynamicIsActivityAttributes>.request(
            attributes: pizzaDeliveryAttributes,
            contentState: initialContentState,
            pushType: nil
        ) {
            print("Live Activity 启动成功: \(activity.id)")
        }
    }

}

