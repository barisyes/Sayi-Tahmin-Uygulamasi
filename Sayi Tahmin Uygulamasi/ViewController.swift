//
//  ViewController.swift
//  Sayi Tahmin Uygulamasi
//
//  Created by Barış Yeşilkaya on 17.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtTahminEdilecekSayi: UITextField!
    @IBOutlet weak var imgKaydet: UIImageView!
    @IBOutlet weak var btnKaydet: UIButton!
    
    @IBOutlet weak var txtTahminSayi: UITextField!
    @IBOutlet weak var imgTahminDurum: UIImageView!
    @IBOutlet weak var btnDene: UIButton!
    
    @IBOutlet weak var imgYildiz1: UIImageView!
    @IBOutlet weak var imgYildiz2: UIImageView!
    @IBOutlet weak var imgYildiz3: UIImageView!
    @IBOutlet weak var imgYildiz4: UIImageView!
    @IBOutlet weak var imgYildiz5: UIImageView!
    
    @IBOutlet weak var lblSonuc: UILabel!
    
    var yildizlar : [UIImageView] = [UIImageView]() //yıldızları dizi halinde tutar
    var maxDenemeSayisi : Int = 5                   //kullanının yapabileceği max deneme sayısı
    var denemeSayisi : Int = 0                     //kullanıcının yaptığı deneme sayısı
    var hedefSayi : Int = -1                        //tahmin edilmesi gereken sayı
    var oyunBasarili : Bool = false                 //kullanıcının tahmin sonucu
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imgKaydet.isHidden = true
        imgTahminDurum.isHidden = true
        btnDene.isEnabled = false
        lblSonuc.text = ""
        txtTahminEdilecekSayi.isSecureTextEntry = true
        txtTahminSayi.isEnabled = false
        yildizlar = [imgYildiz1, imgYildiz2, imgYildiz3, imgYildiz4, imgYildiz5]
        
    }
    
    

    @IBAction func btnKaydetClicked(_ sender: UIButton) {
        
        txtTahminSayi.isEnabled = true
        imgKaydet.isHidden = false
        if let t = Int(txtTahminEdilecekSayi.text!){
            hedefSayi = t
            btnDene.isEnabled = true
            txtTahminEdilecekSayi.isEnabled = false
            btnKaydet.isEnabled = false
            imgKaydet.image = UIImage(named: "onay")
        }
        else
        {
            imgKaydet.image = UIImage(named: "hata")
        }
        
    }
    
    @IBAction func btnDeneClicked(_ sender: UIButton) {
        if oyunBasarili == true || denemeSayisi > maxDenemeSayisi
        {
            return
        }
        
        imgTahminDurum.isHidden = false
        
        if let girilenSayi = Int(txtTahminSayi.text!)
        {
            //kullanıcı dogru format girerse
            denemeSayisi += 1
            yildizlar[denemeSayisi-1].image = UIImage(named: "beyazYildiz")
            
            if girilenSayi > hedefSayi
            {
                imgTahminDurum.image = UIImage(named: "asagi")
                txtTahminSayi.backgroundColor = UIColor.red
            }
            else if girilenSayi < hedefSayi
            {
                imgTahminDurum.image = UIImage(named: "yukari")
                txtTahminSayi.backgroundColor = UIColor.red
            }
            else
            {
                imgTahminDurum.image = UIImage(named: "okey")
                txtTahminSayi.backgroundColor = UIColor.green
                lblSonuc.text = "DOGRU BİLDİNİZ!!!"
                oyunBasarili = true
                txtTahminEdilecekSayi.isSecureTextEntry = false
                btnDene.isEnabled = false
                
                let alertController = UIAlertController(title: "BAŞARILI", message: "Doğru tahmin ettiniz.", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                
                let playAgainAction = UIAlertAction(title: "Yeniden Dene", style: UIAlertAction.Style.default)
                {
                    (action : UIAlertAction) in
                    self.imgKaydet.isHidden = true
                    self.imgTahminDurum.isHidden = true
                    self.btnDene.isEnabled = false
                    self.lblSonuc.text = ""
                    self.txtTahminEdilecekSayi.isSecureTextEntry = true
                    self.denemeSayisi = 0
                    self.hedefSayi = -1
                    self.oyunBasarili = false
                    self.txtTahminSayi.text = ""
                    self.txtTahminEdilecekSayi.text = ""
                    self.txtTahminEdilecekSayi.isEnabled = true
                    self.txtTahminSayi.isEnabled = false
                    self.btnKaydet.isEnabled = true
                    self.btnDene.isEnabled = false
                    self.txtTahminSayi.backgroundColor = UIColor.white
                    
                }
                
                alertController.addAction(playAgainAction)
                
                alertController.addAction(okAction)
                
                present(alertController, animated: true, completion: nil)
                return
            }
        }
        else
        {
            //kullanıcı yanlış format girerse
            imgTahminDurum.image = UIImage(named: "hata")
        }
        
        if denemeSayisi == maxDenemeSayisi
        {
            //oyun başarısızlıkla sonuçlanmıştır.
            btnDene.isEnabled = false
            lblSonuc.text = "YANLIŞ TAHMİN!!! \n Doğru sayı : \(hedefSayi)"
            txtTahminSayi.isSecureTextEntry = false
            
            let alertController = UIAlertController(title: "BAŞARISIZ", message: "Doğru tahmin edemediniz.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil)
            
            let playAgainAction = UIAlertAction(title: "Yeniden Dene", style: UIAlertAction.Style.default)
            {
                (action : UIAlertAction) in
                self.imgKaydet.isHidden = true
                self.imgTahminDurum.isHidden = true
                self.btnDene.isEnabled = false
                self.lblSonuc.text = ""
                self.txtTahminEdilecekSayi.isSecureTextEntry = true
                self.denemeSayisi = 0
                self.hedefSayi = -1
                self.oyunBasarili = false
                self.txtTahminSayi.text = ""
                self.txtTahminEdilecekSayi.text = ""
                self.txtTahminEdilecekSayi.isEnabled = true
                self.txtTahminSayi.isEnabled = false
                self.btnKaydet.isEnabled = true
                self.btnDene.isEnabled = false
                self.txtTahminSayi.backgroundColor = UIColor.white
            }
            
            alertController.addAction(playAgainAction)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
            
            return
        }
    }
    
    

}

