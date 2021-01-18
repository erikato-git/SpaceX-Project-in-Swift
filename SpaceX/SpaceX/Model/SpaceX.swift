import Foundation
import SwiftUI


struct Launch: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case mission_name,launch_year,rocket,links
    }
    let id = UUID()
    let mission_name: String
    let launch_year: String
    let rocket: LaunchRocket
    let links: Links?
    var attachedRocket: Rocket?
}

struct LaunchRocket: Codable{
    enum CodingKeys: String, CodingKey{
        case rocket_id
    }
    let rocket_id: String
}

struct Links: Codable {
    enum CodingKeys: String, CodingKey {
        case mission_patch
    }
    let mission_patch: String?
}


struct Rocket: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id,name,flickr_images
    }
    let id: String
    let name: String
    let flickr_images: [String]
}



class SpaceXData: ObservableObject {
    var launches = [Launch]()
    var rockets = [Rocket]()
    @Published var SpaceXData_merged = [Launch]()
    let group = DispatchGroup()
    
    init(){
        fetchLaunches()
        fetchRockets()
        
        group.notify(queue: .main){
            for l in self.launches{
                for r in self.rockets{
                    if l.rocket.rocket_id == r.id{
                        let newLaunch = Launch(mission_name: l.mission_name, launch_year: l.launch_year, rocket: l.rocket, links: l.links, attachedRocket: r)
                        self.SpaceXData_merged.append(newLaunch)
                    }
                }
            }
        }
    }


    
    func fetchLaunches(){
        
        group.enter()
        
        let url = URL(string: "https://api.spacexdata.com/v2/launches")!
                
                URLSession.shared.dataTask(with: url) {(data,response,error) in
                    do {
                        if let d = data {
                            let decodedLists = try JSONDecoder().decode([Launch].self, from: d)
 
                            DispatchQueue.main.async {
                                self.launches = decodedLists
                                
                                /*
                                for m in self.launches{
                                    print(m)
                                }
                                */
                                
                                self.group.leave()
                            }

                        }else {
                            print("No data")
                        }
                        
                    } catch {
                        print ("Error")
                    }
                    
                }.resume()
        
    }
    
    
    func fetchRockets(){
        
        group.enter()
        
        let url = URL(string: "https://api.spacexdata.com/v2/rockets")!

                URLSession.shared.dataTask(with: url) {(data,response,error) in
                    do {
                        if let d = data {
                            let decodedLists = try JSONDecoder().decode([Rocket].self, from: d)
                            self.rockets = decodedLists

                            DispatchQueue.main.async {
                                self.rockets = decodedLists
                            
                                /*
                                for m in self.rockets{
                                    print(m)
                                }
                                */
                                self.group.leave()
                                
                            }
 
                        }else {
                            print("Decoding Error")
                        }

                    } catch {
                        print ("Error")
                    }

                }.resume()
        
    }

    
}
