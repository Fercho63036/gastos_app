/********************************* FEATURE **********************************/
import '../constants/inicio_strings.dart';

enum PeriodoFiltro {
  hoy(InicioStrings.hoy),
  semana(InicioStrings.semana),
  mes(InicioStrings.mes);

  final String etiqueta;

  const PeriodoFiltro(this.etiqueta);
}
