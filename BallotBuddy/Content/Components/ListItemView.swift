//
//  ListItemView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import SwiftUI
import CoreLocation

struct ListItemView: View {
    public var place: PollingPlace
    @EnvironmentObject var controller: PollUIController
    @EnvironmentObject var user: User
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack {
            HStack {
                Button(action: select, label: {
                    TranslatedText(place.name)
                        .font(.headline)
                    /*.background(
                     RoundedRectangle(cornerRadius: 10)
                     .fill(Color.blue)
                     .shadow(radius: 5)
                     )*/
                        .foregroundColor(Color(user.settings.getGlobalTextColor()))
                        .environmentObject(user)
                    
                })
                Spacer()
            }.padding(20)
            .background(Color(user.settings.getGlobalBackgroundAccent()))
            if (controller.isSelected(place: place)) {
                HStack {
                    Text(place.address).foregroundStyle(Color(user.settings.getGlobalTextColor()))
                    Spacer()
                    Button(action: openMaps) {
                        Image(systemName: "map.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color(user.settings.getGlobalAccent()))
                            }
                }.padding(10)
                .background(Color(user.settings.getGlobalBackgroundAccent()))
        }

            /*TranslatedText("Selected")
                .font(.headline)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                    .shadow(radius: 5)
                            )
                            .foregroundColor(.white)
                            .padding()
             */
        }
    }
    
    func select() -> Void {
        controller.toggleSelected(place: self.place)
    }
    
    func openMaps() {
        let destination = place.address
        let url = URL(string: "http://maps.apple.com/?daddr=\(destination.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!
        openURL(url)
    }
    
    
}

#Preview {
    let place = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), name: "Place", address: "")
    ListItemView(place: place).environmentObject(PollUIController(pollingPlaces: [place])).environmentObject(User())
}
