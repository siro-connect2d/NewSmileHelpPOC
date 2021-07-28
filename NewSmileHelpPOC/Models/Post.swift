//
//  Post.swift
//  NewSmileHS
//
//  Created by thang on 23/07/2021.
//

import Foundation

struct Post: Codable {
    let status: Int
    let message: String?
    let error: String?
}
