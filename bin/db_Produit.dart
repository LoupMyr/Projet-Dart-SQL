import 'auteur.dart';
import 'editeur.dart';
import 'produit.dart';
import 'package:mysql1/mysql1.dart';
import 'db_Config.dart';
import 'dart:developer';

class DbProduit {
  static Future<Produit> selectProduit(int id) async {
    Produit pro = Produit.vide();
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SELECT * FROM Produit WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Produit WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        pro = Produit(
          reponse.first['idP'],
          reponse.first['titre'],
          reponse.first['auteur'],
          reponse.first['editeur'],
          reponse.first['type'],
          reponse.first['prix'],
          reponse.first['nbDispo'],
        );
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return pro;
  }

  static Future<List<Produit>> selectAllProduit() async {
    List<Produit> listeProduit = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SELECT * FROM Produit;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          Produit pro = Produit(row['idP'], row['titre'], row['auteur'],
              row['editeur'], row['type'], row['prix'], row['nbDispo']);
          listeProduit.add(pro);
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return listeProduit;
  }

  static Future<void> insertProduit(String titre, Auteur auteur,
      Editeur editeur, String type, int prix, int nbDispo) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete =
            "INSERT INTO Produit (titre, auteur, editeur, type, prix, nbDispo) VALUES('" +
                titre +
                "', '" +
                auteur.toString() +
                "', '" +
                editeur.toString() +
                "', '" +
                type +
                "',, '" +
                prix.toString() +
                "',, '" +
                nbDispo.toString() +
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

  //update
  static Future<void> updateProduit(int id, String titre, Auteur auteur,
      Editeur editeur, String type, int prix, int nbDispo) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "UPDATE Produit SET titre = '" +
            titre +
            "', auteur = '" +
            auteur.toString() +
            "', editeur = '" +
            editeur.toString() +
            "', type = '" +
            type +
            "', prix = '" +
            prix.toString() +
            "', nbDispo = '" +
            nbDispo.toString() +
            "' WHERE id='" +
            id.toString() +
            "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //delete
  static Future<void> deleteProduit(int id) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "DELETE FROM Produit WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //delete all
  static Future<void> deleteAllProduit() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "DELETE FROM Produit;";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // verifie l'existance d'un etudiant selon son ID
  static Future<bool> exist(int id) async {
    bool exist = false;
    if (!(await DbProduit.selectProduit(id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // getEtudiant
  static Future<Produit> getProduit(int id) async {
    dynamic r = await selectProduit(id);
    ResultRow rr = r.first;
    return Produit(rr['idD'], rr['titre'], rr['auteur'], rr['editeur'],
        rr['type'], rr['prix'], rr['nbDispo']);
  }
}
