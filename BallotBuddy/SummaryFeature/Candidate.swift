//
//  Candidate.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/28/24.
//

import Foundation

class CampaignURLResponse: Codable {
    var type: Int
    var url: String
}

class Candidate: Codable, ObservableObject {
    var party: String
    var name: String
    var campaign_url: String?
    var thumbnail: String?
    
    @Published var policies: [Policy]?
    
    init(party: String, name: String, campaign_url: String?, thumbnail: String? = nil, policies: [Policy]? = nil) {
        self.party = party
        self.name = name
        self.campaign_url = campaign_url
        self.thumbnail = thumbnail
        self.policies = policies
    }
    
    // Custom CodingKeys to map the properties
    enum CodingKeys: String, CodingKey {
        case party, name, campaign_url, thumbnail, policies
    }
    
    // Decoding with custom logic
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.party = try container.decode(String.self, forKey: .party)
        self.name = try container.decode(String.self, forKey: .name)
        do {
            let temp = try container.decodeIfPresent(CampaignURLResponse.self, forKey: .campaign_url)
            self.campaign_url = temp?.url
        }
        catch {
            self.campaign_url = try container.decodeIfPresent(String.self, forKey: .campaign_url)
        }
        
        self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        
        // Manually decode the policies property
        //let decodedPolicies = try container.decodeIfPresent([Policy].self, forKey: .policies)
        //self.policies = decodedPolicies
    }
    
    // Encoding with custom logic
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(party, forKey: .party)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(campaign_url, forKey: .campaign_url)
        try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
        
        // Manually encode the policies property
        //try container.encodeIfPresent(policies, forKey: .policies)
    }
    
    // Fetch policies asynchronously
    func getPolicies() async -> Void {
        if (self.campaign_url == nil) {
            return
        }
        else {
            let fetchedPolicies = await DataModel.getPolicies(url: self.campaign_url!)
            // Ensure update happens on the main thread
            DispatchQueue.main.async {
                self.policies = fetchedPolicies
            }
        }
        
    }
}
