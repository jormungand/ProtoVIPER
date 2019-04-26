//
//  DependencyResolver.swift
//  ProtoVIPER
//
//  Created by Ilya Stroganov on 1/7/19.
//  Copyright © 2019 Ilya Stroganov. All rights reserved.
//

import Foundation

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol DependencyResolverProto {
    func register<T>(factory: @escaping () -> T)
    func register<T>(_ tag: String?, factory: @escaping () -> T)
    
    func resolve<T>() -> T
    func resolve<T>(_ tag: String?) -> T
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

public class DependencyResolver: DependencyResolverProto {
    
    private var registry = Dictionary<AnyHashable, Any>()
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func register<T>(factory: @escaping () -> T) {
        return register(nil, factory: factory)
    }
    
    ////////////////////////
    
    func register<T>(_ tag: String? = nil, factory: @escaping () -> T) {
        let key = Key(factoryType: T.self, tag: tag)
        if registry[key] != nil { fatalError("Factory already registered for key: \(key)") }
        registry[key] = Value<T>(factory: factory)
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func resolve<T>() -> T {
        return resolve(nil)
    }
    
    ////////////////////////
    
    func resolve<T>(_ tag: String? = nil) -> T {
        let key = Key(factoryType: T.self, tag: tag)
        guard let value = registry[key] as? Value<T> else { fatalError("No factory registered for key: \(key)") }
        return value.factory()
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension DependencyResolver {
    
    struct Key<T> {
        let factoryType: T.Type
        let tag: String?
    }
    
    ////////////////////////
    
    struct Value<T>: CustomStringConvertible {
        let factory: () -> T
        
        var description: String {
            return "\(type(of: self)) :: factory = () -> \(T.self)"
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension DependencyResolver.Key: Hashable, CustomStringConvertible {
    
    var description: String {
        return "\(type(of: self)) :: factoryType: \(factoryType), tag: \(String(describing: tag))"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(factoryType)-\(String(describing: tag))")
    }
    
    static func == (lhs: DependencyResolver.Key<T>, rhs: DependencyResolver.Key<T>) -> Bool {
        return lhs.factoryType == rhs.factoryType && lhs.tag == rhs.tag
    }
}

