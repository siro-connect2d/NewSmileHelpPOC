//
//  UserLoginCredentialModel.swift
//  NewSmileHS
//
//  Created by long on 23/07/2021.
//

import Foundation
import UIKit

enum LoginMethod : String{
    case facebook = "facebook"
    case google = "google"
    case apple = "apple"
    case email = "email"
}

class UserLoginCredentialModel : Codable {
    var loginMethod : String?
    var email : String?
    var password : String?
    var accessToken : String?
}
