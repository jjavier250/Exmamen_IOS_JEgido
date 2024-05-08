//
//  ViewController.swift
//  Exmaen_IOS_JEgido
//
//  Created by Mañanas on 8/5/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    //var list:[String]=["Pelicula1","Pelicula2"]
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var txtbuscar: UITextField!
    
    @IBOutlet weak var btnbuscar: UIButton!
    
    var list : [Peliculas] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource=self
        tableView.delegate=self
        
        getPeliculasLlamar()
    }
    
    
    func getPeliculasLlamar() {
        Task {
            do {
                list = try await getPeliculasAPI(name:"america")
                print(list)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
             
            }
            catch {
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewCell
        
         let pelicula = list[indexPath.row]
        // cell.lbltexto.text=list[indexPath.row]
        
        cell.lbltexto.text = pelicula.Title
        cell.anio.text = pelicula.Year
        
    
        cell.imagen.loadFrom(url: pelicula.Poster)
        
         return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
        
       // let lista=list[ruta.row]
        //let viewControler:ViewControllerdetalle=segue.destination as! ViewControllerdetalle
        
      //  viewControler.parametro = lista.description
      
        
        guard let ruta=tableView.indexPathForSelectedRow else {
            print("Pelicula no seleccionado")
            return
        }
        
        let pelicula=list[ruta.row]
        let viewControler:ViewControllerdetalle=segue.destination as! ViewControllerdetalle
        
        
        //viewControler.superheroe=superHeroe
        viewControler.peliculav=pelicula
        
        
        
    }


    @IBAction func btnbuscar(_ sender: Any) {
        
        getPeliculasLlamarBusqueda(peli: txtbuscar.text!.description)
    }
    
    
    func getPeliculasLlamarBusqueda(peli:String) {
        Task {
            do {
                list = try await getPeliculasAPI(name:peli)
                print(list)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
             
            }
            catch {
                print(error)
            }
        }
    }
}

