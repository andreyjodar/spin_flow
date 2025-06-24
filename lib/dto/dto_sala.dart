class SalaDTO {
  final int? id;
  final String nome;
  final int capacidadeTotalBikes;
  final int numeroFilas;
  final int bikesPorFila;
  final bool ativo;

  SalaDTO({
    this.id,
    required this.nome,
    required this.capacidadeTotalBikes,
    required this.numeroFilas,
    required this.bikesPorFila,
    this.ativo = true,
  });
}