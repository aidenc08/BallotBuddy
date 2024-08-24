//
//  MapMarkerView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import SwiftUI

struct MapMarkerView: View {
    @State public var name: String
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            Text(name)
                .font(.caption)
                .padding(5)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 3)
        }
    }
}

#Preview {
    MapMarkerView(name: "hehe")
}
