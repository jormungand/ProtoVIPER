// ___FILEHEADER___

import UIKit

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Input

struct ___VARIABLE_productName___ModuleInput: ModuleInputProto {
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Internal Dependencies

class ___VARIABLE_productName___ModuleDependencyContainer: ModuleDependencyContainerProto {
    
    typealias ModuleInput   = ___VARIABLE_productName___ModuleInput
    typealias View          = TypePair<___VARIABLE_productName___View, ___VARIABLE_productName___ViewController>
    typealias Interactor    = TypePair<___VARIABLE_productName___Interactor, ___VARIABLE_productName___InteractorImpl>
    typealias Presenter     = TypePair<___VARIABLE_productName___Presenter, ___VARIABLE_productName___PresenterImpl>
    typealias Router        = TypePair<___VARIABLE_productName___Router, ___VARIABLE_productName___RouterImpl>
    
    typealias ModuleDefinitionType = ModuleDefinition<View, Interactor, Presenter, Router>
    
    let inputConf: ModuleInput
    let resolver: DependencyResolverProto
    let definition: ModuleDefinitionType
    
    lazy var view       : View.Proto        = resolver.resolve()
    lazy var interactor : Interactor.Proto  = definition.interactorType.init()
    lazy var router     : Router.Proto      = definition.routerType.init(view: self.view)
    lazy var presenter  : Presenter.Proto   = definition.presenterType.init(inputConf: inputConf, view: view, interactor: interactor, router: router)
    
    lazy var routingResolver = ___VARIABLE_productName___ModuleRoutingResolver()
    
    ////////////////////////
    
    required convenience init(inputConf: ModuleInput) {
        self.init(inputConf: inputConf, dependencyResolver: DependencyResolver())
    }
    
    required init(inputConf: ModuleInput, dependencyResolver: DependencyResolverProto) {
        self.inputConf = inputConf
        self.resolver = dependencyResolver
        self.definition = ModuleDefinitionType("___VARIABLE_productName___", dependencyResolver: self.resolver)
    }
    
    class func `default`(inputConf: ModuleInput) -> Self {
        let obj = self.init(inputConf: inputConf)
        obj.definition.registerDefaultFactories()
        return obj
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Routing

protocol ___VARIABLE_productName___ModuleRoutingResolverProto: ModuleRoutingResolverProto {}
class ___VARIABLE_productName___ModuleRoutingResolver: ___VARIABLE_productName___ModuleRoutingResolverProto {}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Assembly

class ___VARIABLE_productName___Module: ModuleAssemblyProto {
    
    typealias ModuleInput = ___VARIABLE_productName___ModuleInput
    typealias ModuleDependencyContainer = ___VARIABLE_productName___ModuleDependencyContainer
    
    let inputConf: ModuleInput
    let container: ModuleDependencyContainer
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Constructors
    
    required convenience init(inputConf: ModuleInput) {
        let container = ModuleDependencyContainer.default(inputConf: inputConf)
        self.init(container)
    }
    
    required init(_ dependencyContainer: ModuleDependencyContainer) {
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
