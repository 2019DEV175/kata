//
//  Board.swift
//  2019_DEV_175
//

import Foundation

enum Case {
    case empty
    case occupied
    case cross
    case circle
}

enum Status {
    case win
    case draw
    case progress
}

struct Board {
    var caseStatus: [Case]
    var allowedMoves = 9
    var previousPlayer: Case = .empty
    var gameStatus: Status = .progress

    init() {
        caseStatus = [.empty, .empty, .empty,
                      .empty, .empty, .empty,
                      .empty, .empty, .empty]
    }

    /**
     Set a piece on a board's case between 0 and 8 (case 1 - 9).
     If this is the first move, the piece will be automatically a cross, then the piece will switch to the opposite.
     
     - Parameter index: The index relative to the case
     - returns: true if the piece is set on the case
     */
    mutating func setPiece(at index: Int) -> Bool {
        guard index >= 0 && index <= 8 else {
            return false
        }

        guard caseStatus[index] == .empty && allowedMoves != 0 && gameStatus == .progress else {
            return false
        }

        allowedMoves -= 1

        switch previousPlayer {
        case .empty:
            //first move
            caseStatus[index] = .cross
        case .cross:
            caseStatus[index] = .circle
        default:
            caseStatus[index] = .cross
        }
        switchPlayer()
        return true
    }

    /**
     Constructs the winner's name
     
     - returns: a String that represents the name of the winner
     */
    func getWinner() -> String {
        return previousPlayer == .cross ? "cross".localized : "circle".localized
    }

    /**
     Switch the previous player.
     If this is the first move, the player will be automatically a cross, then the player will switch to the opposite.
     */
    private mutating func switchPlayer() {
        switch previousPlayer {
        case .empty:
            //first move
            previousPlayer = .cross
        case .cross:
            previousPlayer = .circle
        default:
            previousPlayer = .cross
        }
    }

    /**
     Checks all the winnable conditions and return the approriate game's status
     
     - returns: a Status that indicate the game's status
     */
    mutating func isWinnable() -> Status {
        gameStatus = .win
        // [0,1,2] = [x,x,x,0,0,0,0,0,0]
        if caseStatus[0] == caseStatus[1] && caseStatus[0] == caseStatus[2] && caseStatus[0] != .empty {
            return .win
        }
        // [3,4,5] = [0,0,0,x,x,x,0,0,0]
        if caseStatus[3] == caseStatus[4] && caseStatus[3] == caseStatus[5] && caseStatus[3] != .empty {
            return .win
        }
        // [6,7,8] = [0,0,0,0,0,0,x,x,x]
        if  caseStatus[6] == caseStatus[7] && caseStatus[6] == caseStatus[8] && caseStatus[6] != .empty {
            return .win
        }
        // [0,3,6] = [x,0,0,x,0,0,x,0,0]
        if caseStatus[0] == caseStatus[3] && caseStatus[0] == caseStatus[6] && caseStatus[0] != .empty {
            return .win
        }
        // [1,4,7] = [0,x,0,0,x,0,0,x,0]
        if  caseStatus[1] == caseStatus[4] && caseStatus[1] == caseStatus[7] && caseStatus[1] != .empty {
            return .win
        }
        // [2,5,8] = [0,0,x,0,0,x,0,0,x]
        if  caseStatus[2] == caseStatus[5] && caseStatus[2] == caseStatus[8] && caseStatus[2] != .empty {
            return .win
        }

        // [0,4,8] = [x,0,0,0,x,0,0,0,x]
        if caseStatus[0] == caseStatus[4] && caseStatus[0] == caseStatus[8] && caseStatus[0] != .empty {
            return .win
        }

        // [2,4,6] = [0,0,x,0,x,0,x,0,0]
        if caseStatus[2] == caseStatus[4] && caseStatus[2] == caseStatus[6] && caseStatus[2] != .empty {
            return .win
        }

        guard allowedMoves != 0 else {
            gameStatus = .draw
            return .draw
        }
        gameStatus = .progress
        return .progress
    }
}
