//
//  RequestsUtil.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/28/24.
//

import Foundation

struct CandidateResponse: Codable {
    var success: Bool
    var data: [Race]?
}

struct PolicyResponse: Codable {
    var summary: [Policy]
    var url: String
}


struct RequestsUtil {
    
    static func getRaces(zipcode: String) async throws -> [Race]{
        // Ensure the URL is valid
        let urlString = "http://154.53.63.206:8080/api/elections?zip=" + zipcode
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        print(String(data: data, encoding: .utf8)!)
        let response = try JSONDecoder().decode(CandidateResponse.self, from: data)
        print(response.success)
        if (response.success) {
            return response.data!
        }
        throw URLError(.badServerResponse)
    }
    
    static func getPolicies(url: String) async throws -> [PolicyResponse] {
        let urlString = "http://154.53.63.206:8080/api/summaries?url=" + url
        let backupUrlString = "http://154.53.63.206:8080/api/summaries?url=" + url + "&refresh=1"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(String(data: data, encoding: .utf8)!)
            let response = try JSONDecoder().decode([PolicyResponse].self, from: data)
            return response
        }
        catch {
            print("backup call")
            guard let backupUrl = URL(string: backupUrlString) else {
                throw URLError(.badURL)
            }
            let (data, _) = try await URLSession.shared.data(from: backupUrl)
            print(String(data: data, encoding: .utf8)!)
            let response = try JSONDecoder().decode([PolicyResponse].self, from: data)
            return response
        }
    }

}

