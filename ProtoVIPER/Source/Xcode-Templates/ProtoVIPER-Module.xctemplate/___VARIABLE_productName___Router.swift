// ___FILEHEADER___

import UIKit

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol ___VARIABLE_productName___Router: RouterBaseProto, ModuleRouterProto {
    init(view: ___VARIABLE_productName___View)
    var resolver: ___VARIABLE_productName___ModuleRoutingResolverProto! { get set }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////


class ___VARIABLE_productName___RouterImpl {

    var resolver: ___VARIABLE_productName___ModuleRoutingResolverProto!
    private weak var concreteView: ___VARIABLE_productName___View?

    private(set) var view: UIViewController? {
        get { return concreteView }
        set { concreteView = newValue as? ___VARIABLE_productName___View }
    }

    ////////////////////////

    required init(view: ___VARIABLE_productName___View) {
        self.view = view
    }

    ////////////////////////
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension ___VARIABLE_productName___RouterImpl: ___VARIABLE_productName___Router {
    
}
