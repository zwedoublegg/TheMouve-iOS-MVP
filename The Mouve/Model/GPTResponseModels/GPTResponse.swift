//
//  GPTFunctions.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/19/24.
//

import Foundation


struct GPTResponse: Decodable {
    let choices: [GPTResponseCompletion]
}

struct GPTResponseCompletion: Decodable {
    let message: GPTResponseMessage
}

struct GPTResponseMessage: Decodable {
    let functionCall: GPTResponseFunctionCall
    
    enum CodingKeys: String, CodingKey {
        case functionCall = "function_call"
    }
}

struct GPTResponseFunctionCall: Decodable {
    let name: String
    let arguments: String
}

struct GPTMouveResponse: Decodable {
    let title: String
    let time: String
    let price: Int
}
