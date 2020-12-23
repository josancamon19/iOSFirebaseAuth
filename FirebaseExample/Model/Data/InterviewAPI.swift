//
//  InterviewAPI.swift
//  FirebaseExample
//
//  Created by Joan Cabezas on 21/12/20.
//

import Foundation
import Alamofire


class InterviewAPI {
        
    private let baseURL = "https://interviews-backend-api.herokuapp.com/api/v1/"
    private let headers =  HTTPHeaders([HTTPHeader(name: "Authorization", value: "Bearer cFodNK16Hv1g6ali0Y-dyQDmYHt7rjTk")])
    
    func getUsers(onCompleted: @escaping ([User]) -> Void){
        AF.request("\(baseURL)users", method: .get, headers: headers).responseDecodable(of: [User].self) { response in
            debugPrint(response)
            do {
                let users = try JSONDecoder().decode([User].self, from: response.data!)
                print("Users received \(users.count)")
                onCompleted(users)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func createOrUpdateUser(user: User,  onCompleted: @escaping () -> Void){
        AF.request("\(baseURL)users", method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: User.self) { response in
        
            do {
                let user : User? = try JSONDecoder().decode(User.self, from: response.data!)
                debugPrint(user)
                onCompleted()
            } catch {
                debugPrint(error)
            }
        }
    }
}
