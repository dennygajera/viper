//
//  DashboardProtocols.swift
//  ViPER
//
//  Created by Darshan Gajera on 30/03/22.
//

import UIKit

protocol ViewToPresenter: AnyObject {
    var view: PresenterToView? {get set}
    var interactor: PresenterToInteractor? {get set}
    var router: PresenterToRouter? {get set}
 
    func fetchdata()
}

protocol PresenterToView: AnyObject {
    func successWithData(arrContest: [ContestModel])
    func errorFromApi(objErr: Error)
}

protocol PresenterToInteractor: AnyObject {
    var presenter: InteractorToPresenter? {get set}
    func fetchData()
}

protocol PresenterToRouter: AnyObject {
    
}

protocol InteractorToPresenter: AnyObject {
    func successWithData(arrContest: [ContestModel])
    func errorFromApi(objErr: Error)
}
