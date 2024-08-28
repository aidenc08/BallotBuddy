//
//  PollUIController.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import Foundation

class PollUIController: ObservableObject {
    public var pollingPlaces: [PollingPlace]
    @Published var selectedPlace: PollingPlace?
    
    init(pollingPlaces: [PollingPlace]) {
        self.pollingPlaces = pollingPlaces
        self.selectedPlace = nil
    }
    
    func toggleSelected(place: PollingPlace) -> Void {
        if (selectedPlace == nil || selectedPlace != place) {
            selectedPlace = place
        }
        else {
            selectedPlace = nil
        }
    }
    
    func select(place: PollingPlace) -> Void {
        selectedPlace = place
    }
    
    func clear() -> Void {
        selectedPlace = nil
    }
    
    func getSelected() -> PollingPlace? {
        return selectedPlace
    }
    
    func isSelected(place: PollingPlace) -> Bool {
        if (selectedPlace == nil) {
            return false
        }
        else {
            return selectedPlace!.equals(other: place)
        }
    }
    
    func anySelected() -> Bool {
        return selectedPlace != nil
    }
}
