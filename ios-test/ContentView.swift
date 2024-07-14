//
//  ContentView.swift
//  ios-test
//
//  Created by Brendan Myers on 7/13/24.
//

import SwiftUI
import SwiftyGif

class ScaledHeightImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
 
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}

struct AnimatedGifView: UIViewRepresentable {
    @Binding var url: URL

    func makeUIView(context: Context) -> UIImageView {
        let imageView = ScaledHeightImageView(gifURL: self.url)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.setGifFromURL(self.url)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    CardView()
                    CardView()
                    CardView()
                    CardView()
                }
                HStack {
                    CardView(isFaceUp: true)
                    CardView()
                    CardView()
                    CardView()
                }
            }
            VStack {
                HStack {
                    CardView()
                    CardView()
                    CardView(isFaceUp: true)
                    CardView()
                }
                HStack {
                    CardView()
                    CardView()
                    CardView()
                    CardView()
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
    var isFaceUp: Bool = false

    @State private var gifURL: URL = {
            guard let url = Bundle.main.url(forResource: "dat_boi", withExtension: "gif") else {
                fatalError("GIF file not found")
            }
            return url
        }()

    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .opacity(0)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                
                AnimatedGifView(url: $gifURL)
            } else {
                RoundedRectangle(cornerRadius: 12)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
            }
        }
    }
}



#Preview {
    ContentView()
}
