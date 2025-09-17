import UIKit
//
func imageFor(_ str: String) -> UIImage {
    let url = URL(string: str)
    let imgData = try? Data(contentsOf: url!)
    let uiImage = UIImage(data:imgData!)
    return uiImage!
}

let url1 = "https://vetmed.tamu.edu/news/wp-content/uploads/sites/9/2023/10/AdobeStock_542062433.jpeg"
let image1 = imageFor(url1)


let large = CGSize(width:1024, height: 1024)
let renderer = UIGraphicsImageRenderer(size: large)


let image = renderer.image { (context) in
    image1.draw(in: CGRect(x:100, y:20, width: 1024,height: 1024))
}
image
