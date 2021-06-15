//
//  Router.swift
//  VIPER(シャキョウ）
//
//  Created by Owner on 2021/06/13.
//

// object
// EntryPoint


import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController


protocol AnyRouter {
    
    var entry: EntryPoint? { get }
    
    static func start() -> AnyRouter
}



class UserRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return router
        
    }
    
    
}



















