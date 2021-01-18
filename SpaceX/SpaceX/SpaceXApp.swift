import SwiftUI

@main
struct SpaceXApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SpaceXData())
        }
    }
}
