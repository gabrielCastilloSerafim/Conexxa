//
//  NetworkService.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 22/10/23.
//

import Foundation
import OSLog

class NetworkService: NetworkServiceProtocol {
    
    // ProcessInfo.processInfo.environment["API_BASE_URL"]
    
    let logger = Logger(subsystem: "NetworkService", category: "NetworkRequest")
    
    let baseUrl = "https://api-auth-node-jwt.vercel.app/api/"
    
    func performRequest<D: Decodable, E: Encodable>(
        useAuth: Bool,
        endPoint: String,
        typeToBeDecoded: D.Type,
        httpMethod: HttpMethods,
        requestBody: E?) async throws -> D
    {
        
        guard let finalUrl = URL(string: baseUrl.appending(endPoint)) else {
            
            logger.error("Coud not generate URL from String.")
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: finalUrl, timeoutInterval: 30)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if useAuth {
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: Constants.JWT) ?? "")", forHTTPHeaderField: "Authorization")
        }
        
        do {
            
            if let requestBody {
                request.httpBody = try JSONEncoder().encode(requestBody)
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if !(200..<300).contains(httpResponse.statusCode) {
                    
                    let decodedResponseWithError = try JSONDecoder().decode(GNetworkError.self, from: data)
                    
                    logger.error("Response failed with statusCode: \(httpResponse.statusCode)")
                    throw decodedResponseWithError
                }
                
                logger.info("Did receive response with status code: \(httpResponse.statusCode)")
            }
            
            logger.info("Did receive JSON response data:\n\n\(data.prettyPrintedJSONString)")
            
            let decodedResponse = try JSONDecoder().decode(D.self, from: data)
            return decodedResponse
            
        } catch {
            
            logger.error("Data task failed with error \(error.localizedDescription)")
            throw error
        }
    }
    
}
