// ___FILEHEADER___

import UIKit

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Input

struct ___VARIABLE_productName___ModuleInput: ModuleInputProto {
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Internal Dependencies

struct ___VARIABLE_productName___ModuleParts: ModulePartsProtoExtended {
    typealias ModuleInput           = ___VARIABLE_productName___ModuleInput
    typealias ModuleRoutingResolver = ___VARIABLE_productName___ModuleRoutingResolver
    
    typealias View          = TypePair<___VARIABLE_productName___View, ___VARIABLE_productName___ViewController>
    typealias Interactor    = TypePair<___VARIABLE_productName___Interactor, ___VARIABLE_productName___InteractorImpl>
    typealias Presenter     = TypePair<___VARIABLE_productName___Presenter, ___VARIABLE_productName___PresenterImpl>
    typealias Router        = TypePair<___VARIABLE_productName___Router, ___VARIABLE_productName___RouterImpl>
}

////////////////////////

class ___VARIABLE_productName___ModuleDependencyContainer: ModuleDependencyContainer<___VARIABLE_productName___ModuleParts> {
    
    required init(inputConf: Module.ModuleInput, dependencyResolver: DependencyResolverProto) {
        super.init(inputConf: inputConf, dependencyResolver: dependencyResolver)
        moduleName = "___VARIABLE_productName___"
    }
    
    override func createView()       -> Module.View.Proto        { return resolver.resolve() as Module.View.Proto }
    override func createInteractor() -> Module.Interactor.Proto  { return interactorType.init() }
    override func createRouter()     -> Module.Router.Proto      { return routerType.init(view: view) }
    override func createPresenter()  -> Module.Presenter.Proto   {
        return presenterType.init(inputConf: inputConf, view: view, interactor: interactor, router: router)
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Routing

protocol ___VARIABLE_productName___ModuleRoutingResolverProto: ModuleRoutingResolverProto {
    //    func someModule(_ inputConf: SomeModuleInput)   -> ModuleAssemblyMarker
}

////////////////////////

class ___VARIABLE_productName___ModuleRoutingResolver: ___VARIABLE_productName___ModuleRoutingResolverProto {
    required init() {}
    //    func someModule(_ inputConf: SomeModuleInput)   -> ModuleAssemblyMarker { return SomeModuleInput(inputConf: inputConf) }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Assembly

class ___VARIABLE_productName___Module: ModuleAssemblyProto {
    
    typealias M = ___VARIABLE_productName___ModuleParts
    typealias DC = ___VARIABLE_productName___ModuleDependencyContainer
    
    let inputConf: M.ModuleInput
    let container: DC
    
    ////////////////////////
    
    required convenience init(inputConf: M.ModuleInput) {
        let container = DC.default(inputConf: inputConf)
        self.init(container)
    }
    
    public required init(_ dependencyContainer: DC) {
        self.container = dependencyContainer
        self.inputConf = dependencyContainer.inputConf
    }
    
    ////////////////////////
    
    func assembleModule() -> UIViewController {
        container.router.resolver = container.routingResolver
        container.view.presenter = container.presenter
        container.presenter.awakeFromAssembly()
        return container.view
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Misc

extension ___VARIABLE_productName___ModuleInput: Equatable {
    static func == (lhs: ___VARIABLE_productName___ModuleInput, rhs: ___VARIABLE_productName___ModuleInput) -> Bool {
        return true
    }
}

