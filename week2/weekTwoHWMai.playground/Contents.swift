import UIKit
//
func imageFor(_ str: String) -> UIImage {
    let url = URL(string: str)
    let imgData = try? Data(contentsOf: url!)
    let uiImage = UIImage(data:imgData!)
    return uiImage!
}

//let url1 = "https://vetmed.tamu.edu/news/wp-content/uploads/sites/9/2023/10/AdobeStock_542062433.jpeg"
//let image1 = imageFor(url1)

//looked up on ChatGpt how to produce custom colours
let fenceColor = UIColor(red: 0.788, green: 0.573, blue: 0.322, alpha: 1.0)
let skyColor = UIColor(red: 0.2, green: 0.7, blue: 0.9, alpha: 1.0)
//customColor.setFill()
let woodColor = UIColor(red: 0.8,green: 0.224,blue: 0.027,alpha: 1.0)


let large = CGSize(width:1024, height: 1024)
let renderer = UIGraphicsImageRenderer(size: large)


let image = renderer.image { (context) in
    //image1.draw(in: CGRect(x:100, y:20, width: 1024,height: 1024))
    //background
    skyColor.setFill()
    context.fill(CGRect(x:0,y:0,width: 1024,height: 1024))
    
    //grass
    UIColor.green.setFill()
    context.fill(CGRect(x:0,y:900,width:1024,height:200))
    
    //house
    woodColor.setFill();
    context.fill(CGRect(x:300,y:700,width:300,height:200))
    
    //wood lines?
    context.cgContext.setStrokeColor(UIColor.black.cgColor)
    context.cgContext.setLineWidth(2)
    
    for i in 0...10{
        
        context.cgContext.move(to: CGPoint(x:300,y:700+(i*20)))
        context.cgContext.addLine(to: CGPoint(x: 600, y:700+(i*20)))
        context.cgContext.strokePath()
    }
    //roof? wanted to make triangle, but it seems like theres no set triangle shape
    UIColor.black.setFill()
    let rows = 5
    let roofSize = 50
    for i in 0..<rows {//per row
        let blocks = i+1 //increments one more block per row
        let totalWidth = blocks*roofSize
        let offSet = 425 - totalWidth/2
        for j in 0..<blocks {
            let x = offSet + j*roofSize
            let y = 450 + i*roofSize
            context.fill(CGRect(x:x,y:y,width:roofSize*2,height:roofSize))
        }
       
            
        
    }
    
    
    //fence
    fenceColor.setFill()
    context.fill(CGRect(x:0,y:860,width:1024,height:20))
    for i in 0...20{
       // context.fill(CGRect(x:i*50,y:10,width: 50, height: 50))
        //UIColor.green.setFill()
        context.cgContext.fillEllipse(in: CGRect(x: i*50, y: 800, width: 20, height: 150))
        
        
    }}
image
