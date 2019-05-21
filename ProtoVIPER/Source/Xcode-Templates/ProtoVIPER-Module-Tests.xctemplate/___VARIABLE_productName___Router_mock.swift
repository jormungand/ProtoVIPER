// ___FILEHEADER___

import UIKit
@testable import ___PROJECTNAME___

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ___VARIABLE_productName___RouterImpl_mock: ___VARIABLE_productName___Router {

    var resolver: ___VARIABLE_productName___ModuleRoutingResolverProto!
    private weak var concreteView: ___VARIABLE_productName___View?

    var view: UIViewController? {
        get { return concreteView }
        set { concreteView = newValue as? ___VARIABLE_productName___View }
    }

    ////////////////////////

    required init(view: ___VARIABLE_productName___View) {
        self.view = view
    }

    ////////////////////////

    var callListener: ((String) -> Void)?
    var injectedHandlers: [String: () throws -> Any?] = [:]

    ////////////////////////

//    func showSomeModule() -> Promise<UIViewController?> {
//        print(#function)
//        callListener?(#function)
//        return Promise(injectedHandlers[#function] ?? { nil })
//    }


}
