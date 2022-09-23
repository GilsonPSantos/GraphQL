import Foundation

struct HomeRequest: GraphQLRequestProtocol {
    typealias Query = LaunchListQuery
    typealias Value = HomeResponse
    var headers: [String : String] {
        ["KeyTeste": "valueTeste"]
    }
}
