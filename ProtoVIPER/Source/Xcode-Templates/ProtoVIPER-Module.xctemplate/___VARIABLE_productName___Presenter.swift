// ___FILEHEADER___

import UIKit

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol ___VARIABLE_productName___Presenter: PresenterBaseProto, ModulePresenterProto {

    init(inputConf: ___VARIABLE_productName___ModuleInput, view: ___VARIABLE_productName___View, interactor: ___VARIABLE_productName___Interactor, router: ___VARIABLE_productName___Router)
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: Implementation boilerplate

class ___VARIABLE_productName___PresenterImpl: PresenterBaseProto, ___VARIABLE_productName___Presenter {

    let inputConf: ___VARIABLE_productName___ModuleInput

    private(set) weak var view: ___VARIABLE_productName___View?
    private(set) var interactor: ___VARIABLE_productName___Interactor
    let router: ___VARIABLE_productName___Router

    ////////////////////////
    // MARK: Initialization

    required init(inputConf: ___VARIABLE_productName___ModuleInput, view: ___VARIABLE_productName___View, interactor: ___VARIABLE_productName___Interactor, router: ___VARIABLE_productName___Router) {
        self.inputConf  = inputConf
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: Lifecycle

extension ___VARIABLE_productName___PresenterImpl {
    
//    func awakeFromAssembly() {}
//    func awakeFromViewDidLoad() {}
//    func awakeFromViewWillAppear() {}
//    func awakeFromViewDidAppear() {}
//    func awakeFromViewWillDisappear() {}
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

