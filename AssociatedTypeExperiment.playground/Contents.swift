//: Playground - noun: a place where people can play

import UIKit

/*
 Here's the setup. I want a bunch of UseCases that can handle their requests
 but the reponse needs to correspond to the request it was given 
*/
protocol UseCase {
    associatedtype T: Request
    func handleRequest(request: T) -> T.Out
}

protocol Request {
    associatedtype Out: Response
}

protocol Response {
}
/*------------------------------------------*/


/*
 Here's a specific use case I might want.
*/
protocol GetFriendsUseCaseType: UseCase {
    func handleRequest(request: GetFriendsRequest) -> GetFriendsResponse
}

struct GetFriendsUseCase: GetFriendsUseCaseType {
    func handleRequest(request: GetFriendsRequest) -> GetFriendsResponse {
        //do some work
        return GetFriendsResponse()
    }
}

struct TestGetFriendsUseCase: GetFriendsUseCaseType {
    func handleRequest(request: GetFriendsRequest) -> GetFriendsResponse {
        //do something under test circumstances
        return GetFriendsResponse()
    }
}

struct GetFriendsRequest: Request {
    typealias Out = GetFriendsResponse
}

struct GetFriendsResponse: Response {}
/*-----------------------------------------------*/



/*
 Here's where the issues happen
 
 I cannot use the specific use case as a type because of the associatedtype
 
 BUT
 
 really this there is no amibiguity because I specify that this is a GetFriendsUseCaseType so the associated type
 is explicit.
 
 My question is why can't I do this? Can you think of a theoretical situation where this is too ambiguous to know the type at compile-time or is this just a missing feature of swift? I want to basically promote GetFriendsUseCaseType away from the associatedtype requirement of UseCase
 */
struct SomeViewModel {
    let getFriendsUseCase: GetFriendsUseCaseType
    
    init(getFriendsUseCase: GetFriendsUseCaseType) {
        self.getFriendsUseCase = getFriendsUseCase
    }
}







