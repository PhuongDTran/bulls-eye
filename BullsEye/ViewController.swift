//
//  ViewController.swift
//  BullsEye
//
//  Created by Phuong Tran on 11/17/20.
//

import UIKit

class ViewController: UIViewController {
    var _currentValue = 0
    var _targetValue = 0
    var _score = 0
    var _round = 0
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(
          named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }
    
    @IBAction func showAlert() {
        let difference = abs(_currentValue - _targetValue)
        var points = 100 - difference
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        _score += points
        let message = "You scored \(points) points"
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {_ in
                self.startNewRound()
            })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        _currentValue = lroundf(slider.value)
    }
    
    @IBAction func startNewGame() {
        _score = 0
        _round = 0
        startNewRound()
    }
    func startNewRound() {
        _targetValue = Int.random(in: 1...100)
        _currentValue = 50
        slider.value = Float(_currentValue)
        _round+=1
        updateLabels()
    }
    func updateLabels() {
        targetLabel.text = String(_targetValue)
        scoreLabel.text = String(_score)
        roundLabel.text = String(_round)
    }
}

