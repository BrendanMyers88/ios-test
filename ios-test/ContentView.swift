//
//  ContentView.swift
//  ios-test
//
//

import SwiftUI
import SwiftyGif

struct ContentView: View {
    let emojis = ["✌️", "🔴", "😆", "🤦‍♂️", "🦅", "🍯", "🕕", "💪", "👀", "⌚️", "🥹", "👻", "🤝", "🤔", "🛸", "👁️"]
    
    var body: some View {
        VStack {
            ForEach(0..<emojis.chunked(into: 4).count, id: \.self) { rowIndex in
                HStack {
                    ForEach(emojis.chunked(into: 4)[rowIndex], id: \.self) { emoji in
                        CardView(isFaceUp: Bool.random(), content: emoji)
                    }
                }
            }
            VStack {
                Text("Yo waddup!")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(10)
            }
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Gradient(colors: [.darkBlue, .darkPurple]))
    }
}

struct CardView: View {
    @State var isFaceUp = false
    let content: String

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)

            if isFaceUp {
                base.opacity(0.2)
                base.strokeBorder(lineWidth: 2)

                Text(content).font(.largeTitle)
            } else {
                base
                base.strokeBorder(lineWidth: 2)

                Text(" ").font(.largeTitle)
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

#Preview {
    ContentView()
}
