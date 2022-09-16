import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var model: SwiftyLemonadeClipModel
  
  var body: some View {
    if let selectedStand = model.selectedStand {
      NavigationView {
        MenuList(stand: selectedStand)
      }
    }
    if model.locationFound == false {
      Text("Error finding stand.")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
