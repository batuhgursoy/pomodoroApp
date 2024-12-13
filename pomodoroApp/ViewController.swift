//
//  ViewController.swift
//  pomodoroApp
//
//  Created by Batuhan Gürsoy on 13.12.2024.
//

import UIKit

class ViewController: UIViewController{
    
    var timer: Timer?
    var totalTime: TimeInterval = 0
    var remainingTime : TimeInterval = 0
@IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    @IBAction func timeButton(_ sender: Any) {
        showTimePicker()
    }
    
    func showTimePicker(){
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        let alertController = UIAlertController(title: "Saat ve Dakika Seçiniz", message: "\n\n\n", preferredStyle: .alert)
        alertController.view.addSubview(timePicker)
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    timePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 50),
                    timePicker.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -70),
                    timePicker.leftAnchor.constraint(equalTo: alertController.view.leftAnchor),
                    timePicker.rightAnchor.constraint(equalTo: alertController.view.rightAnchor)
                ])
       
        let selectAction = UIAlertAction(title: "Seç", style: .default) {
            _ in self.startCountdown(from: timePicker.countDownDuration)
            
        }
        alertController.addAction(selectAction)
                
                present(alertController, animated: true, completion: nil)
            }

            // Zaman değiştiğinde çalışacak fonksiyon
            @objc func timeChanged(datePicker: UIDatePicker) {
                let selectedTime = datePicker.countDownDuration
                print("Seçilen zaman: \(selectedTime)")
            }

            // Geri sayımı başlatma
            func startCountdown(from time: TimeInterval) {
                totalTime = time // Seçilen zaman
                remainingTime = totalTime // Başlangıçta kalan zaman, toplam zamanla eşit olur
                
                // Geri sayımı başlatıyoruz
                timer?.invalidate() // Önceki timer'ı durduruyoruz, eğer varsa
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
            }

            // Geri sayım her saniye güncelleniyor
            @objc func updateCountdown() {
                if remainingTime > 0 {
                    remainingTime -= 1 // Zamanı bir saniye azaltıyoruz
                    updateTimeLabel() // Zamanı ekranda güncelliyoruz
                } else {
                    timer?.invalidate() // Timer'ı durduruyoruz
                    showAlert("Zaman doldu!", message: "Alarm zamanı geldi.")
                }
            }

            // Geri sayımı ekran üzerinde güncelleme
            func updateTimeLabel() {
                let hours = Int(remainingTime) / 3600 // Saat hesaplama
                        let minutes = (Int(remainingTime) % 3600) / 60 // Dakika hesaplama
                        let seconds = Int(remainingTime) % 60 // Saniye hesaplama
                timeLabel.text = String(format: "%01d:%02d:%02d", hours, minutes,seconds)
            }

            // Zaman dolduğunda kullanıcıya bir uyarı göster
            func showAlert(_ title: String, message: String) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }

    
   


