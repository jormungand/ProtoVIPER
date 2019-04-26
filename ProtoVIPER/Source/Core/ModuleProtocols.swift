//
//  ModuleProtocols.swift
//  ProtoVIPER
//
//  Created by Ilya Stroganov on 1/7/19.
//  Copyright © 2019 Ilya Stroganov. All rights reserved.
//

import Foundation
import UIKit.UIStoryboard

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Protocols: markers and holders

protocol ModuleInputProto {}
protocol ModulePresenterProto: class {
    func awakeFromAssembly()
}
protocol ModuleRouterProto: class {}
protocol ModuleInteractorProto: class {}
protocol ModuleViewProto: class {}

////////////////////////

protocol ModuleDependencyContainerMarker {}
protocol ModuleAssemblyMarker {
    func assembleModule() -> UIViewController
}

////////////////////////

protocol ModulePartsProto {
    associatedtype Presenter:   TypePairProto   where Presenter.Impl:  ModulePresenterProto
    associatedtype Router:      TypePairProto   where Router.Impl:     ModuleRouterProto
    associatedtype Interactor:  TypePairProto   where Interactor.Impl: ModuleInteractorProto
    associatedtype View:        TypePairProto   where View.Impl:       ModuleViewProto
}

////////////////////////

protocol ModulePartsProtoExtended: ModulePartsProto {
    associatedtype ModuleInput: ModuleInputProto
    associatedtype ModuleRoutingResolver: ModuleRoutingResolverProto
}

////////////////////////

protocol TypePairProto {
    associatedtype Proto
    associatedtype Impl
}

struct TypePair<Proto, Impl>: TypePairProto {}

////////////////////////

struct ModuleParts {
    typealias PresenterPair <Proto, Impl: ModulePresenterProto>  = TypePair<Proto, Impl>
    typealias RouterPair    <Proto, Impl: ModuleRouterProto>     = TypePair<Proto, Impl>
    typealias InteractorPair<Proto, Impl: ModuleInteractorProto> = TypePair<Proto, Impl>
    typealias ViewPair      <Proto, Impl: ModuleViewProto>       = TypePair<Proto, Impl>
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Generic Module Assembly protocol

protocol ModuleAssemblyInputProto {
    associatedtype ModuleInput: ModuleInputProto
    var inputConf: ModuleInput { get }
    init(inputConf: ModuleInput)
}

protocol ModuleAssemblyDependencyContainerProto {
    associatedtype ModuleDependencyContainer: ModuleDependencyContainerMarker
    var container: ModuleDependencyContainer { get }
    init(_ dependencyContainer: ModuleDependencyContainer)
}

protocol ModuleAssemblyProto: ModuleAssemblyMarker, ModuleAssemblyInputProto, ModuleAssemblyDependencyContainerProto {}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Generic Module Dependency Container protocol

protocol ModuleDependencyContainerProto: ModuleDependencyContainerMarker {
    associatedtype ModuleInput: ModuleInputProto
    associatedtype ModuleRoutingResolver: ModuleRoutingResolverProto
    associatedtype Module: ModulePartsProtoExtended
    
    var moduleName: String!                 { get set }
    var inputConf: ModuleInput              { get }
    var resolver: DependencyResolverProto   { get }
    
    var view        : Module.View.Proto       { get }
    var interactor  : Module.Interactor.Proto { get }
    var router      : Module.Router.Proto     { get }
    var presenter   : Module.Presenter.Proto  { get }
    
    var routingResolver: ModuleRoutingResolver { get set }
    
    init(inputConf: ModuleInput)
    init(inputConf: ModuleInput, dependencyResolver: DependencyResolverProto)
    static func `default`(inputConf: ModuleInput) -> Self
}

////////////////////////

class ModuleDependencyContainer<Module: ModulePartsProtoExtended>: ModuleDependencyContainerProto {
    
    var moduleName: String!
    
    let inputConf: Module.ModuleInput
    let resolver: DependencyResolverProto
    
    var routingResolver = Module.ModuleRoutingResolver()
    
    lazy var view       : Module.View.Proto         = createView()
    lazy var interactor : Module.Interactor.Proto   = createInteractor()
    lazy var router     : Module.Router.Proto       = createRouter()
    lazy var presenter  : Module.Presenter.Proto    = createPresenter()
    
    func createView()       -> Module.View.Proto        { fatalError("must override") }
    func createInteractor() -> Module.Interactor.Proto  { fatalError("must override") }
    func createRouter()     -> Module.Router.Proto      { fatalError("must override") }
    func createPresenter()  -> Module.Presenter.Proto   { fatalError("must override") }
    
    ////////////////////////
    
    lazy var storyboardFactory  = { UIStoryboard(name: self.moduleName, bundle: nil) as UIStoryboard }
    lazy var viewFactory        = { (self.resolver.resolve() as UIStoryboard).instantiateInitialViewController() as! Module.View.Proto }
    
    lazy var interactorTypeFactory  = { Module.Interactor.Impl.self  as Module.Interactor.Impl.Type }
    lazy var presenterTypeFactory   = { Module.Presenter.Impl.self   as Module.Presenter.Impl.Type }
    lazy var routerTypeFactory      = { Module.Router.Impl.self      as Module.Router.Impl.Type }
    
    lazy var interactorType : Module.Interactor.Impl.Type  = resolver.resolve()
    lazy var routerType     : Module.Router.Impl.Type      = resolver.resolve()
    lazy var presenterType  : Module.Presenter.Impl.Type   = resolver.resolve()
    
    ////////////////////////
    
    required convenience init(inputConf: Module.ModuleInput) {
        self.init(inputConf: inputConf, dependencyResolver: DependencyResolver())
    }
    
    required init(inputConf: Module.ModuleInput, dependencyResolver: DependencyResolverProto) {
        self.inputConf = inputConf
        self.resolver = dependencyResolver
    }
    
    ////////////////////////
    
    class func `default`(inputConf: Module.ModuleInput) -> Self {
        let obj = self.init(inputConf: inputConf)
        obj.registerDefaultFactories()
        return obj
    }
    
    ////////////////////////
    
    func registerDefaultFactories() {
        resolver.register(factory: storyboardFactory)
        resolver.register(factory: viewFactory)
        resolver.register(factory: interactorTypeFactory)
        resolver.register(factory: presenterTypeFactory)
        resolver.register(factory: routerTypeFactory)
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol ModuleRoutingResolverProto {
    init()
    func module<T: ModuleAssemblyProto>(inputConf: T.ModuleInput) -> T
}

extension ModuleRoutingResolverProto {
    func module<T: ModuleAssemblyProto>(inputConf: T.ModuleInput) -> T {
        return T(inputConf: inputConf)
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////



