//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
*/

class LoginClient {
    
    private let loginURL = ClientURLs.dev + ClientURLs.Paths.login
    
    private let emailParameter = "email"
    private let passwordParameter = "password"

    func login(email: String, password: String, completion: @escaping (String) -> Void, error errorHandler: @escaping (String?) -> Void) {

        let startTime = Date()

        let queryItems = [
            URLQueryItem(name: emailParameter, value: email),
            URLQueryItem(name: passwordParameter, value: password)
        ]

        guard let url = URL(string: loginURL)?.appending(queryItems) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let responseTime = Date().timeIntervalSince(startTime);
            print("The request took \(responseTime * 1000) milliseconds")

            if let error = error {
                errorHandler(error.localizedDescription)
            } else if let data = data, let errorMessage = try? JSONDecoder().decode(LoginError.self, from: data) {
                errorHandler(errorMessage.message)
            } else {
                completion("test")
            }
        }
        task.resume()
    }
    
    private struct LoginError: Decodable {
        let code: String
        let message: String
    }
}
