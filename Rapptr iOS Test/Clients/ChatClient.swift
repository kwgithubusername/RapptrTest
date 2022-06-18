//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */

class ChatClient {
    
    private let chatURL = ClientURLs.dev + ClientURLs.Paths.chatLog
    
    func fetchChatData(completion: @escaping ([Message]) -> Void, error errorHandler: @escaping (String?) -> Void) {

        guard let url = URL(string: chatURL) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Data is nil")
                return
            }
            guard let messagesResponse = try? JSONDecoder().decode(MessagesResponse.self, from: data) else {
                print("Error decoding messages")
                return
            }
            completion(messagesResponse.data)
        }
        task.resume()
    }

    func fetchAvatarData(message: Message, completion: @escaping (Data) -> Void) {
        if let url = message.avatarURL {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                completion(data)
            }

            task.resume()
        }
    }
}
