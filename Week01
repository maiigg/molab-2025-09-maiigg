import Foundation

var greeting = "Hello, playground"


let treeRows: Int = 5

let seasonLeaves: [String] = ["🌸","🌿","❄️", "🍁"]
let animals: [String] = ["🐻","🐶","🦧","🐇","🐍","🐢","🐦"]
let skyAnimals: [String] = ["🦅","🦆","🦉","🦃","🦅"]

func buildTrees(emoji: String, size: Int) {
    let birdRow = Int.random(in:1...treeRows) //1/4 chance of spawning a bird
    
    for row in 1...treeRows {
        
        let spaces = String(repeating: "  ",count: treeRows-row)
        let plainLeaves = String(repeating: emoji,count:row*2 - 1)
        //not changeable
        var leaves = plainLeaves
        //var leaves = plainLeaves
        
        // learned repeating by looking up, wanted to have each string not separated by line, but swift automatically does it....

        if (row == birdRow){
            let skyBirdIndex = Int.random(in:0...skyAnimals.count-1)
            let randomBird = skyAnimals[skyBirdIndex]
            //using prefix and suffix to surround animal by leaves so it is "in the tree"
            
            let birdPos = Int.random(in:1...leaves.count)
            let left = String(leaves.prefix(birdPos-1)) //makes sure it is not on the top due to uneven spacing
            let right = String(leaves.suffix(leaves.count - birdPos))

            leaves = left + randomBird + right
            print(spaces + leaves)
            
        }
        
        for _ in 2...size {
            print(spaces + plainLeaves)
        }
    }
    let stem = String("🪵")
    //print(repeating: " ", count: 8)
    for i in 1...2 {
        if (i == 1) {
            print ("        " + stem)
        }
        else{
            let randomNum = Int.random(in: 0...animals.count-1)
            print("        " + stem + "   " + animals[randomNum])
            
        }
    
    }
}
//make a tree for each season
for i in 1...4 {
    buildTrees(emoji:seasonLeaves[i-1], size:3)
    print(String(repeating:"🪨",count: 12))
    print(" ")
}
