//
//  OpenAIService.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/19/24.
//

import Foundation

class OpenAIService {
    
    static let shared = OpenAIService()
    
    private init () {
        
    }
    
    private func generateUrlRequest(mouveCaption: String) throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions")
        else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        
        //Method
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        
        //Header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(Secrets.openAiApiKey)", forHTTPHeaderField: "Authorization")
        
        //Body
        let systemMessage = GPTMessage(role: "system", content: "You  are transcribing text details about an event")
        let userMessage = GPTMessage(role: "user", content: mouveCaption)
        
        let functionTitleProperty = GPTFunctionProperty(type: "string", description: "The mouve title from the user caption")
        let functionTimeProperty = GPTFunctionProperty(type: "string", description: "The time the mouve occurs from the user caption")
        let functionPriceProperty = GPTFunctionProperty(type: "integer", description: "The dollar amount of the mouve")
        let parameterProperties: [String: GPTFunctionProperty] = [
            "title": functionTitleProperty,
            "time": functionTimeProperty,
            "price": functionPriceProperty
        ]
        let functionParameters = GPTFunctionParameters(type: "object", properties: parameterProperties, required: [ "title", "time", "price" ])
        let function = GPTFunction(name: "convert_prompt_to_mouve", description: "Convert the user mouve caption into a Mouve object", parameters: functionParameters)
        let payload = GPTChatPayload(model: "gpt-3.5-turbo-0613", messages: [systemMessage, userMessage], functions: [function])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        urlRequest.httpBody = jsonData
        
        return urlRequest
    }
    
    func sendPromptToChatGPT(prompt: String) async throws {
        let urlRequest = try generateUrlRequest(mouveCaption: prompt)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let result = try JSONDecoder().decode(GPTResponse.self, from: data)
        let args = result.choices[0].message.functionCall.arguments
        guard let argData = args.data(using: .utf8) else {
            throw URLError(.badServerResponse)
        }
        let gptMouve = try JSONDecoder().decode(GPTMouveResponse.self, from: argData)
        
        print(gptMouve)
    }
}
