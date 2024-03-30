//
//  GPTFunctions.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/19/24.
//

import Foundation


struct GPTChatPayload: Encodable{
    let model: String //gpt-3.5-turbo-0613
    let messages: [GPTMessage]
    let functions: [GPTFunction]
}
