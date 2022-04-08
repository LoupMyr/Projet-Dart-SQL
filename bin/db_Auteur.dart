import 'dart:developer';
import 'package:mysql1/mysql1.dart';
import 'auteur.dart';
import 'db_Config.dart';

class DbAuteur {
  // Permet de sélectionner un auteur précis selon son ID
  static Future<Auteur> selectAuteur(
      ConnectionSettings settings, int id) async {
    Auteur aut = Auteur.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Auteur WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Auteur WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        aut = Auteur(
            reponse.first['id'], reponse.first['nom'], reponse.first['prenom']);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return aut;
  }

  // Permet de sélectionner tous les auteurs
  static Future<List<Auteur>> selectAllAuteur(
      ConnectionSettings settings) async {
    List<Auteur> listeAut = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Auteur;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          Auteur aut = Auteur(row['id'], row['nom'], row['prenom']);
          listeAut.add(aut);
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return listeAut;
  }

  // Permet d'insérer un auteur dans la table
  static Future<void> insertAuteur(
      ConnectionSettings settings, String nom, String prenom) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "INSERT INTO Auteur (nom, prenom) VALUES('" +
            nom +
            "', '" +
            prenom +
            "');";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // Permet de modifier un auteur dans la table selon son ID
  static Future<void> updateAuteur(
      ConnectionSettings settings, int id, String nom, String prenom) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "UPDATE Auteur SET nom = '" +
            nom +
            "', prenom = '" +
            prenom +
            "' WHERE id=" +
            id.toString() +
            ";";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //Permet de supprimer un auteur dans la table selon son ID
  static Future<void> deleteAuteur(ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "DELETE FROM Auteur WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //Permet de supprimer tous les auteurs de la table
  static Future<void> deleteAllAuteurs(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "DELETE FROM Auteur;";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // verifie l'existance d'un auteur selon son ID
  static Future<bool> exist(ConnectionSettings settings, int id) async {
    bool exist = false;
    if (!(await DbAuteur.selectAuteur(settings, id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  //récupére un auteur
  static Future<Auteur> getAuteur(ConnectionSettings settings, int id) async {
    dynamic r = await selectAuteur(settings, id);
    ResultRow rr = r.first;
    return Auteur(rr['id'], rr['nom'], rr['prenom']);
  }
}
