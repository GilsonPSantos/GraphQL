import Foundation
import Apollo

struct UserRequest: GraphQLRequestProtocol {
    typealias Query = UserQuery
}
