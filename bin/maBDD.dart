import 'package:mysql1/mysql1.dart';

class maBDD {
  MySqlConnection conn;
  ConnectionSettings settings = ConnectionSettings(
    host: "localhost",
    port: 3306,
    user: "DemoUser",
    password: "demomdp",
    db: "demo",
  );

  void connect() async {
    print("debut");
    MySqlConnection conn = await MySqlConnection.connect(settings);
    print("Connexion");
  }

  void disconnect() {
    conn.close();
    print("Déconexion");
  }
}
