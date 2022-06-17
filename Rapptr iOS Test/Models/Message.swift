//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct MessagesResponse: Decodable {
    var data: [Message]
}

struct Message: Decodable {
    var userID: Int?
    var username: String
    var avatarURL: URL?
    var text: String

    private enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case username = "name"
        case avatarURL = "avatar_url"
        case text = "message"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let userIDString = try container.decode(String.self, forKey: CodingKeys.userID)
        userID = Int(userIDString)

        username = try container.decode(String.self, forKey: CodingKeys.username)

        let avatarURLString = try container.decode(String.self, forKey: CodingKeys.avatarURL)
        avatarURL = URL(string: avatarURLString)

        text = try container.decode(String.self, forKey: CodingKeys.text)
    }

    init(testName: String, withTestMessage message: String) {
        self.userID = 0
        self.username = testName
        self.avatarURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png")
        self.text = message
    }
}
