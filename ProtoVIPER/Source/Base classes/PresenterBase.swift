//
//  PresenterBase.swift
//  ProtoVIPER
//
//  Created by Ilya Stroganov on 1/7/19.
//  Copyright © 2019 Ilya Stroganov. All rights reserved.
//

import UIKit

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol PresenterBaseProto {
    
    func awakeFromAssembly()
    func awakeFromViewDidLoad()
    func awakeFromViewWillAppear()
    func awakeFromViewDidAppear()
    func awakeFromViewWillDisappear()
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension PresenterBaseProto {
    
    func awakeFromAssembly() {}
    func awakeFromViewDidLoad() {}
    func awakeFromViewWillAppear() {}
    func awakeFromViewDidAppear() {}
    func awakeFromViewWillDisappear() {}
}
