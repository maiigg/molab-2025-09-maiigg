//
//  party.swift
//  hw4Mai
//
import SwiftUI
import AVFoundation
import Combine
// took the load Audio code from Audio-State-Demo/PlayAudioView
let emojis = ["🌿", "🐶", "🍡", "🐦", "🌈", "🐈", "🍵", "❤️", "☀️", "🌸"]
//new sound dictionary to ATTRIBUTE X TO Y
let emojiSounds: [String: String] = [
    "🌿": "whee.wav",
    "🐶": "dog.wav",
    "🍡": "boop.wav",
    "🐦": "bird.wav",
    "🌈": "moo.wav",
    "🐈": "cat.wav",
    "🍵": "beast.wav",
    "❤️": "neigh.wav",
    "☀️": "chicken.wav",
    "🌸": "monkey.wav"
]

struct EmojiData: Identifiable {
    let id = UUID() //unique identifier per new (whatever structs ver of object in classes is)
    let emoji: String
    var x: CGFloat
    var y: CGFloat
    var speed: CGFloat
}

func loadBundleAudio(_ fileName:String) -> AVAudioPlayer? {
    let path = Bundle.main.path(forResource: fileName, ofType:nil)!
    let url = URL(fileURLWithPath: path)
    do {
        return try AVAudioPlayer(contentsOf: url)
    } catch {
        print("loadBundleAudio error", error)
    }
    return nil
}


struct Party: View {
    @State private var items: [EmojiData] = []
    @State private var player: AVAudioPlayer?
    //play distinct sound accorrding to given emoji
    func playSound(for emoji: String) {
        if let soundFile = emojiSounds[emoji] {
            if let player = loadBundleAudio(soundFile) { //if let just in case something doesnt exist
                self.player = player
                player.play()
            } else {
                print("Could not load sound:", soundFile)
            }
        }
    }
    
    private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    // ^ SPEED
    
    //https://developer.apple.com/documentation/swiftui/geometryreader
    // source for understanding GeometryReader:
    var body: some View {
        
        GeometryReader{ geo in
            ZStack{
                ForEach(items) { item in
                    Text(item.emoji)
                        .font(.system(size: 40))
                        .position(x: item.x, y: item.y)
                        .onTapGesture { //onTapGesture - touch recognition
                            playSound(for: item.emoji) //calls function for playing sound
                        }
                    
                }
                
            }
            .onReceive(timer) { _ in  //FROM HOMEWORK 3, also from hackingWithSwift article above
                //adds new random emojis from emojis array
                if Bool.random() {
                    let newEmoji = EmojiData(
                        emoji: emojis.randomElement()!,
                        x: CGFloat.random(in: 0..<400),
                        y: -50,
                        speed: CGFloat.random(in: 2...3)
                    )
                    items.append(newEmoji)
                }
                //https://developer.apple.com/documentation/swift/array/indices
                for i in items.indices {
                    items[i].y += items[i].speed
                }
                items.removeAll { $0.y > 1020}
                
            }
            }
        }
            
        }
        #Preview{
            Party()
        }



