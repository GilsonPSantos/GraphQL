import Foundation
import Apollo

struct LaunchListRequest: GraphQLRequestProtocol {
    typealias Query = LaunchListQuery
    typealias Value = LaunchListResponse
    var headers: [String : String] {
        ["KeyTeste": "valueTeste"]
    }
}
