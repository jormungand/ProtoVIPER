// ___FILEHEADER___

import Foundation
@testable import ___PROJECTNAME___

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ___VARIABLE_productName___InteractorImpl_mock: ___VARIABLE_productName___Interactor {

    var queue: DispatchQueue

    required convenience init() {
        self.init(queue: DispatchQueue.global(qos: .background))
    }

    required init(queue: DispatchQueue = DispatchQueue.global(qos: .background)) {
        self.queue = queue
    }

    ////////////////////////

    var callListener: ((String) -> Void)?
    var injectedHandlers: [String: () throws -> Any?] = [:]

    ////////////////////////

//    func doSomething() -> Promise<Something?> {
//        print(#function)
//        callListener?(#function)
//        return Promise(injectedHandlers[#function] ?? { nil })
//    }


}
