//
//  User.swift
//  
//
//  Created by ryoppippi on 2023/08/26.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public typealias User = Components.Schemas.User

public enum APIError: Error {
    case runtimeError(message: String, code: Int)
}

public func getUser(id: String) async throws -> User {
    let client = Client(
        serverURL: try! Servers.server1(),
        transport: URLSessionTransport()
    )
    let res: Operations.get_users__id_.Output
    do{
        res = try await client.get_users__id_(
            Operations.get_users__id_.Input(
                path: .init(id: id)
            )
        )
    } catch {
        throw APIError.runtimeError(message: "api request error", code: 404)
    }
    
    switch res {
    case let .ok(okRes):
        switch okRes.body {
        case .json(let user):
            return user
        }
    case let .badRequest(error):
        switch error.body {
        case let .json(errorBody):
            throw APIError.runtimeError(message: errorBody.message, code: Int(errorBody.code))
        }
    case let .undocumented(statusCode: statusCode, _):
        throw APIError.runtimeError(message: "undocumented", code: statusCode)
    }
}
