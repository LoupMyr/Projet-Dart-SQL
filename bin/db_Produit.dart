import 'produit.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:developer';

class DbProduit {
  static Future<Produit> selectProduit(
      ConnectionSettings settings, int id) async {
    Produit pro = Produit.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Produit WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Produit WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        pro = Produit(
          reponse.first['id'],
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

  static Future<Produit> selectAuteur(
      ConnectionSettings settings, int id) async {
    Produit pro = Produit.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Produit WHERE auteur=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Produit WHERE auteur=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        pro = Produit(
          reponse.first['id'],
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

  static Future<Produit> selectEditeur(
      ConnectionSettings settings, int id) async {
    Produit pro = Produit.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Produit WHERE editeur=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Produit WHERE editeur=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        pro = Produit(
          reponse.first['id'],
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

  static Future<List<Produit>> selectAllProduits(
      ConnectionSettings settings) async {
    List<Produit> listeProduit = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Produit;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          Produit pro = Produit(row['id'], row['titre'], row['auteur'],
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

  static Future<void> insertProduit(ConnectionSettings settings, String titre,
      int idAuteur, int idEditeur, String type, int prix, int nbDispo) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete =
            "INSERT INTO Produit (titre, auteur, editeur, type, prix, nbDispo) VALUES('" +
                titre +
                "', " +
                idAuteur.toString() +
                ", " +
                idEditeur.toString() +
                ", '" +
                type +
                "', " +
                prix.toString() +
                ", " +
                nbDispo.toString() +
                ");";
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
  static Future<void> updateProduit(
      ConnectionSettings settings,
      int id,
      String titre,
      int idAuteur,
      int idEditeur,
      String type,
      int prix,
      int nbDispo) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "UPDATE Produit SET titre = '" +
            titre +
            "', auteur = " +
            idAuteur.toString() +
            ", editeur = " +
            idEditeur.toString() +
            ", type = '" +
            type +
            "', prix = " +
            prix.toString() +
            ", nbDispo = " +
            nbDispo.toString() +
            " WHERE id=" +
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

  //delete
  static Future<void> deleteProduit(ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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
  static Future<void> deleteAllProduit(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  // verifie l'existance d'un produit selon son ID
  static Future<bool> exist(ConnectionSettings settings, int id) async {
    bool exist = false;
    if (!(await DbProduit.selectProduit(settings, id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // getProduit
  static Future<Produit> getProduit(ConnectionSettings settings, int id) async {
    dynamic r = await selectProduit(settings, id);
    ResultRow rr = r.first;
    return Produit(rr['id'], rr['titre'], rr['auteur'], rr['editeur'],
        rr['type'], rr['prix'], rr['nbDispo']);
  }
}
