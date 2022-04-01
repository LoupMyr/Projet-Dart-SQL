import 'package:mysql1/mysql1.dart';

import 'IHM_P.dart';

void main(List<String> arguments) async {
  IhmPrincipale.afficherAccueil();
  ConnectionSettings settings = await IhmPrincipale.setting();
  IhmPrincipale.afficherChoixTable(settings);
  IhmPrincipale.goodbye();
}
