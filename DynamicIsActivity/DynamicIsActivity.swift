//
//  DynamicIsActivity.swift
//  DynamicIsActivity
//
//  Created by 贺亚飞 on 2025/3/19.
//

import WidgetKit
import SwiftUI



struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry( date: Date(), imageName: "ic_widget_type_qrcode", text: "示例文本")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry( date: Date(),imageName: "ic_widget_type_qrcode", text: "示例文本")
        completion(entry)
    }

//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//        let currentDate = Date()
//
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry( date: Date(),imageName: "ic_widget_type_qrcode", text: "更新文本")
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        
        let sharedDefaults = UserDefaults(suiteName: "group.DynamicIslandDemo")
        let text = sharedDefaults?.string(forKey: "widgetText") ?? "默认文本"
        let imageName = sharedDefaults?.string(forKey: "widgetImage") ?? "ic_widget_type_qrcode"

        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, imageName: imageName, text: text)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

struct DynamicIsActivityEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily  // 获取 Widget 尺寸

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            VStack {  // **小尺寸（上图下文字）**
                Image(entry.imageName)
                    .resizable()
                    .scaledToFit()
                Text(entry.text)
            }
        case .systemMedium:
            VStack {  // **中尺寸（上文字下图）**
                Text(entry.text)
                Image(entry.imageName)
                    .resizable()
                    .scaledToFit()
            }
        case .systemLarge:
            HStack { // **大尺寸（左图右文字）**
                Image(entry.imageName)
                    .resizable()
                    .scaledToFit()
                Text(entry.text)
            }
        case .accessoryInline :
            Text(entry.text)
        case .accessoryCircular :
            Text(entry.text)
        case .accessoryRectangular :
            Text(entry.text)
        
        default:
            Text("Unsupported size")
        }
    }
}


struct DynamicIsActivity: Widget {
    let kind: String = "DynamicIsActivity"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                DynamicIsActivityEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DynamicIsActivityEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge,.accessoryInline, .accessoryRectangular, .accessoryCircular]) // 适配所有尺寸

    }
}



