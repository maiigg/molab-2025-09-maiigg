import SwiftUI

var adminUser: String = "mai"
var adminPass: String = "123"


var loggedInUser: String = ""

struct ContentView: View {
    //list of "username:password"
    @AppStorage("accounts") private var accountsString: String = ""    //needs conversion to array :/
    
    @State var username: String = ""
    @State var password: String = ""
    
    
    
    @State private var isLoggedIn: Bool = false
    
   
    
    //for this segment of code, I DID use chatgpt to parse the String into an array(just for this part though! once i had this, I could do everything on my own), since AppStorage doesnt handle arrays or dictionaries, the prompt i input into chargpt was "with my own code in mind [code inserted above], i want to be able to use appstorage to store accounts as ONE String, and then convert this to an array so I can have multiple accounts stored, perhaps with a format like format = "\(username):\(password)"
    private var accounts: [String] {
        get {
            accountsString.isEmpty ? [] : accountsString.split(separator: ";").map { String($0) }
        }
        set {
            accountsString = newValue.joined(separator: ";")
        }
    }
    func makeAcc(username: String, password: String){
        var updated = accounts   //temp version, adds, then sends back to accountstring
        let format = "\(username):\(password)"
        if !updated.contains(format) {
            updated.append(format)
        }
        else if updated.contains(format){
            print("Error: username already exists")
        }
        //rejoins string together w/ new updated values
        accountsString = updated.joined(separator: ";")
    }
    
    //https://developer.apple.com/documentation/swiftui/textfield
    //learnt textfield for input
    var body: some View {
        NavigationStack {
            VStack(spacing:10) {
                Text("Welcome to My Archive")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Text("Please Login or Sign Up")
                    .padding(10)
                Text("Write Guest in Username to Be a Guest")
                    .padding(30)
                
                Text("Username")
                TextField("Enter Here", text: $username)
                //https://developer.apple.com/documentation/swiftui/view/textinputautocapitalization(_:) input always autocapslocked, looked up how to stop
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                Text("Password")
                TextField("Enter Here",text: $password)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                Button("Log In"){
                    let format = "\(username):\(password)"
                    if accounts.contains(format){
                        isLoggedIn = true //boolean determines if the navigation works
                        print("Success")
                        print(format)
                        loggedInUser = format
                    }
                    else if username == "guest"{
                        isLoggedIn = true
                        print("Success")
                        loggedInUser = "guest"
                    }
                    else {
                        print("Fail")
                    } //resets so textfields also do
                    username = ""
                    password = ""
                    
                }
                
//                NavigationLink (destination: Secret()){
//                    Text("Log In")
//                    let format = "\(username):\(password)"
//                    if accounts.contains(format){
//                        print("Success")
//                    }
//                    else {
//                        print("Fail")
//                    } //resets so textfields also do
//                    username = ""
//                    password = ""
//                }
                Button("Make Account"){
                    makeAcc(username: username, password: password)
                    username = ""
                    password = ""
                    
                    
                }
                
            }
        
        .padding()
        .navigationDestination(isPresented: $isLoggedIn) {
            Archive()
        }
        }
    }
}

#Preview {
    ContentView()
}
