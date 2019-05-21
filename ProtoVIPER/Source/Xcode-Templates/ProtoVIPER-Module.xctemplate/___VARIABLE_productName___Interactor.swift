// ___FILEHEADER___

import Foundation

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol ___VARIABLE_productName___Interactor: class, ModuleInteractorProto {
    init()
    init(queue: DispatchQueue)
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ___VARIABLE_productName___InteractorImpl: ___VARIABLE_productName___Interactor {

    private let queue: DispatchQueue
    
    ////////////////////////
    
    required convenience init() {
        self.init(queue: DispatchQueue(label: "___VARIABLE_productName___Interactor queue", qos: .userInitiated))
    }

    required init(queue: DispatchQueue) {
        self.queue = queue
    }

    ////////////////////////

}
