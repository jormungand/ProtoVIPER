// ___FILEHEADER___

import UIKit

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

typealias ___VARIABLE_productName___View = ___VARIABLE_productName___ViewProto & UIViewController

////////////////////////

protocol ___VARIABLE_productName___ViewProto: ModuleViewProto {
    var presenter: ___VARIABLE_productName___Presenter! { get set }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ___VARIABLE_productName___ViewController: UIViewController {

    var presenter: ___VARIABLE_productName___Presenter!
    
    ////////////////////////

    override func viewDidLoad() {
        defer { presenter.awakeFromViewDidLoad() }
        super.viewDidLoad()
        // ...
    }

    ////////////////////////
    
    override func viewWillAppear(_ animated: Bool) {
        defer { presenter.awakeFromViewWillAppear() }
        super.viewWillAppear(animated)
        // ...
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension ___VARIABLE_productName___ViewController: ___VARIABLE_productName___ViewProto {
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
