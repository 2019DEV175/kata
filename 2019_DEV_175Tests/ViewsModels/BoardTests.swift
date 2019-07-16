//
//  BoardVMTests.swift
//
//

import Quick
import Nimble

class BoardTests: QuickSpec {
    var board = Board()

    override func spec() {
        createModelTests()
        gameStatusTests()
        movePieceTests()
    }

    // MARK: - createModelTests
    private func createModelTests() {
        describe("Board model creation tests") {

            context("When the board is created") {

                it("The allowed moves must be 9") {
                    expect(self.board.allowedMoves).to(equal(9))
                }

                it("The previous player must be empty") {
                    expect(self.board.previousPlayer).to(equal(.empty))
                }

                it("The game state must be in progress") {
                    expect(self.board.gameStatus).to(equal(.progress))
                }

                it("The board status must be filled with 9 cases") {
                    expect(self.board.caseStatus.count).to(equal(9))
                }

                it("The board status must be filled with empty cases") {
                    let array = self.board.caseStatus.filter({ $0 != .empty })
                    expect(array.count).to(equal(0))
                }
            }
        }
    }

    // MARK: - movePieceTests
    private func movePieceTests() {
        describe("Users set piece on a case tests") {

            context("When the game is started") {

                it("Set a unauthorized moves at -1") {
                    expect(self.board.setPiece(at: -1)).to(beFalse())
                }

                it("Set a unauthorized moves at 9") {
                    expect(self.board.setPiece(at: 9)).to(beFalse())
                }

                it("Set a piece on an empty case as first move") {
                    expect(self.board.setPiece(at: 0)).to(beTrue())
                }

                it("Checks allowed moves count after piece has moved") {
                    expect(self.board.allowedMoves).to(equal(8))
                }

                it("Checks allowed case content after first move") {
                    expect(self.board.caseStatus[0]).to(equal(.cross))
                }

                it("Checks previousPlayer after first move") {
                    expect(self.board.previousPlayer).to(equal(.cross))
                }

                it("Set a piece on an occupied case as second move") {
                    expect(self.board.setPiece(at: 0)).to(beFalse())
                }

                it("Checks previousPlayer after moving failed") {
                    expect(self.board.previousPlayer).to(equal(.cross))
                }

                it("Checks allowed moves count after moving failed") {
                    expect(self.board.allowedMoves).to(equal(8))
                }

                it("Set a piece on an empty case as second move") {
                    expect(self.board.setPiece(at: 1)).to(beTrue())
                }

                it("Checks allowed case content after second move") {
                    expect(self.board.caseStatus[1]).to(equal(.circle))
                }

                it("Checks allowed moves count after second move") {
                    expect(self.board.allowedMoves).to(equal(7))
                }

                it("Checks previousPlayer after second move") {
                    expect(self.board.previousPlayer).to(equal(.circle))
                }
            }
        }
    }

    // MARK: - gameStatusTests
    private func gameStatusTests() {
        describe("Checks winnable condition") {

            context("When the game is won") {

                afterEach {
                    self.board.caseStatus = [.empty, .empty, .empty,
                                             .empty, .empty, .empty,
                                             .empty, .empty, .empty]
                }

                it("Checks [0,1,2] = [x,x,x,0,0,0,0,0,0]") {
                    self.board.caseStatus = [.cross, .cross, .cross,
                                             .empty, .empty, .empty,
                                             .empty, .empty, .empty]
                    expect(self.board.isWinnable()).to(equal(.win))
                }

                it("Checks [3,4,5] = [0,0,0,x,x,x,0,0,0]") {
                    self.board.caseStatus = [.empty, .empty, .empty,
                                             .cross, .cross, .cross,
                                             .empty, .empty, .empty]
                    expect(self.board.isWinnable()).to(equal(.win))
                }

                it("Checks [6,7,8] = [0,0,0,0,0,0,x,x,x]") {
                    self.board.caseStatus = [.empty, .empty, .empty,
                                             .empty, .empty, .empty,
                                             .cross, .cross, .cross]
                    expect(self.board.isWinnable()).to(equal(.win))
                }

                it("Checks [0,3,6] = [x,0,0,x,0,0,x,0,0]") {
                    self.board.caseStatus = [.cross, .empty, .empty,
                                             .cross, .empty, .empty,
                                             .cross, .empty, .empty]
                    expect(self.board.isWinnable()).to(equal(.win))
                }

                it("Checks [1,4,7] = [0,x,0,0,x,0,0,x,0]") {
                    self.board.caseStatus = [.empty, .cross, .empty,
                                             .empty, .cross, .empty,
                                             .empty, .cross, .empty]
                    expect(self.board.isWinnable()).to(equal(.win))
                }

                it("Checks [2,5,8] = [0,0,x,0,0,x,0,0,x]") {
                    self.board.caseStatus = [.empty, .empty, .cross,
                                             .empty, .empty, .cross,
                                             .empty, .empty, .cross]
                    expect(self.board.isWinnable()).to(equal(.win))
                }

                it("Checks [0,4,8] = [x,0,0,0,x,0,0,0,x]") {
                    self.board.caseStatus = [.cross, .empty, .empty,
                                             .empty, .cross, .empty,
                                             .empty, .empty, .cross]
                    expect(self.board.isWinnable()).to(equal(.win))
                }

                it("Checks [2,4,6] = [0,0,x,0,x,0,x,0,0]") {
                    self.board.caseStatus = [.empty, .empty, .cross,
                                             .empty, .cross, .empty,
                                             .cross, .empty, .empty]
                    expect(self.board.isWinnable()).to(equal(.win))
                }
            }
        }

        describe("Checks draw") {

            context("When the game is finished with a draw") {

                beforeEach {
                    self.board.allowedMoves = 0
                }

                afterEach {
                    self.board.allowedMoves = 9
                }

                it("Checks draw status") {
                    expect(self.board.isWinnable()).to(equal(.draw))
                }
            }
        }

        describe("Checks in progress status") {

            context("When the game is in progress") {

                beforeEach {
                    self.board.allowedMoves = 1
                }

                afterEach {
                    self.board.allowedMoves = 9
                }

                it("Checks draw status") {
                    expect(self.board.isWinnable()).to(equal(.progress))
                }
            }
        }
    }
}
