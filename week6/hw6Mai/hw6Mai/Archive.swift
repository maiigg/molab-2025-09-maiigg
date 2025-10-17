//
//  Archive.swift
//  hw6Mai
//
import SwiftUI

//var isAdmin: Bool = false

public struct Archive: View {
    @State private var isAdmin = false
    @EnvironmentObject var document: Document
    public var body: some View {
        NavigationView {
            List {
                // Display in reverse order to see new additions first
                Text("Objects")
                    .navigationTitle("The Archive")
                Button("Click for Admin Page"){
                    print(loggedInUser)
                    if loggedInUser == "mai:123" {
                        isAdmin = true
                    }
                    else {
                        print("Not Admin")
                    }
                        
                //format = "\(username):\(password)"
                }
            
                ForEach(document.object.objects.reversed()) { item in
                    NavigationLink( destination:
                        UpdateImageView(item: item)
                    )
                    {
                        ItemRow(item: item)
                    }
                }
            }
            
            
        }
        .navigationDestination(isPresented: $isAdmin) {}
        
    
    }
}

#Preview {
  Archive()
    //.environment(Document())
}
