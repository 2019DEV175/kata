//
//  BoardController.swift
//  2019_DEV_175
//

import UIKit

class BoardController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!

    private let boardVM = BoardVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        boardVM.delegate = self
    }

    @IBAction func didPressBox(_ sender: UIButton) {
        self.boardVM.didSelectSquare(at: sender.tag)
    }

    @IBAction func didPressReset(_ sender: UIButton) {
        resetButton.isHidden = true
        for button in buttons {
            button.setImage(nil, for: .normal)
        }
        statusLabel.text = nil
        boardVM.resetGame()
    }
}

extension BoardController: BoardDelegate {
    func gameFinished(text: String) {
        statusLabel.text = text
        resetButton.isHidden = false
    }

    func setImage(at index: Int, image: String) {
        buttons[index].setImage(UIImage(named: image), for: .normal)
    }
}
