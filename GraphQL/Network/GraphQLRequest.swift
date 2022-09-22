import Foundation
import Apollo

protocol CustomQuery: GraphQLQuery {
    init()
}

protocol GraphQLRequestProtocol {
    associatedtype Query: CustomQuery
    associatedtype Value = GraphQLSelectionSet
    var baseURL: URL? { get }
    var timeoutInterval: TimeInterval? { get }
    var headers: [String: String] { get }
    func serialize(data: GraphQLSelectionSet) throws -> Value
}

extension GraphQLRequestProtocol {
    var baseURL: URL? {
        return nil
    }

    var timeoutInterval: TimeInterval? {
        return 30.0
    }

    var headers: [String: String] {
        return [:]
    }
}

extension GraphQLRequestProtocol where Value == GraphQLSelectionSet {
    func serialize(data: GraphQLSelectionSet) throws -> Value {
        return data
    }
}

extension GraphQLRequestProtocol where Value == Data {
    func serialize(data: GraphQLSelectionSet) throws -> Value {
        return try JSONSerialization.data(withJSONObject: data.jsonObject, options: [])
    }
}

extension GraphQLRequestProtocol where Value: Decodable {
    func serialize(data: GraphQLSelectionSet) throws -> Value
    {
        let data = try JSONSerialization.data(withJSONObject: data.jsonObject, options: [])
        return try JSONDecoder().decode(Value.self, from: data)
    }
}

extension GraphQLRequestProtocol where Value == Void {
    func serialize(data: Data) throws -> Value {
        return
    }
}
