//
//  LaunchViewController.swift
//  SlotGameTestApp
//
//  Created by Михаил Фролов on 06.02.2024.
//

import UIKit

class LaunchViewController: UIViewController {
    @IBOutlet weak var loadingLine: UIProgressView!
    
    private var progressBarTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingLine.progress = 0.3
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateProgressView), userInfo: nil, repeats: true)
    }
    
    @objc private func updateProgressView(){
        loadingLine.progress += 0.1
        loadingLine.setProgress(loadingLine.progress, animated: true)
        if(loadingLine.progress == 1.0)
        {
            self.presentVC()
        }
    }
    
    private func presentVC() {
        guard let nextVC = storyboard?.instantiateViewController(identifier: "MainViewController") as? MainViewController else { return }
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
}
