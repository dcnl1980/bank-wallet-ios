import UIKit

class GuestRouter {
    weak var viewController: UIViewController?
}

extension GuestRouter: IGuestRouter {

    func navigateToBackupRoutingToMain() {
        viewController?.present(BackupRouter.module(mode: .initial), animated: true)
    }

    func navigateToRestore() {
        viewController?.present(RestoreRouter.module(), animated: true)
    }

}

extension GuestRouter {

    static func module() -> UIViewController {
        let router = GuestRouter()
        let interactor = GuestInteractor(authManager: App.shared.authManager, wordsManager: App.shared.wordsManager, systemInfoManager: App.shared.systemInfoManager)
        let presenter = GuestPresenter(interactor: interactor, router: router)
        let viewController = GuestViewController(delegate: presenter)

        presenter.view = viewController
        interactor.delegate = presenter
        router.viewController = viewController

        return viewController
    }

}
