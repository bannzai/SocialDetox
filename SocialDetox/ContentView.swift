import SwiftUI

struct ContentView: View {
  var body: some View {
    List {
      Section {
        Text("1")
        Text("2")
        Text("3")
      } header: {
        Text("SNS")
      }

      Section {
        Text("1")
        Text("2")
        Text("3")
      } header: {
        Text("Video")
      }

      Section {
        Text("1")
        Text("2")
        Text("3")
      } header: {
        Text("Message")
      }
    }
    .listStyle(.insetGrouped)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
