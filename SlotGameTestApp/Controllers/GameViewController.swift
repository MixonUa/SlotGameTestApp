//
//  GameViewController.swift
//  SlotGameTestApp
//
//  Created by Михаил Фролов on 11.06.2022.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var firstRow: UIStackView!
    @IBOutlet weak var secondRow: UIStackView!
    @IBOutlet weak var thirdRow: UIStackView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
    public let gradientScoreLabel = GradietnLabel()
    public var gameScoreAmount: Int = 500
    public var betAmount = 50
    public var gameItemsArray = [String]()
    
    private var winStreak = 0
    private var winItem = String()
    private var winAmount = 0
    private var winDict = [String:Int]()
    private var firstRandomArray = [String]()
    private var secondRandomArray = [String]()
    private var thirdRandomArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAlbumDeviceOrientation()
        configureGradientScoreLabel()
        updateBetLabel()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }

    //MARK: - ViewConfiguration
    
    public func setAlbumDeviceOrientation() {
        UIView.setAnimationsEnabled(false)
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(true)
    }

    private func configureGradientScoreLabel() {
        scoreView.addSubview(gradientScoreLabel)
        
        NSLayoutConstraint.activate([
            gradientScoreLabel.topAnchor.constraint(equalTo: scoreView.topAnchor, constant: 72),
            gradientScoreLabel.bottomAnchor.constraint(equalTo: scoreView.bottomAnchor),
            gradientScoreLabel.leadingAnchor.constraint(equalTo: scoreView.leadingAnchor),
            gradientScoreLabel.trailingAnchor.constraint(equalTo: scoreView.trailingAnchor)
        ])
    }
    
    private func updateBetLabel() {
        betLabel.text = "\(betAmount)"
    }
    
    //MARK: - RandomArrayActions
    
    private func generateRandomLineArrays() {
        for _ in 0...4 {
            let random = Int.random(in: 0...8)
            let imageName = gameItemsArray[random]
            firstRandomArray.append(imageName)
        }
        for _ in 0...4 {
            let random = Int.random(in: 0...8)
            let imageName = gameItemsArray[random]
            secondRandomArray.append(imageName)
        }
        for _ in 0...4 {
            let random = Int.random(in: 0...8)
            let imageName = gameItemsArray[random]
            thirdRandomArray.append(imageName)
        }
    }
    
    private func clearAllRandomArrays() {
        firstRandomArray.removeAll()
        secondRandomArray.removeAll()
        thirdRandomArray.removeAll()
    }
    
    //MARK: - GameLinesActions
    
    private func updateLine(row: UIStackView, array: [String]) {
        for item in array {
            let slotItem = SlotItemView(with: item)
            row.addArrangedSubview(slotItem)
        }
    }
    
    private func clearLine(row: UIStackView) {
        for view in row.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    
    private func clearAllLines() {
        clearLine(row: firstRow)
        clearLine(row: secondRow)
        clearLine(row: thirdRow)
    }
    
    private func updateAllLines() {
        updateLine(row: firstRow, array: firstRandomArray)
        updateLine(row: secondRow, array: secondRandomArray)
        updateLine(row: thirdRow, array: thirdRandomArray)
    }
    
    //MARK: - MoneyActions
    
    private func takeMoney() {
        gameScoreAmount -= betAmount
        gradientScoreLabel.updateScoreLabel(score: gameScoreAmount)
    }
    
    private func checkCombination(array: [String]) {
        winStreak = 0
        winItem = array.first ?? ""
        winDict = [:]
        
        array.forEach { item in
            if winItem == item {
                winStreak += 1
            }  else {
                if winStreak >= 3 {
                    winDict[winItem] = winStreak
                }
                winItem = item
                winStreak = 1
            }
        }
        if !winDict.isEmpty {
            print(winDict)
            for (item, streak) in winDict {
                let slotItem = SlotItemCost(winItem: item)
                let lineWin = slotItem.itemAmount*streak*(betAmount/5)
                winAmount += lineWin
                print(item)
                print(streak)
            }
        }
    }
    
    private func checkAllLinesCombinations() {
        checkCombination(array: firstRandomArray)
        checkCombination(array: secondRandomArray)
        checkCombination(array: thirdRandomArray)
        if winAmount > 0 {
            winLabel.text = "WIN: +\(winAmount)"
        } else { winLabel.text = "" }
        gameScoreAmount += winAmount
        gradientScoreLabel.updateScoreLabel(score: gameScoreAmount)
        winAmount = 0
    }
    
  //MARK: - Buttons
    
    @IBAction func spinButtonPressed(_ sender: Any) {
        takeMoney()
        clearAllRandomArrays()
        generateRandomLineArrays()
        checkAllLinesCombinations()
        clearAllLines()
        updateAllLines()
        if gameScoreAmount < betAmount {
            spinButton.isEnabled = false
        }
    }
    
    @IBAction func plusBetButtonPressed(_ sender: Any) {
        if betAmount <= 90 { betAmount += 10 } else { return }
        updateBetLabel()
        if gameScoreAmount < betAmount {
            spinButton.isEnabled = false
        } else {
            spinButton.isEnabled = true
        }
    }
    
    @IBAction func minusBetPuttonPressed(_ sender: Any) {
        if betAmount > 10 { betAmount -= 10 } else { return }
        updateBetLabel()
        if gameScoreAmount < betAmount {
            spinButton.isEnabled = false
        } else {
            spinButton.isEnabled = true
        }
    }
}
