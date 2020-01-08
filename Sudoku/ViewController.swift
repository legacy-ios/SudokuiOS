//
//  ViewController.swift
//  Sudoku
//
//  Created by jungwooram on 2020-01-07.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    var sudokuValue = [[Int]](repeating: Array(repeating: 0, count: 9), count: 9)
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let foundView = stackView.viewWithTag(1) {
            if let field = foundView as? UITextField{
                field.becomeFirstResponder()
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        for row in 0..<9{
            for col in 0..<9{
                if let foundView = stackView.viewWithTag(row * 9 + col + 1) {
                    if let field = foundView as? UITextField{
                        field.text = String("")
                        field.delegate = self
                    }
                }
            }
        }
    
    }
   
    @IBAction func clickedSolve(_ sender: Any) {
        for row in 0..<9{
            for col in 0..<9{
                if let foundView = stackView.viewWithTag(row * 9 + col + 1) {
                    if let field = foundView as? UITextField{
                        if let text: String = field.text{
                            sudokuValue[row][col] = Int(text) ?? 0
                        }
                        
                    }
                }
            }
        }
        
        let sudoku =  Sudoku(board:sudokuValue)
        if sudoku.solveSudoku(){
            sudokuValue = sudoku.getBoard()
            
            for row in 0..<9{
                for col in 0..<9{
                    if let foundView = stackView.viewWithTag(row * 9 + col + 1) {
                        
                        if let field = foundView as? UITextField{
                            
                            field.text = String(sudokuValue[row][col])
                            
                        }
                    }
                }
            }
        }else{
            
            let alert = UIAlertController(title: "Failed to solve the sudoku", message: "Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)


        }
        
        
        
    }
    
    @IBAction func clickedClear(_ sender: Any) {
        for row in 0..<9{
            for col in 0..<9{
                if let foundView = stackView.viewWithTag(row * 9 + col + 1) {
                    
                    if let field = foundView as? UITextField{
                        
                        field.text = ""

                    }
                }
            }
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate{
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        guard let text = textField.text else { return true }
        if string == "0"{
            return false
        }else{
            let newLength = text.count + string.count - range.length
            return newLength <= 1
        }
        
    }

}
