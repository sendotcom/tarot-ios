//
//  ViewController.swift
//  Tarot Rapido
//
//  Created by H.Gio on 08/04/22.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableView: UITableView!
    
    var cardList = [Cartas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initList()
        
    }
    
    func initList(){
        
        let cartasJson = loadJson(filename: "Cartas")
        
        //print(cartasJson!)
        
        cardList = cartasJson!
    }
    
   
    
    
    func loadJson(filename fileName: String) -> [Cartas]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Cartas].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cardList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let thisCarta = cardList[indexPath.row]
        
        tableViewCell.nombreCarta.text = thisCarta.name
        tableViewCell.imagenCarta.image =  UIImage(named: thisCarta.img)
        
        return tableViewCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "cartaDetallesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "cartaDetallesSegue"){
            let indexPath = self.TableView.indexPathForSelectedRow!
            
            let tableViewDetail = segue.destination as? CartaDetalles
            
            let selectCard = cardList[indexPath.row]
            
            tableViewDetail?.cartaSeleccionada = selectCard
            
            self.TableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

