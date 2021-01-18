import Foundation
import SwiftUI
import Combine
 

struct ContentView: View {
    @EnvironmentObject var spaceXData: SpaceXData

    var body: some View {
        NavigationView{
            List(spaceXData.SpaceXData_merged) {launch in
                NavigationLink(destination: RocketDetail(rocket: launch.attachedRocket)){
                    HStack{
                        RemoteImage(url: launch.links?.mission_patch ?? "")
                            .frame(width: 20.0,height: 20.0)
                        Text(launch.mission_name).font(.title3)
                        Text(launch.launch_year).font(.title3)
                        
                    }
                }
            }.navigationTitle("SpaceX-Launches").accentColor(.blue)
        }
    }
       
    
}

