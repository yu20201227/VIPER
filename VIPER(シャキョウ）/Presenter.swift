//
//  Presenter.swift
//  VIPER(シャキョウ）
//
//  Created by Owner on 2021/06/13.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var view: AnyView? { get set }
    var interactor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
    
    func receiveDataFromInteractor(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var view: AnyView?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.letPresenterKnowFetchingHasDone()
        }
    }
    
    var router: AnyRouter?
    
    func receiveDataFromInteractor(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "something went wrong")
        }
        
    }

}
