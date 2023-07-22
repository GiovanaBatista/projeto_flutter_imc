class IMcModel {
  IMcModel({required this.peso, required this.altura, required this.mensagem});

  final double peso;

  final double altura;
  final String mensagem;

  factory IMcModel.fromJson(Map<String, dynamic> json) => IMcModel(
        altura: json['altura'],
        peso: json['peso'],
        mensagem: json['mensagem'],
      );

  @override
  String toString() {
    return 'Altura: $altura, Peso: $peso';
  }
}
