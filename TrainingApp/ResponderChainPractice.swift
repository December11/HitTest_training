//
//  ResponderChainPractice.swift
//  TrainingApp
//
//  Created by Alla Shkolnik on 08.09.2022.
//

import UIKit

final class BlinkableView: UIControl {
//    override var canBecomeFirstResponder: Bool {
//        return true
//    }

//    func select() {
//        becomeFirstResponder()
//    }

    @objc func performBlinkAction() {
        //Blinking animation
        print("some view was tapped! i'm blinking!!! ✨✨✨")
    }
}

final class MyViewController2: UIViewController {
    @objc func myCustomMethod() {
        print("SwiftRocks!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.sendAction(#selector(myCustomMethod), to: nil, from: view, for: nil)
    }
}

extension UIResponder {
    func responderChain() -> String {
        guard let next = next else {
            return String(describing: self)
        }
        return String(describing: self) + " -> " + next.responderChain()
    }
}

final class PushScreenEvent: UIEvent {

    let viewController: CoordenableViewController

    override var type: UIEvent.EventType {
        return .touches
    }

    init(viewController: CoordenableViewController) {
        self.viewController = viewController
    }
}

final class Coordinator: UIResponder {

    weak var viewController: CoordenableViewController?

    override var next: UIResponder? {
        return viewController?.originalNextResponder
    }

    @objc func pushNewScreen(sender: Any?, event: PushScreenEvent) {
        let new = event.viewController
        viewController?.navigationController?.pushViewController(new, animated: true)
    }
}

class CoordenableViewController: UIViewController {

    override var canBecomeFirstResponder: Bool {
        return true
    }

    private(set) var coordinator: Coordinator?
    private(set) var originalNextResponder: UIResponder?

    override var next: UIResponder? {
        return coordinator ?? super.next
    }

    override func viewDidAppear(_ animated: Bool) {
        //Fill info at viewDidAppear to make sure UIKit
        //has configured this view's next responder.
        super.viewDidAppear(animated)
        guard coordinator == nil else {
            return
        }
        originalNextResponder = next
        coordinator = Coordinator()
        coordinator?.viewController = self
    }
}

final class MyViewController: CoordenableViewController {
    //...
}

//From anywhere in the app:


