//
//  RocketDetail.swift
//  SpaceX
//
//  Created by user183793 on 1/15/21.
//

import SwiftUI

struct RocketDetail: View {
    var rocket: Rocket?
    var body: some View {
        RemoteImage(url: rocket?.flickr_images[0] ?? "")
            .frame(width: 300, height: 300)
        Text(rocket?.name ?? "No data")

    }
}

struct RocketDetail_Previews: PreviewProvider {
    static var previews: some View {
        RocketDetail()
    }
}
