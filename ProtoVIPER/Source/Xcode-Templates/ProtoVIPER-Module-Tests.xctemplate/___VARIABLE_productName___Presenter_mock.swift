// ___FILEHEADER___

import UIKit
@testable import ___PROJECTNAME___

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ___VARIABLE_productName___PresenterImpl_mock: ___VARIABLE_productName___Presenter {

    let inputConf: ___VARIABLE_productName___ModuleInput
    weak var view: ___VARIABLE_productName___View?
    var interactor: ___VARIABLE_productName___Interactor?
    let router: ___VARIABLE_productName___Router

    required init(inputConf: ___VARIABLE_productName___ModuleInput, view: ___VARIABLE_productName___View, interactor: ___VARIABLE_productName___Interactor, router: ___VARIABLE_productName___Router) {
        self.inputConf = inputConf
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    ////////////////////////

    var callListener: ((String) -> Void)?
    var injectedHandlers: [String: () throws -> Any?] = [:]

    ////////////////////////

    func awakeFromAssembly() {
        print(#function)
        callListener?(#function)
        _ = try! injectedHandlers[#function]?()
    }
    func awakeFromViewDidLoad() {
        print(#function)
        callListener?(#function)
        _ = try! injectedHandlers[#function]?()
    }
    func awakeFromViewWillAppear() {
        print(#function)
        callListener?(#function)
        _ = try! injectedHandlers[#function]?()
    }
    func awakeFromViewDidAppear() {
        print(#function)
        callListener?(#function)
        _ = try! injectedHandlers[#function]?()
    }
    func awakeFromViewWillDisappear() {
        print(#function)
        callListener?(#function)
        _ = try! injectedHandlers[#function]?()
    }

    ////////////////////////

//    func doSomething() -> Promise<Something?> {
//        print(#function)
//        callListener?(#function)
//        return Promise(injectedHandlers[#function] ?? { nil })
//    }


}
