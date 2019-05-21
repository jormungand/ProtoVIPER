// ___FILEHEADER___

import UIKit
@testable import ___PROJECTNAME___

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ___VARIABLE_productName___Module_mock<M: ModulePartsProtoExtended>: Module_mock<M> {

    override func assembleModule() -> UIViewController {
        let router = container.router as! ___VARIABLE_productName___Router
        let view = container.view as! ___VARIABLE_productName___View
        let presenter = container.presenter as! ___VARIABLE_productName___Presenter
        let resolver = container.routingResolver as! ___VARIABLE_productName___ModuleRoutingResolverProto

        router.resolver = resolver
        view.presenter = presenter

        presenter.awakeFromAssembly()
        return view
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ___VARIABLE_productName___ModuleRoutingResolver_mock: ___VARIABLE_productName___ModuleRoutingResolverProto {

    lazy var handlers: [String: ((ModuleInputProto) -> ModuleAssemblyMarker)] = [
        "someModule"    : { input in FakeModuleAssembly(input, handler: self.callback) },
    ]

    var callback: ((ModuleAssemblyMarker) -> Void)?
    required init() {}

//    func someModule(_ inputConf: SomeModuleModuleInput) -> ModuleAssemblyMarker     { return handlers["someModule"]!(inputConf) }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
