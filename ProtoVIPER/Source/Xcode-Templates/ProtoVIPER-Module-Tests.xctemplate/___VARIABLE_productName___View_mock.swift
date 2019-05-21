// ___FILEHEADER___

import UIKit
@testable import ___PROJECTNAME___

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ___VARIABLE_productName___ViewController_mock: UIViewController, ___VARIABLE_productName___ViewProto {

    var presenter: ___VARIABLE_productName___Presenter!

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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
