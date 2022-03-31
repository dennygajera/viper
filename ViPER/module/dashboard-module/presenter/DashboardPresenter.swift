//
//  DashboardPresenter.swift
//  ViPER
//
//  Created by Darshan Gajera on 30/03/22.
//

import UIKit

class DashboardPresenter: InteractorToPresenter, ViewToPresenter {
    
    var view: PresenterToView?
    
    var interactor: PresenterToInteractor?
    
    var router: PresenterToRouter?
    
    func fetchdata() {
        interactor?.fetchData()
    }
    
    func successWithData(arrContest: [ContestModel]) {
        view?.successWithData(arrContest: arrContest)
    }
    
    func errorFromApi(objErr: Error) {
        view?.errorFromApi(objErr: objErr)
    }

}


