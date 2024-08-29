//
//  RequestsUtil.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/28/24.
//

import Foundation

struct CandidateResponse: Codable {
    var success: Bool
    var data: [Race]
}

struct RequestsUtil {
    
    static func getRaces(zipcode: String) async throws -> [Race]{
        // Ensure the URL is valid
        let urlString = "http://64.227.107.82:8080/api/elections?zip=" + zipcode
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(CandidateResponse.self, from: data)
        print(response.success)
        if (response.success) {
            return response.data
        }
        throw URLError(.badServerResponse)
    }
}

