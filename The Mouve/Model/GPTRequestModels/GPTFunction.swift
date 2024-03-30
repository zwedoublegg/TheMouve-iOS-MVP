//
//  GPTFunctions.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/19/24.
//

import Foundation

struct GPTFunction: Encodable {
    let name: String
    let description: String
    let parameters: GPTFunctionParameters
}
