//
//  Sudoku.swift
//  Sudoku
//
//  Created by jungwooram on 2020-01-07.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import Foundation

class Sudoku{
    
    private var board = [[Int]](repeating: Array(repeating: 0, count: 9), count: 9)
    
    
    init(board:[[Int]]) {
        self.board = board
    }
    
    func getBoard() -> [[Int]]{
        return board
    }
    
    func solveSudoku() -> Bool {
        solve(idx: 0)
    }
    
    private func solve(idx:Int) -> Bool{
        
        if idx == 81{
            return true
        }
        
        let row = idx/9
        let col = idx%9
        let currentNum = board[row][col]
        
        if currentNum != 0{
            return solve(idx: idx+1)
        }else{
            for i in 1...9{
                board[row][col] = i
                if isValidSudoku(){
                    let solved = solve(idx: idx+1)
                    if solved{
                        return true
                    }
                }
                
            }
            board[row][col] = 0
            return false
        }
    }
    
    private func isValidSudoku() -> Bool{
        
        for k in 0..<3{
        
            for r in 0..<9{
            
                var checker = [Bool](repeating: false, count: 9)
                var currentNum = 0;
                
                for c in 0..<9{
                
                    
                    if k==0{
                        currentNum = board[r][c]
                    }else if k == 1{
                        currentNum = board[c][r]
                    }else{
                        currentNum = board[r/3*3 + c/3][r%3*3 + c%3]
                    }
                    
                    if currentNum != 0{
                        if checker[currentNum-1]{
                            return false
                        }
                        checker[currentNum-1] = true
                    }
                    
                }
                
            }
            
        }
        
        return true
    }
    
}
