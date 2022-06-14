//
//  MainViewController.swift
//  SlotGameTestApp
//
//  Created by Михаил Фролов on 11.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lightninGameButton: UIButton!
    @IBOutlet weak var candleGameButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var popularContainer: UIView!
    @IBOutlet weak var allContainer: UIView!
    
    private var scoreAmount = 500
    private let popularGamesButton = FilterButton()
    private let allGamesButton = FilterButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = UIColor(red: 0.101, green: 0.097, blue: 0.116, alpha: 1).cgColor

        configureFilterButtons()
        hideNonPopularGames()
        updateScoreLabel()
    }
    
    //MARK: - ViewConfiguration
    
    private func setPortraitDeviceOrientation() {
        UIView.setAnimationsEnabled(false)
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(true)
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "\(scoreAmount)"
    }
    
    //MARK: - Buttons
    
    @IBAction func fairyButtonPressed(_ sender: UIButton) {
        goToGameViewController(sender: sender)
    }
    
    @IBAction func lightninButtonPressed(_ sender: UIButton) {
        goToGameViewController(sender: sender)
    }
    
    @IBAction func candleButtonPressed(_ sender: UIButton) {
        goToGameViewController(sender: sender)
    }
    
    @objc private func popularGamesButtonDidPressed(sender: FilterButton) {
        print("popularGamesButtonDidPressed")
        sender.setActive()
        allGamesButton.setInactive()
        hideNonPopularGames()
    }
    
    @objc private func allGamesButtonDidPressed(sender: FilterButton) {
        print("allGamesButtonDidPressed")
        sender.setActive()
        popularGamesButton.setInactive()
        showNonPopularGames()
        }
    
    //MARK: - ButtonsConfiguration
    
    private func configureFilterButtons() {
        popularContainer.addSubview(popularGamesButton)
        popularGamesButton.setTitle("Popular", for: .normal)
        popularGamesButton.addTarget(self, action: #selector(popularGamesButtonDidPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            popularGamesButton.topAnchor.constraint(equalTo: popularContainer.topAnchor),
            popularGamesButton.bottomAnchor.constraint(equalTo: popularContainer.bottomAnchor),
            popularGamesButton.leadingAnchor.constraint(equalTo: popularContainer.leadingAnchor),
            popularGamesButton.trailingAnchor.constraint(equalTo: popularContainer.trailingAnchor)
        ])
        
        allContainer.addSubview(allGamesButton)
        allGamesButton.setTitle("All Games", for: .normal)
        allGamesButton.setInactive()
        allGamesButton.addTarget(self, action: #selector(allGamesButtonDidPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            allGamesButton.topAnchor.constraint(equalTo: allContainer.topAnchor),
            allGamesButton.bottomAnchor.constraint(equalTo: allContainer.bottomAnchor),
            allGamesButton.leadingAnchor.constraint(equalTo: allContainer.leadingAnchor),
            allGamesButton.trailingAnchor.constraint(equalTo: allContainer.trailingAnchor)
        ])
        
    }
    
    private func hideNonPopularGames() {
        lightninGameButton.isHidden = true
        candleGameButton.isHidden = true
    }
    
    private func showNonPopularGames() {
        lightninGameButton.isHidden = false
        candleGameButton.isHidden = false
    }
    
    //MARK: - Navigation
    private func goToGameViewController(sender: UIButton) {
        guard let gameVC = storyboard?.instantiateViewController(identifier: "GameViewController") as? GameViewController else { return }
        self.present(gameVC, animated: true, completion: nil)
        gameVC.gameScoreAmount = scoreAmount
        gameVC.gradientScoreLabel.updateScoreLabel(score: gameVC.gameScoreAmount)
        
        if gameVC.gameScoreAmount < gameVC.betAmount {
            gameVC.spinButton.isEnabled = false
        }
        
        let gameSet = SlotGameItemsSet()
        if sender.accessibilityIdentifier == "FairyGameButton" {
            gameVC.gameItemsArray = gameSet.firstGameSet
        } else if sender.accessibilityIdentifier == "LightninGameButton" {
            gameVC.gameItemsArray = gameSet.secondGameSet
        } else if sender.accessibilityIdentifier == "CandleGameButton" {
            gameVC.gameItemsArray = gameSet.thirdGameSet
        }
    }

    @IBAction func updateScoreLabel(_ unwindSegue: UIStoryboardSegue) {
        guard let gameVC = unwindSegue.source as? GameViewController else { return }
        setPortraitDeviceOrientation()
        self.scoreAmount = gameVC.gameScoreAmount
        updateScoreLabel()
    }
}
