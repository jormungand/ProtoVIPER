// ___FILEHEADER___

import XCTest
@testable import ___PROJECTNAME___

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

private let defaultTimeoutForExpectation = 5.0

////////////////////////

struct Mocked___VARIABLE_productName___ModuleParts: ModulePartsProtoExtended {
    typealias ModuleInput           = ___VARIABLE_productName___ModuleInput
    typealias ModuleRoutingResolver = ___VARIABLE_productName___ModuleRoutingResolver_mock

    typealias View          = TypePair<___VARIABLE_productName___View, ___VARIABLE_productName___ViewController_mock>
    typealias Interactor    = TypePair<___VARIABLE_productName___Interactor, ___VARIABLE_productName___InteractorImpl_mock>
    typealias Presenter     = TypePair<___VARIABLE_productName___Presenter, ___VARIABLE_productName___PresenterImpl_mock>
    typealias Router        = TypePair<___VARIABLE_productName___Router, ___VARIABLE_productName___RouterImpl_mock>
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Common

class ___VARIABLE_productName___ModuleTests: XCTestCase {

    typealias Parts = MockedModuleParts<___VARIABLE_productName___ModuleParts, Mocked___VARIABLE_productName___ModuleParts>
    typealias Assembly = ___VARIABLE_productName___Module_mock

    ////////////////////////

    func testViewType() {
        typealias ENV = ___VARIABLE_productName___ModuleTests.Parts.OnlyRealView
        let module = ___VARIABLE_productName___ModuleTests.setupForView() as! ___VARIABLE_productName___ModuleTests.Assembly<ENV>
        _ = module.assembleModule()

        XCTAssert(module.container.view is ENV.View.Impl)
        XCTAssert(module.container.view.presenter is ENV.Presenter.Impl)
    }

    func testPresenterType() {
        typealias ENV = ___VARIABLE_productName___ModuleTests.Parts.OnlyRealPresenter
        let module = ___VARIABLE_productName___ModuleTests.setupForPresenter() as! ___VARIABLE_productName___ModuleTests.Assembly<ENV>
        _ = module.assembleModule()

        let presenter = module.container.presenter as! ENV.Presenter.Impl

        XCTAssert(presenter.view is ENV.View.Impl)
        XCTAssert(presenter.router is ENV.Router.Impl)
        XCTAssert(presenter.interactor is ENV.Interactor.Impl)
    }

    func testInteractorType() {
        typealias ENV = ___VARIABLE_productName___ModuleTests.Parts.OnlyRealInteractor
        let module = ___VARIABLE_productName___ModuleTests.setupForInteractor() as! ___VARIABLE_productName___ModuleTests.Assembly<ENV>
        _ = module.assembleModule()

        XCTAssert(module.container.interactor is ENV.Interactor.Impl)
    }

    func testRouterType() {
        typealias ENV = ___VARIABLE_productName___ModuleTests.Parts.OnlyRealRouter
        let module = ___VARIABLE_productName___ModuleTests.setupForRouter() as! ___VARIABLE_productName___ModuleTests.Assembly<ENV>
        _ = module.assembleModule()

        XCTAssert(module.container.router is ENV.Router.Impl)
        XCTAssert(module.container.router.view is ENV.View.Impl)
    }

    func testModuleInputEquality() {
        XCTAssert(___VARIABLE_productName___ModuleParts.ModuleInput.init() == ___VARIABLE_productName___ModuleInput.init())
    }

    func testInitWithInputConf() {
        typealias ENV = ___VARIABLE_productName___ModuleTests.Parts.Real
        let module = ___VARIABLE_productName___Module(inputConf: .init())
        _ = module.assembleModule()

        XCTAssert(module.container.view is ENV.View.Impl)
        XCTAssert(module.container.interactor is ENV.Interactor.Impl)
        XCTAssert(module.container.router is ENV.Router.Impl)
        XCTAssert(module.container.presenter is ENV.Presenter.Impl)
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - View

class ___VARIABLE_productName___ModuleViewTests: XCTestCase {

    func testViewLifecycle() {
        typealias ENV = Parts.OnlyRealView
        let module = ___VARIABLE_productName___ModuleTests.setupForView() as! ___VARIABLE_productName___ModuleTests.Assembly<ENV>

        let presenter = module.container.presenter as! ENV.Presenter.Impl
        let vc = module.assembleModule()
        XCTAssert(vc is ___VARIABLE_productName___ViewController)

        let exp = expectation(description: #function)
        exp.expectedFulfillmentCount = 4

        presenter.callListener = { method in
            if ["awakeFromViewDidLoad()", "awakeFromViewWillAppear()", "awakeFromViewDidAppear()", "awakeFromViewWillDisappear()"].contains(method) {
                exp.fulfill()
            }
        }

        vc.viewDidLoad()
        vc.viewWillAppear(true)
        vc.viewDidAppear(true)
        vc.viewWillDisappear(true)

        waitForExpectations(timeout: defaultTimeoutForExpectation) { error in
            guard let error = error else { return }
            print("error while waiting: \(error)")
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Interactor

class ___VARIABLE_productName___ModuleInteractorTests: XCTestCase {
    // ...
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Presenter

class ___VARIABLE_productName___ModulePresenterTests: XCTestCase {

    func testViewLifecycle() {
        typealias ENV = ___VARIABLE_productName___ModuleTests.Parts.OnlyRealPresenter
        let module = ___VARIABLE_productName___ModuleTests.setupForPresenter() as! ___VARIABLE_productName___ModuleTests.Assembly<ENV>

        let presenter = module.container.presenter as! ENV.Presenter.Impl

        let exp = expectation(description: #function)
        exp.expectedFulfillmentCount = 1

        presenter.awakeFromViewDidLoad()
        presenter.awakeFromViewWillAppear()
        presenter.awakeFromViewDidAppear()
        presenter.awakeFromViewWillDisappear()

        exp.fulfill()

        waitForExpectations(timeout: defaultTimeoutForExpectation) { error in
            guard let error = error else { return }
            print("error while waiting: \(error)")
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Router

class ___VARIABLE_productName___ModuleRouterTests: XCTestCase {
    // ...
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: - Setup helpers

extension ___VARIABLE_productName___ModuleTests {

    static func setupForView(inputConf: Parts.OnlyRealView.ModuleInput = .init()) -> ModuleAssemblyMarker {
        typealias ENV = Parts.OnlyRealView
        let dic = ModuleDependencyContainer<ENV>(inputConf: inputConf)

        dic.moduleName = "___VARIABLE_productName___"
        dic.registerDefaultFactories()

        dic.view       = dic.resolver.resolve() as ENV.View.Proto
        dic.interactor = dic.interactorType.init()
        dic.router     = dic.routerType.init(view: dic.view)
        dic.presenter  = dic.presenterType.init(inputConf: dic.inputConf, view: dic.view, interactor: dic.interactor, router: dic.router)

        dic.view.presenter  = dic.presenter
        dic.router.resolver = dic.routingResolver

        return Assembly<ENV>(dic)
    }

    ////////////////////////

    static func setupForInteractor(inputConf: Parts.OnlyRealInteractor.ModuleInput = .init()) -> ModuleAssemblyMarker {
        typealias ENV = Parts.OnlyRealInteractor
        let dic = ModuleDependencyContainer<ENV>(inputConf: inputConf)

        dic.viewFactory = { ENV.View.Impl() }
        dic.registerDefaultFactories()

        dic.view       = dic.resolver.resolve() as ENV.View.Proto
        dic.interactor = dic.interactorType.init()
        dic.router     = dic.routerType.init(view: dic.view)
        dic.presenter  = dic.presenterType.init(inputConf: dic.inputConf, view: dic.view, interactor: dic.interactor, router: dic.router)

        dic.view.presenter  = dic.presenter
        dic.router.resolver = dic.routingResolver

        return Assembly<ENV>(dic)
    }

    ////////////////////////

    static func setupForPresenter(inputConf: Parts.OnlyRealPresenter.ModuleInput = .init()) -> ModuleAssemblyMarker {
        typealias ENV = Parts.OnlyRealPresenter
        let dic = ModuleDependencyContainer<ENV>(inputConf: inputConf)

        dic.viewFactory = { ENV.View.Impl() }
        dic.registerDefaultFactories()

        dic.view       = dic.resolver.resolve() as ENV.View.Proto
        dic.interactor = dic.interactorType.init()
        dic.router     = dic.routerType.init(view: dic.view)
        dic.presenter  = dic.presenterType.init(inputConf: dic.inputConf, view: dic.view, interactor: dic.interactor, router: dic.router)

        dic.view.presenter  = dic.presenter
        dic.router.resolver = dic.routingResolver

        return Assembly<ENV>(dic)
    }

    ////////////////////////

    static func setupForRouter(inputConf: Parts.OnlyRealRouter.ModuleInput = .init()) -> ModuleAssemblyMarker {
        typealias ENV = Parts.OnlyRealRouter
        let dic = ModuleDependencyContainer<ENV>(inputConf: inputConf)

        dic.viewFactory = { ENV.View.Impl() }
        dic.registerDefaultFactories()

        dic.view       = dic.resolver.resolve() as ENV.View.Proto
        dic.interactor = dic.interactorType.init()
        dic.router     = dic.routerType.init(view: dic.view)
        dic.presenter  = dic.presenterType.init(inputConf: dic.inputConf, view: dic.view, interactor: dic.interactor, router: dic.router)

        dic.view.presenter  = dic.presenter
        dic.router.resolver = dic.routingResolver

        return Assembly<ENV>(dic)
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
