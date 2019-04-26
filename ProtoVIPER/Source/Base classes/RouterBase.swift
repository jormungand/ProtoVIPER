//
//  RouterBase.swift
//  ProtoVIPER
//
//  Created by Ilya Stroganov on 1/7/19.
//  Copyright © 2019 Ilya Stroganov. All rights reserved.
//

import UIKit
//import Promises

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol RouterBaseProto {
    var view: UIViewController? { get }
    
    //    @discardableResult func presentModally(_ vc: UIViewController, animated: Bool) -> Promise<Void>
    //
    //    @discardableResult func dismiss(_ vc: UIViewController, animated: Bool) -> Promise<Void>
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension RouterBaseProto {
    
    ////////////////////////
    
    //    @discardableResult func presentModally(_ vc: UIViewController, animated: Bool = true) -> Promise<Void> {
    //        return wrap(on: .main) { self.view?.present(vc, animated: animated, completion: $0) }
    //    }
    //
    //    ////////////////////////
    //
    //    @discardableResult func dismiss(_ vc: UIViewController, animated: Bool = true) -> Promise<Void> {
    //        return wrap(on: .main) { vc.dismiss(animated: animated, completion: $0) }
    //    }
    
    ////////////////////////
}

