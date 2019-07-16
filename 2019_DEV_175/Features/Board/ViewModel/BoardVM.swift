//
//  BoardVM.swift
//  2019_DEV_175
//

import UIKit

protocol BoardDelegate: class {
    func gameFinished(text: String)
    func setImage(at index: Int, image: String)
}

final class BoardVM: ViewModelType {

    typealias ProtocolDelegate = BoardDelegate
    weak var delegate: BoardDelegate?

    private var board: Board
    init() {
        board = Board()
    }

    func didSelectSquare(at index: Int) {
        guard board.setPiece(at: index) else {
            return
        }
        let image = board.previousPlayer == .cross ? "cross" : "circle"
        delegate?.setImage(at: index, image: image)
        checkIsFinished()
    }

    func resetGame() {
        board = Board()
    }

    /**
     Checks game's status and call the appropriate delegate function.

     if the game's status is a draw or a win, the delegate function gameFinished(text: String) will be called.
     */
    private func checkIsFinished() {
        let state = board.isWinnable()

        switch state {
        case .draw:
            delegate?.gameFinished(text: "draw".localized)
        case .win:
            let text = "win".localized+" "+board.getWinner()
            delegate?.gameFinished(text: text)
        default:
            //game in progress
            break
        }
    }
}
