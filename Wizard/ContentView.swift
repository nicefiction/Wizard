// MARK: ContentView.swift
/**
 `SOURCE` :
 https://www.hackingwithswift.com/books/ios-swiftui/ensuring-core-data-objects-are-unique-using-constraints
 By default
 Core Data will add any object you want ,
 but this can get messy very quickly ,
 particularly if you know two or more objects don’t make sense at the same time .
 For example ,
 if you stored details of contacts using their email address ,
 it wouldn’t make sense to have two or three different contacts
 attached to the same email address .
 To help resolve this ,
 Core Data gives us constraints :
 we can make one attribute constrained so that it must always be unique .
 
 `TIP` :
 https://www.hackingwithswift.com/forums/100-days-of-swiftui/day-57-no-scenedelegate-swift-file/6089
 */

import SwiftUI



struct ContentView: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Wizard.entity() ,
                  sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        VStack {
            // List(wizards, id: \.self) { wizard in // PAUL HUDSON
            List {
                ForEach(wizards , id : \.self) { (wizard: Wizard) in
                    Text(wizard.name ?? "N/A")
                }
            }
            Group {
                Button("Create Wizard") {
                    let wizard = Wizard(context : self.managedObjectContext)
                    
                    wizard.name = "Dorothy Gale"
                }
                Button("Save Wizard") {
                    do {
                        try self.managedObjectContext.save()
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    /**
                     Core Data will refuse to save duplicate data .
                     If you do want Core Data to write the changes ,
                     you need to open `SceneDelegate.swift`
                     and add some code .
                     */
                }
                .padding()
            }
            .font(.title)
        }
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
