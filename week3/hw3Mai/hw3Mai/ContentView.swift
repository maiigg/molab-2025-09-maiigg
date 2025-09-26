//
//  ContentView.swift
//  hw3Mai
//
//  Created by MAI Gourlay on 2025/09/25.
//

import SwiftUI
import Combine


let emojis = ["🌿", "🐶", "🍡", "🐦", "🌈", "🌱", "🍵", "❤️", "☀️", "🌸"]


struct EmojiData: Identifiable {
    let id = UUID() //unique identifier per new (whatever structs ver of object in classes is)
    let emoji: String
    var x: CGFloat
    var y: CGFloat
    var speed: CGFloat
}


struct EmojiRainView: View {
    //need @state to modify values inside a struct
    @State private var items: [EmojiData] = []

    //FOUND A ARTICLE ON TIMER FROM SAME MAN WHO MADE 100 DAYS OF SWIFT:
    //reminds me of p5's version of animations almost
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-a-timer-with-swiftui
    private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    // ^ SPEED

    var body: some View {
        Canvas { context, size in
            for item in items {
                let text = Text(item.emoji)
                context.draw(text, at: CGPoint(x: item.x, y: item.y)) //will refer to emoji creation below
            }
        }
        .onReceive(timer) { _ in  //also from hackingWithSwift article above
            //adds new random emojis from emojis array
            if Bool.random() {
                let newEmoji = EmojiData(
                    emoji: emojis.randomElement()!,
                    x: CGFloat.random(in: 0..<400),
                    y: -50,
                    speed: CGFloat.random(in: 2...6)
                )
                items.append(newEmoji)
            }

            //make y value bigger to move down
            //https://developer.apple.com/documentation/swift/array/indices
            for i in items.indices {
                items[i].y += items[i].speed
            }
            items.removeAll { $0.y > 1020} //once it gets to the end of the bottom of the screen
        }
    }
}

#Preview {
    EmojiRainView()
}
