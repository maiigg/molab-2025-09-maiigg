


import SwiftUI
import YouTubePlayerKit
//https://github.com/SvenTiigi/YouTubePlayerKit
//used this custom package kit to play youtube videos


struct Secret: View {
    var body: some View {
        
        ZStack{
            
                VStack {
                    Text("Hello")
                    Text("The Secret is Here")
                    YouTubePlayerView("https://www.youtube.com/shorts/A4StMUgtAJc")
                        }

                    }

                    
                }
                
                
            
        }
    

#Preview {
    Secret()
}


