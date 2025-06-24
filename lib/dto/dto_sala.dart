
class SalaDTO {
  int? id;
  String nome;
  int capacidadeTotalBikes;
  int numeroFilas;
  int numeroBikesPorFila;
  bool ativo;

  SalaDTO({
    int? id,
    required this.nome,
    required this.capacidadeTotalBikes,
    required this.numeroFilas,
    required this.numeroBikesPorFila,
    required this.ativo,
  });
}
