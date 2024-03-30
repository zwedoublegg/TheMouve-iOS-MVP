//
//  GPTFunctions.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/19/24.
//

import Foundation

struct GPTFunctionParameters: Encodable{
    let type: String
    let properties: [String: GPTFunctionProperty]
    let required: [String]?

}
