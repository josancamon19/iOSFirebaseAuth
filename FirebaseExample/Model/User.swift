// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - User
struct User: Codable{
    let id: Int?
    let createdAt, updatedAt: String?
    let firebaseUid, name: String
    let email: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case createdAt = "CreatedAt"
        case updatedAt = "UpdatedAt"
        case firebaseUid = "firebase_uid"
        case name, email
    }
}
