//
//  ViewControllerdetalle.swift
//  Exmaen_IOS_JEgido
//
//  Created by Mañanas on 8/5/24.
//

import UIKit

class ViewControllerdetalle: UIViewController {
   // var parametro: String=""
   
    
    var peliculav: Peliculas? = nil
    var peliculasList: [Peliculas] = []
    
    @IBOutlet weak var lblpelicula: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var anio: UILabel!
    
    @IBOutlet weak var descripcion: UITextView!
    
    
    @IBOutlet weak var lbldirector: UILabel!
    
 
    @IBOutlet weak var lblciudad: UILabel!
    
    
    @IBOutlet weak var lblidioma: UILabel!
    
    
    @IBOutlet weak var lblgenero: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  lblpelicula.text = parametro.description
       
        self.navigationItem.title = peliculav?.Title
        lblpelicula.text = peliculav?.Title
      
        getpelisLlamar()
        
    }
    
    func getpelisLlamar() {
        Task {
            do {
               // peliculasList = try await getPeliculasAPI(name:lblpelicula.text!)
                peliculav = try await getPeliculasAPIDescrip(name:peliculav!.imdbID)
                
                guard let pelicula = peliculav else {
                    return
                }
               
                image.loadFrom(url: pelicula.Poster)
                anio.text=pelicula.Year
                descripcion.text=pelicula.Plot
                lblciudad.text=pelicula.Country
                lblgenero.text=pelicula.Genre
                lblidioma.text=pelicula.Language
                lbldirector.text=pelicula.Director
             
            }
            catch {
                print(error)
            }
        }
    }

}
